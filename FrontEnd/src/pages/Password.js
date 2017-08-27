import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, InputItem, Button, WhiteSpace, WingBlank, Toast} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import {createForm} from 'rc-form';
import qs from 'qs';

const Item = List.Item;

@inject('userStore')
@observer
class Password extends Component {

    constructor(props) {
        super(props);
    }

    componentDidMount() {
    }

    save=(e)=>{
        if (e) e.preventDefault();
        Toast.loading('正在修改中…',0);
        this.axios.post('/XRepair/BackEnd/public/service/common/changePassword', qs.stringify(this.props.form.getFieldsValue())).then((res) => {
            let data = res.data;
            if (data.code == 200) {
                Toast.success(data.message+ ',2s后自动跳转~~', 2, () => this.props.history.replace('/login'));
            } else{
                Toast.fail(data.message, 1.5);
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5);
        });
    };

    render() {
        const {getFieldProps,getFieldValue} = this.props.form;
        const {userInfo} = this.props.userStore;

        return (
            <div id="register">
                <HeadTitle title="修改密码"/>
                <List>
                    <InputItem
                        {...getFieldProps('old_password')}
                        clear
                        type="password"
                        placeholder="请输入原密码"
                    >原密码</InputItem>
                    <InputItem
                        {...getFieldProps('password')}
                        clear
                        type="password"
                        placeholder="请输入新密码"
                    >新密码</InputItem>
                    <InputItem
                        {...getFieldProps('password_confirm')}
                        clear
                        type="password"
                        placeholder="请再输入新密码"
                    >再输入新密码</InputItem>
                </List>

                <WhiteSpace size="lg"/>
                <WingBlank size="sm">
                    <Button type="primary" onClick={this.save}>修改密码</Button>
                    <WhiteSpace size="lg"/>
                </WingBlank>
            </div>
        );
    }
}

export default createForm()(Password)