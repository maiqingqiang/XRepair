import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, Badge, RefreshControl, ListView} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import './../styles/pages/RepairList.less'
import moment from 'moment'

const Item = List.Item;
const Brief = Item.Brief;


@inject('repairStore')
@observer
export default class RepairList extends Component {

    constructor(props) {
        super(props);
        this.store = {
            repairStore: props.repairStore
        };
    }

    componentDidMount() {
        this.store.repairStore.repairListPage = 1;
        this.store.repairStore.getRepair();
        this.store.repairStore.getRepairCount();
    }



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

    render() {
        const {history} = this.props;
        const {repairStore} = this.store;

        const row = (rowData, sectionID, rowID) => {
            switch (rowData.type) {
                case 'general':
                    return (
                        <Item key={rowID} multipleLine onClick={() => {
                            history.push('/general/details/' + rowData.id)
                        }} className="special-badge"
                              extra={<Badge className={this.repairStatus(rowData.status) + " am-badge-45 "}
                                            text={this.repairStatusTitle(rowData.status)}/>}>
                            <Badge text="通用"
                                   style={{
                                       marginRight: 12,
                                       padding: '0 0.06rem',
                                       backgroundColor: '#fff',
                                       borderRadius: 2,
                                       color: '#49a9ee',
                                       border: '1px solid #49a9ee',
                                   }}
                            />T：{moment(rowData.create_time*1000).format('YYYY-MM-D hh:mm')}
                            <Brief>
                                {rowData.id}报修项目：{rowData.data.cate} <br/>
                                报修描述：{rowData.data.desc}<br/>
                            </Brief>

                        </Item>
                    );
                    break;
                case 'net':
                    return (
                        <Item multipleLine onClick={() => {
                        }} className="special-badge"
                              extra={<Badge className={this.repairStatus(rowData.status) + " am-badge-45 "}
                                            text={this.repairStatusTitle(rowData.status)}/>}>
                            <Badge text="宽带"
                                   style={{
                                       marginRight: 12,
                                       padding: '0 0.06rem',
                                       backgroundColor: '#fff',
                                       borderRadius: 2,
                                       color: '#49a9ee',
                                       border: '1px solid #49a9ee',
                                   }}

                            />
                            T：{moment(rowData.create_time*1000).format('YYYY-MM-D hh:mm')}
                            <Brief>

                                {rowData.id}报修帐号：{rowData.data.account}<br/>
                                报修描述：{rowData.data.desc}<br/>
                            </Brief>

                        </Item>
                    );
                    break;
            }
        };


        return (
            <div id="repairList">
                <ListView
                    ref="lv"
                    dataSource={this.store.repairStore.repairListDataSource}
                    renderRow={row}
                    renderFooter={() => (<div style={{padding: 30, textAlign: 'center'}}>
                        {this.store.repairStore.hasMore ? this.store.repairStore.isLoading ? '正在加载...' : '上拉加载' : '没有数据了'}
                    </div>)}
                    renderHeader={() => <HeadTitle title="我的报修"
                                                   subTitle={"一共报 " + repairStore.getRepairListCount + " 修次"}/>}
                    pageSize={10}
                    removeClippedSubviews={false}
                    scrollRenderAheadDistance={500}
                    scrollEventThrottle={200}
                    onEndReachedThreshold={10}
                    initialListSize={0}
                    style={{
                        height: document.documentElement.clientHeight,
                        margin: '0.1rem 0',
                    }}
                    onEndReached={() => this.store.repairStore.getRepair()}
                    scrollerOptions={{scrollbars: true}}
                    refreshControl={<RefreshControl
                        refreshing={this.store.repairStore.refreshing}
                        onRefresh={() => this.store.repairStore.onRefresh()}
                    />}
                />
            </div>
        );
    }
}
