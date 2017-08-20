import React, {Component} from 'react'
import {observer,inject} from 'mobx-react';
import {createForm} from 'rc-form';

import {
    Card,
    WingBlank,
    WhiteSpace,
    Badge,
    Button,
    List,
    NavBar,Picker,
    Icon,
    Menu,
    InputItem,
    ListView,DatePicker

} from 'antd-mobile';
import '../../styles/modules/Admin/General.less'

const Item = List.Item;

@inject('repairStore', 'generalStore', 'userStore','adminStore')
@observer
class General extends Component {
    constructor(props) {
        super(props);
        this.store = {
            repairStore: props.repairStore,
            generalStore: props.generalStore,
            userStore: props.userStore,
            adminStore:props.adminStore
        };
    }

    componentDidMount() {
        this.store.repairStore.getRegion();
        this.store.generalStore.getCategory();
    }


    render() {
        const {getFieldProps,resetFields} = this.props.form;
        const {regionList, regionCols} = this.store.repairStore;
        const {categoryList, categoryCols} = this.store.generalStore;
        return (
            <div id="admin-general">
                <div>
                    <List renderHeader={() => '数据筛选'}>
                        <Picker data={[{label:'全部',value:0},...regionList]} cols={regionCols} {...getFieldProps('regions', {
                            initialValue: [0],
                        })}>
                            <Item arrow="horizontal">区域</Item>
                        </Picker>
                        <Picker data={[{label:'全部',value:0},...categoryList]} cols={categoryCols} {...getFieldProps('categorys', {
                            initialValue: [0],
                        })}>
                            <Item arrow="horizontal">选择报修项目</Item>
                        </Picker>
                        <Picker data={[{label:'全部',value:0},{label:'未接单',value:1},{label:'处理中',value:2},{label:'完成',value:3}]} cols="1" {...getFieldProps('status', {
                            initialValue: [0],
                        })}>
                            <Item arrow="horizontal">状态</Item>
                        </Picker>
                        <DatePicker {...getFieldProps('star_time')} title="选择开始时间" extra="可选">
                            <List.Item arrow="horizontal">开始时间</List.Item>
                        </DatePicker>
                        <DatePicker {...getFieldProps('end_time')} title="选择结束时间" extra="可选">
                            <List.Item arrow="horizontal" >结束时间</List.Item>
                        </DatePicker>
                        <InputItem
                            {...getFieldProps('name')}
                            clear
                            placeholder="搜索姓名(可选)"
                        >姓名</InputItem>
                        <Item>
                            <Button type="primary" size="small" inline >搜索</Button>
                            <Button size="small" inline style={{ marginLeft: '0.05rem' }} onClick={()=>resetFields()}>重置</Button>
                        </Item>
                    </List>
                </div>


                <WhiteSpace size="lg"/>
                <Card>
                    <Card.Header
                        title="2017-08-20 03:07"
                        extra={<Badge text="自动缴费"
                                      style={{
                                          marginLeft: 12,
                                          padding: '0 0.06rem',
                                          backgroundColor: '#fff',
                                          borderRadius: 2,
                                          color: '#f19736',
                                          border: '1px solid #f19736',
                                      }}
                        />}
                    />
                    <Card.Body>
                        <List renderHeader={() => '报修信息'} className="my-list">
                            <Item extra={'extra content'}>姓名</Item>
                            <Item extra={'extra content'}>区域</Item>
                            <Item extra={'extra content'}>类型</Item>
                            <Item extra={'extra content'}>描述</Item>
                        </List>
                    </Card.Body>
                    <Card.Footer content={<Button type="primary" inline size="small">接单</Button>}
                                 extra={<Button type="primary" inline size="small">查看</Button>}/>
                </Card>
                <WhiteSpace size="lg"/>
            </div>
        );
    }
}

export default createForm()(General);