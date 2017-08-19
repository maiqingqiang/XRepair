import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, Badge, ListView} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import './../styles/pages/RepairList.less'

const Item = List.Item;
const Brief = Item.Brief;


@inject('repairStore')
@observer
export default class RepairList extends Component {

    state = {
        list: [],
        dataSource: []
    }

    ds = new ListView.DataSource({
        rowHasChanged: (r1, r2) => {
            return r1 !== r2
        }
    });

    constructor(props) {
        super(props);
        this.store = {
            repairStore: props.repairStore
        };
        this.repairStatus = this.repairStatus.bind(this);
        this.repairStatusTitle = this.repairStatusTitle.bind(this);
    }

    componentDidMount() {
        this.store.repairStore.getRepair();
        this.store.repairStore.getRepairCount();
    }


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
                            />
                            T：2017年8月9日 16:04:03
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
                            T：2017年8月9日 16:04:03
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
                <HeadTitle title="我的报修" subTitle={"一共报 "+repairStore.getRepairListCount+" 修次"}/>

                <ListView ref="lv"
                          dataSource={repairStore.repairListDataSource}
                          renderFooter={() => (<div style={{padding: 30, textAlign: 'center'}}>
                              {repairStore.isLoadingTitle}
                          </div>)}
                          renderRow={row}
                          className="am-list"
                          useBodyScroll
                          onEndReached={() => repairStore.getRepair()}
                />
            </div>
        );
    }
}
