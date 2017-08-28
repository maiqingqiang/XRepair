import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, InputItem, TextareaItem, Picker, Button, WhiteSpace, WingBlank, Toast} from 'antd-mobile';
import {HeadTitle} from './../../components/Index'
import {createForm} from 'rc-form';
import qs from 'qs';

import {Protected} from "./../../components/Index";

@Protected
@inject('repairStore', 'generalStore', 'userStore')
@observer
class Index extends Component {

    state = {
        region: [],
        regionCols: 1,
        UserNameStatus: false
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
        this.store.repairStore.getRegion();
        this.store.generalStore.getCategory();
    }

    save(e) {
        if (e) e.preventDefault();
        let post = this.props.form.getFieldsValue();
        this.axios.post('/XRepair/BackEnd/public/service/general/addOrder', qs.stringify(post)).then((res) => {
            let data = res.data;
            if (data.code == 200) {
                Toast.success(data.message, 1,()=>this.props.history.replace('/repair_list'));
            } else {
                Toast.fail(data.message, 1.5);
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5)
        });
    }

    render() {
        const _this = this;
        const {getFieldProps} = this.props.form;
        const {regionList, regionCols} = this.store.repairStore;
        const {categoryList, categoryCols} = this.store.generalStore;
        const {userInfo} = this.store.userStore;
        return (
            <div id="general-index">
                <HeadTitle title="通用报修" subTitle="集合多种报修项目"/>

                <List renderHeader={() => '个人信息'}>
                    <InputItem
                        {...getFieldProps('name', {
                            initialValue: userInfo.name
                        })}
                        clear
                        placeholder="请输入你的姓名"
                    >姓名</InputItem>
                    <InputItem
                        {...getFieldProps('mobile', {
                            initialValue: userInfo.mobile
                        })}
                        clear
                        placeholder="请输入你的手机号码"
                    >手机号码</InputItem>
                </List>

                <List renderHeader={() => '报修信息'}>
                    <Picker data={regionList} cols={regionCols} {...getFieldProps('regions')}>
                        <List.Item arrow="horizontal">区域</List.Item>
                    </Picker>
                    <Picker data={categoryList} cols={categoryCols} {...getFieldProps('categorys')}>
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


                <WhiteSpace size="lg"/>
                <WingBlank size="sm">
                    <Button className="btn" type="primary" onClick={_this.save.bind(_this)}>提交报修</Button>
                </WingBlank>
                <WhiteSpace size="lg"/>
            </div>
        );
    }
}

export default createForm()(Index);