import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, Badge,Toast, RefreshControl, ListView} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import './../styles/pages/RepairList.less'
import Qs from 'qs'

const Item = List.Item;
const Brief = Item.Brief;

const data = [
    {
        img: 'https://zos.alipayobjects.com/rmsportal/dKbkpPXKfvZzWCM.png',
        title: 'Meet hotel',
        des: '不是所有的兼职汪都需要风吹日晒',
    },
    {
        img: 'https://zos.alipayobjects.com/rmsportal/XmwCzSeJiqpkuMB.png',
        title: 'McDonald\'s invites you',
        des: '不是所有的兼职汪都需要风吹日晒',
    },
    {
        img: 'https://zos.alipayobjects.com/rmsportal/hfVtzEhPzTUewPm.png',
        title: 'Eat the week',
        des: '不是所有的兼职汪都需要风吹日晒',
    },
];

let index = data.length - 1;

let pageIndex = 1;

@inject('repairStore')
@observer
export default class RepairList extends Component {

    state = {
        list: [],
        dataSource: [],
        isRefreshing: false,
        isLoading:false,
        hasMore:true
    };

    dataSource = new ListView.DataSource({
        rowHasChanged: (row1, row2) => row1 !== row2,
    });


    constructor(props) {
        super(props);
        this.state = {
            list: [],
            dataSource: this.dataSource.cloneWithRows([]),
            isRefreshing: false,
            isLoading:false,
            hasMore:true,
            refreshing:false,
            height: document.documentElement.clientHeight,
        };

        this.store = {
            repairStore: props.repairStore
        };
        this.repairStatus = this.repairStatus.bind(this);
        this.repairStatusTitle = this.repairStatusTitle.bind(this);
        this.onEndReached();
    }

    componentDidMount() {
        this.store.repairStore.repairListPage = 1;
        this.store.repairStore.getRepair();
        this.store.repairStore.getRepairCount();
    }

    onRefresh = () => {

        if (!this.state.isRefreshing) {
            this.setState({ refreshing: true,isRefreshing:true });
        }
        pageIndex = 0
        // this.state.refreshing=true;
        // this.state.isRefreshing=true;
        setTimeout(() => {
            this.setState({
                list: [],
                dataSource: this.dataSource.cloneWithRows([]),
                isRefreshing: false,
                isLoading:false,
                refreshing:false,
                hasMore:true
            });
        }, 1000);

    };

    onEndReached = () => {

        // if (this.state.isLoading || this.state.isRefreshing ||!this.state.hasMore){
        //     return
        // }

        if (this.state.isRefreshing){
            console.log(2)

            return
        }
        //
        if (!this.state.hasMore){
            console.log(3)
            console.log(this.state.hasMore)
            return
        }

        console.log(123)


        this.state.isLoading = true;
        this.axios.post('/XRepair/BackEnd/public/service/common/getRepairList', Qs.stringify({page: pageIndex})).then((res) => {
            let data = res.data;
            if (data.code == 200) {
                // this.state.dataSource.cloneWithRows(data.result);
                this.state.list= [...this.state.list,...data.result]
                this.setState({
                    dataSource:this.state.dataSource.cloneWithRows(this.state.list),
                    isLoading:false,hasMore:data.row >=10
                })
                pageIndex++;
            } else {
                this.setState({
                    isLoading:false
                })
                Toast.fail(data.message, 1.5);
            }

        }).catch((e) => {
            this.setState({
                isLoading:false
            })
            Toast.offline(e.message, 1.5)
        });
    };


    repairStatus(status) {
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

    repairStatusTitle(status) {
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
                        <Item key={rowID} multipleLine onClick={() => {history.push('/general/details/'+rowData.id)}} className="special-badge"
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
        />T：2017年8月9日 16:04:03
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
        2017年8月9日 16:04:03
        <Brief>

                                {rowData.id}报修帐号：{rowData.data.account}<br/>
                                报修描述：{rowData.data.desc}<br/>
                            </Brief>

                        </Item>
                    );
                    break;
            }
        };

        // const row = (rowData, sectionID, rowID) => {
        //
        //     return (
        //         <div key={rowID} style={{height:'.88rem'}}>
        //             {rowData.id}
        //         </div>
        //     );
        // };
        return (
            <ListView
                id="repairList"
                ref="lv"
                dataSource={this.store.repairStore.repairListDataSource}
                renderRow={row}
                renderFooter={() => (<div style={{ padding: 30, textAlign: 'center' }}>
                    {this.store.repairStore.hasMore?this.store.repairStore.isLoading ? '正在加载...' : '上拉加载':'没有数据了'}
                </div>)}
                renderHeader={() => <HeadTitle title="我的报修" subTitle={"一共报 " + repairStore.getRepairListCount + " 修次"}/>}
                pageSize={10}
                scrollRenderAheadDistance={500}
                scrollEventThrottle={200}
                onEndReachedThreshold={10}
                removeClippedSubviews
                initialListSize={0}
                style={{
                    height: document.documentElement.clientHeight,
                    margin: '0.1rem 0',
                }}
                onEndReached={()=>this.store.repairStore.getRepair()}
                scrollerOptions={{scrollbars: true}}
                refreshControl={<RefreshControl
                    refreshing={this.store.repairStore.refreshing}
                    onRefresh={()=>this.store.repairStore.onRefresh()}
                />}
            />
        );
    }
}
