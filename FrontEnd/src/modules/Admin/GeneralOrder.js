import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {createForm} from 'rc-form';
import {HeadTitle} from './../../components/Index'

import {
    Card,
    WingBlank,
    WhiteSpace,
    Badge,
    Button,
    List,
    NavBar, Picker,
    Icon,
    Toast,
    Modal,
    InputItem,
    ListView, DatePicker, RefreshControl

} from 'antd-mobile';
import '../../styles/modules/Admin/General.less'
import moment from 'moment'
import qs from 'qs'

const Item = List.Item;
const Brief = Item.Brief;

function MyList(props) {
    return (
        <div>
            <WingBlank size="lg">
                {props.children}
            </WingBlank>
        </div>
    );
}

const prompt = Modal.prompt;

@inject('repairStore', 'generalStore', 'userStore', 'adminMyGeneralOrderStore')
@observer
class GeneralList extends Component {
    constructor(props) {
        super(props);
        this.store = {
            repairStore: props.repairStore,
            generalStore: props.generalStore,
            userStore: props.userStore,
            adminMyGeneralOrderStore: props.adminMyGeneralOrderStore
        };
    }

    componentDidMount() {
        this.store.repairStore.getRegion();
        this.store.generalStore.getCategory();
        this.store.adminMyGeneralOrderStore.resetRepairList();
        this.store.adminMyGeneralOrderStore.getRepair();
    }


    search = () => {
        let data = this.props.form.getFieldsValue();

        if (data.start_time) {
            data.start_time = data.start_time.format('X')
        }

        if (data.end_time) {
            data.end_time = data.end_time.format('X')
        }
        this.store.adminMyGeneralOrderStore.resetRepairList();
        this.store.adminMyGeneralOrderStore.getRepair(data);
    };

    repairStatus = (status) => {
        switch (status) {
            case -1:
                return 'del-order';
                break;
            case 0:
                return 'not-order';
                break;
            case 1:
                return 'processing';
                break;
            case 2:
                return 'complete';
                break;
            default:
                return 'not-order';
        }
    };

    repairStatusTitle = (status) => {
        switch (status) {
            case -1:
                return '已撤销';
                break;
            case 0:
                return '未接单';
                break;
            case 1:
                return '处理中';
                break;
            case 2:
                return '已完成';
                break;
            default:
                return '未接单';
        }
    };

    reset = () => {
        this.props.form.resetFields();
        this.store.adminMyGeneralOrderStore.resetRepairList();
        this.store.adminMyGeneralOrderStore.getRepair();
    };

    complete = (id) => {
        Toast.loading('正在完成中~~', 0);
        this.axios.post('/XRepair/BackEnd/public/service/admin/complete', qs.stringify({id})).then((res) => {
            let data = res.data;
            if (data.code == 200) {
                Toast.success(data.message, 1, this.reset);
            } else {
                Toast.fail(data.message, 1.5);
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5)
        });
    };

    feedback = (id) => {
        prompt('反馈信息', '请输入你维修的情况',
            [
                {text: '取消'},
                {
                    text: '提交',
                    onPress: feedback => {
                        Toast.loading('正在提交中~~', 0);
                        this.axios.post('/XRepair/BackEnd/public/service/admin/feedback', qs.stringify({
                            id,
                            feedback
                        })).then((res) => {
                            let data = res.data;
                            if (data.code == 200) {
                                Toast.success(data.message, 1, this.reset);
                            } else {
                                Toast.fail(data.message, 1.5);
                            }
                        }).catch((e) => {
                            Toast.offline(e.message, 1.5)
                        });
                    },
                },
            ], 'default', null, ['请输入反馈信息'])
    };

    render() {

        const btnStatus = (status, id, feedback) => {
            switch (status) {
                case 1:
                    return <Button type="primary" inline size="small" onClick={() => this.complete(id)}>完成</Button>;
                case 2:
                    return <Button type="primary" inline size="small"
                                   onClick={() => this.feedback(id)}>{feedback ? '更新反馈' : '反馈'}</Button>
            }
        };

        const row = (rowData, sectionID, rowID) => {
            return (
                <div key={rowID}>
                    <Card>
                        <Card.Header
                            title={moment(rowData.create_time * 1000).format('YYYY-MM-D hh:mm')}
                            extra={<Badge text={this.repairStatusTitle(rowData.status)}
                                          className={this.repairStatus(rowData.status) + " am-badge-45 "}
                            />}
                        />
                        <Card.Body>
                            <List>
                                <Item extra={rowData.id + rowData.name}>姓名</Item>
                                <Item extra={rowData.mobile}>手机号码</Item>
                                <Item extra={rowData.address}>区域</Item>
                                <Item extra={rowData.cate}>类型</Item>
                                <Item extra={rowData.desc}>描述</Item>
                            </List>
                        </Card.Body>
                        <Card.Footer content={btnStatus(rowData.status, rowData.id, rowData.feedback)}
                                     extra={<Button inline size="small">查看</Button>}/>
                    </Card>
                    <WhiteSpace size="lg"/>
                </div>
            );
        };


        const header = () => {
            return (
                <div>
                    <List renderHeader={() => '数据筛选'}>
                        <Picker data={[{label: '全部', value: 0}, ...regionList]}
                                cols={regionCols} {...getFieldProps('regions', {
                            initialValue: [0],
                        })}>
                            <Item arrow="horizontal"><strong>区域</strong></Item>
                        </Picker>
                        <Picker data={[{label: '全部', value: 0}, ...categoryList]}
                                cols={categoryCols} {...getFieldProps('categorys', {
                            initialValue: [0],
                        })}>
                            <Item arrow="horizontal"><strong>选择报修项目</strong></Item>
                        </Picker>
                        <Picker data={[{label: '全部', value: 0}, {label: '未接单', value: 1}, {
                            label: '处理中',
                            value: 2
                        }, {label: '完成', value: 3}]} cols="1" {...getFieldProps('status', {
                            initialValue: [0],
                        })}>
                            <Item arrow="horizontal"><strong>状态</strong></Item>
                        </Picker>
                        <DatePicker {...getFieldProps('start_time')} title="选择开始时间" extra="可选">
                            <List.Item arrow="horizontal"><strong>开始时间</strong></List.Item>
                        </DatePicker>
                        <DatePicker {...getFieldProps('end_time')} title="选择结束时间" extra="可选">
                            <List.Item arrow="horizontal"><strong>结束时间</strong></List.Item>
                        </DatePicker>
                        <InputItem
                            {...getFieldProps('name')}
                            clear
                            placeholder="搜索姓名(可选)"
                        ><strong>姓名</strong></InputItem>
                        <Item>
                            <Button type="primary" onClick={this.search} size="small" inline>搜索</Button>
                            <Button size="small" inline style={{marginLeft: '0.2rem'}}
                                    onClick={() => resetFields()}>重置</Button>
                        </Item>
                    </List>
                    <HeadTitle title="报修列表"/>
                </div>
            );
        };
        const {history} = this.props;

        const {getFieldProps, resetFields} = this.props.form;
        const {regionList, regionCols} = this.store.repairStore;
        const {categoryList, categoryCols} = this.store.generalStore;
        return (
            <div id="admin-general">

                <ListView
                    ref="lv"
                    dataSource={this.store.adminMyGeneralOrderStore.repairListDataSource}
                    renderRow={row}
                    renderFooter={() => (<div style={{padding: 30, textAlign: 'center'}}>
                        {this.store.adminMyGeneralOrderStore.hasMore ? this.store.adminMyGeneralOrderStore.isLoading ? '正在加载...' : '上拉加载' : '没有数据了'}
                    </div>)}
                    renderHeader={header}
                    pageSize={10}
                    removeClippedSubviews={false}
                    scrollRenderAheadDistance={500}
                    scrollEventThrottle={200}
                    onEndReachedThreshold={10}
                    renderBodyComponent={() => <MyList/>}
                    initialListSize={0}
                    style={{
                        height: document.documentElement.clientHeight,
                        margin: '0.1rem 0',
                    }}
                    onEndReached={() => this.store.adminMyGeneralOrderStore.getRepair()}
                    scrollerOptions={{scrollbars: true}}
                    refreshControl={<RefreshControl
                        refreshing={this.store.adminMyGeneralOrderStore.refreshing}
                        onRefresh={() => {
                            this.store.adminMyGeneralOrderStore.onRefresh();
                            this.props.form.resetFields()
                        }}
                    />}
                />
            </div>
        );
    }
}

export default createForm()(GeneralList);