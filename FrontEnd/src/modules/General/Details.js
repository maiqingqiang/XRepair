import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, WhiteSpace, WingBlank, Toast,Button, Steps} from 'antd-mobile';
import {HeadTitle} from './../../components/Index'
import Qs from 'qs';
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
        stepsCurrent: 1
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

    }

    render() {
        const {stepsCurrent} =this.state;
        return (
            <div id="general-details">
                <HeadTitle title="详情"/>

                <WingBlank size="lg">
                    <WhiteSpace/>
                    <Steps current={stepsCurrent}>
                        <Step title={stepsCurrent > 0 ? "已接单" : "等待接单"} description={
                            stepsCurrent >0 ?<div><span className="bg-span">维修员：</span>小明<br/><span className="bg-span">联系方式：</span>12345678912</div>:''
                        }/>
                        <Step title={stepsCurrent >= 0 && stepsCurrent<2?'处理中':'处理完成'} description={stepsCurrent==2?<span className="bg-span">反馈信息：</span>:''}/>
                    </Steps>
                    <WhiteSpace size="lg"/>
                </WingBlank>

                <List className="my-list">
                    <Item extra={'小东'}>姓名</Item>
                    <Item extra={'12345678912'}>手机号码</Item>
                    <Item extra={'里建校区1栋'}>区域</Item>
                    <Item extra={'水类型'}>报修类型</Item>
                    <Item multipleLine wrap>
                        故障描述 <Brief>没水啦没水啦没水啦没水啦没水啦没水啦没水啦没水啦没水啦</Brief>
                    </Item>
                </List>
                <WhiteSpace size="lg"/>

                <WingBlank size="sm">
                    {stepsCurrent===0?<Button className="btn" type="primary" style={{backgroundColor:'red',borderColor:'red'}}>撤销报修</Button>:''}
                </WingBlank>
            </div>
        );
    }
}
