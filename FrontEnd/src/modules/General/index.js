import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, InputItem,TextareaItem,Picker,Button,WhiteSpace,WingBlank } from 'antd-mobile';
import {HeadTitle} from './../../components/Index'
import { createForm } from 'rc-form';
import { district } from 'antd-mobile-demo-data';

const seasons = [
        {
            label: '2013',
            value: '2013',
            children:[{
                label: '2014',
                value: '2014',
                children:[{
                    label: '春',
                    value: '春',
                    children:[{
                        label: '春',
                        value: '春',
                        children:[{
                            label: '春',
                            value: '春',
                        },]
                    },]
                },]
            },]
        },

    ];

@inject("store")
@observer
class Index extends Component {
    constructor(props) {
        super(props);
        this.store = props.store;
    }

    save(e){
        e.preventDefault();
        console.log(this.props.form)
        console.log(this.props.form.getFieldsValue())
    }

    render() {
        const _this = this;
        const { getFieldProps } = this.props.form;
        return (
            <div id="general-index">
                <HeadTitle title="通用报修" subTitle="集合多种报修项目"/>

                <List renderHeader={() => '个人信息'}>
                    <InputItem
                        {...getFieldProps('username')}
                        clear
                        placeholder="请输入你的姓名"
                    >姓名</InputItem>
                    <InputItem
                        {...getFieldProps('phone')}
                        clear
                        placeholder="请输入你的手机号码"
                    >手机号码</InputItem>
                </List>

                <List renderHeader={() => '报修信息'}>
                    <Picker data={district} cols={1} {...getFieldProps('address')} className="forss">
                        <List.Item arrow="horizontal">区域</List.Item>
                    </Picker>
                    <Picker data={seasons} cols={4} {...getFieldProps('report_type')} className="forss">
                        <List.Item arrow="horizontal">选择报修项目</List.Item>
                    </Picker>
                </List>

                <List renderHeader={() => '故障描述'}>
                    <TextareaItem
                        placeholder="请描述一下你的故障情况!"
                        {...getFieldProps('desc')}
                        rows={5}
                        count={200}
                    />
                </List>


                <WhiteSpace size="lg" />
                <WingBlank size="sm"><Button className="btn" type="primary" onClick={_this.save.bind(_this)}>提交报修</Button></WingBlank>
            </div>
        );
    }
}

export default createForm()(Index);