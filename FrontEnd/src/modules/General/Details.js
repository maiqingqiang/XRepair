import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, WhiteSpace, WingBlank, Button, Steps, Badge} from 'antd-mobile';
import {HeadTitle} from './../../components/Index'
import '../../styles/modules/general/Details.less'

import {Protected} from "./../../components/Index";

const Item = List.Item;
const Brief = Item.Brief;
const Step = Steps.Step;

// @Protected
@inject('repairStore', 'generalStore', 'userStore')
@observer
export default class Details extends Component {

    //0未接单,1处理中,2完成
    state = {
        stepsCurrent: 2
    };

    constructor(props) {
        super(props);
        this.store = {
            repairStore: props.repairStore,
            generalStore: props.generalStore,
            userStore: props.userStore
        };
    }

    componentDidMount() {
        this.store.repairStore.getRepairDetails(this.props.match.params.id);
    }

    render() {
        const {repairStore} = this.store;
        return (
            <div id="general-details">
                <HeadTitle title={<div>详情<Badge text="通用"
                                                style={{
                                                    marginLeft: 12,
                                                    padding: '0 0.06rem',
                                                    backgroundColor: '#fff',
                                                    borderRadius: 2,
                                                    color: '#49a9ee',
                                                    border: '1px solid #49a9ee',
                                                }}/></div>}/>

                <WingBlank size="lg">
                    <WhiteSpace/>
                    <Steps current={repairStore.getRepairStatus}>
                        <Step status={repairStore.getRepairStatus == -1 ? 'error' : ''}
                              title={repairStore.getRepairStatus == -1 ? '已撤销报修' : repairStore.getRepairStatus > 0 ? "已接单" : "等待接单"} description={
                            repairStore.getRepairStatus > 0 ?
                                <div><span className="bg-span">维修员：</span>{repairStore.repairDetails.repairer_name}<br/><span
                                    className="bg-span">联系方式：</span>{repairStore.repairDetails.repairer_mobile}
                                </div> : ''
                        }/>
                        <Step title={repairStore.getRepairStatus >= -1 && repairStore.getRepairStatus < 2 ? '处理中' : '处理完成'}
                              description={repairStore.getRepairStatus == 2 ? <span
                                  className="bg-span">{repairStore.repairDetails.feedback ? '反馈信息：' + repairStore.repairDetails.feedback : ''}</span> : ''}/>
                    </Steps>
                    <WhiteSpace size="lg"/>
                </WingBlank>

                <List className="my-list">
                    <Item extra={repairStore.repairDetails.name}>姓名</Item>
                    <Item extra={repairStore.repairDetails.mobile}>手机号码</Item>
                    <Item extra={repairStore.repairDetails.address}>区域</Item>
                    <Item extra={repairStore.repairDetails.cate}>报修类型</Item>
                    <Item multipleLine wrap>
                        故障描述 <Brief>{repairStore.repairDetails.desc}</Brief>
                    </Item>
                </List>
                <WhiteSpace size="lg"/>

                <WingBlank size="sm">
                    {repairStore.getRepairStatus === 0 ? <Button className="btn" type="primary" style={{
                        backgroundColor: 'red',
                        borderColor: 'red'
                    }}>撤销报修</Button> : ''}
                </WingBlank>
            </div>
        );
    }
}
