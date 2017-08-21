import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, Badge, RefreshControl, ListView} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import './../styles/pages/RepairList.less'

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

let pageIndex = 0;

@inject('repairStore')
@observer
export default class RepairList extends Component {

    state = {
        list: [],
        dataSource: [],
        isRefreshing:false
    };

    dataSource = new ListView.DataSource({
        rowHasChanged: (row1, row2) => row1 !== row2,
    });


    constructor(props) {
        super(props);

        this.initData = [];
        for (let i = 0; i < 20; i++) {
            this.initData.push(`r${i}`);
        }

        this.state = {
            dataSource: this.dataSource.cloneWithRows(this.initData),
            isRefreshing: false,
            height: document.documentElement.clientHeight,
        };

        this.store = {
            repairStore: props.repairStore
        };
        this.repairStatus = this.repairStatus.bind(this);
        this.repairStatusTitle = this.repairStatusTitle.bind(this);
    }

    componentDidMount() {
        this.store.repairStore.repairListPage=1;
        this.store.repairStore.getRepair();
        this.store.repairStore.getRepairCount();
    }

    onRefresh=()=>{

    };

    onEndReached=()=>this.store.repairStore.getRepair();


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

        // const row = (rowData, sectionID, rowID) => {
        //     switch (rowData.type) {
        //         case 'general':
        //             return (
        //                 <Item key={rowID} multipleLine onClick={() => {history.push('/general/details/'+rowData.id)}} className="special-badge"
        //                       extra={<Badge className={this.repairStatus(rowData.status) + " am-badge-45 "}
                                            {/*text={this.repairStatusTitle(rowData.status)}/>}>*/}
                            {/*<Badge text="通用"*/}
        //                            style={{
        //                                marginRight: 12,
        //                                padding: '0 0.06rem',
        //                                backgroundColor: '#fff',
        //                                borderRadius: 2,
        //                                color: '#49a9ee',
        //                                border: '1px solid #49a9ee',
        //                            }}
                            {/*/>*/}
                            {/*T：2017年8月9日 16:04:03*/}
        //                     <Brief>
        //                         {rowData.id}报修项目：{rowData.data.cate} <br/>
        //                         报修描述：{rowData.data.desc}<br/>
        //                     </Brief>
        //
        //                 </Item>
        //             );
        //             break;
        //         case 'net':
        //             return (
        //                 <Item multipleLine onClick={() => {
        //                 }} className="special-badge"
        //                       extra={<Badge className={this.repairStatus(rowData.status) + " am-badge-45 "}
                                            {/*text={this.repairStatusTitle(rowData.status)}/>}>*/}
                            {/*<Badge text="宽带"*/}
        //                            style={{
        //                                marginRight: 12,
        //                                padding: '0 0.06rem',
        //                                backgroundColor: '#fff',
        //                                borderRadius: 2,
        //                                color: '#49a9ee',
                                       {/*border: '1px solid #49a9ee',*/}
                                   {/*}}*/}
                            {/*/>*/}
                            {/*T：2017年8月9日 16:04:03*/}
                            {/*<Brief>*/}
        //                         {rowData.id}报修帐号：{rowData.data.account}<br/>
        //                         报修描述：{rowData.data.desc}<br/>
        //                     </Brief>
        //
        //                 </Item>
        //             );
        //             break;
        //     }
        // };

        const row = (rowData, sectionID, rowID) => {
            if (index < 0) {
                index = data.length - 1;
            }
            const obj = data[index--];
            return (
                <div key={rowID}
                     style={{
                         padding: '0.08rem 0.16rem',
                         backgroundColor: 'white',
                     }}
                >
                    <h3 style={{ padding: 2, marginBottom: '0.08rem', borderBottom: '1px solid #F6F6F6' }}>
                        {obj.title}
                    </h3>
                    <div style={{ display: '-webkit-box', display: 'flex' }}>
                        <img style={{ height: '1.28rem', marginRight: '0.08rem' }} src={obj.img} alt="icon" />
                        <div style={{ display: 'inline-block' }}>
                            <div style={{ margin: '0.1rem 0 0.2rem 0' }}>{obj.des}-{rowData}</div>
                            <div><span style={{ fontSize: '1.6em', color: '#FF6E27' }}>35</span>元/任务</div>
                        </div>
                    </div>
                </div>
            );
        };
        return (
                <ListView
                    ref="lv"
                    dataSource={this.state.dataSource}
                    renderRow={row}
                    renderHeader={()=><HeadTitle title="我的报修" subTitle={"一共报 "+repairStore.getRepairListCount+" 修次"}/>}
                    initialListSize={5}
                    pageSize={5}
                    scrollRenderAheadDistance={200}
                    scrollEventThrottle={20}
                    style={{
                        height: this.state.height,
                        margin: '0.1rem 0',
                    }}
                    scrollerOptions={{ scrollbars: true }}
                    refreshControl={<RefreshControl
                        refreshing={this.state.refreshing}
                        onRefresh={this.onRefresh}
                    />}
                />
        );
    }
}
