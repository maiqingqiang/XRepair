import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, InputItem, Button, WhiteSpace, WingBlank} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import {createForm} from 'rc-form';


@inject('userStore')
@observer
class Login extends Component {

    login = () => {
        const {userStore} = this.props;
        userStore.isLogin = true;
        const {from} = this.props.location.state || {from: {pathname: '/'}};
        this.props.history.replace(from)
    };

    render() {
        const {getFieldProps} = this.props.form;
        const {history} = this.props;
        return (
            <div id="login">
                <HeadTitle title="登录" subTitle="X 报修平台 by Mak"/>
                <List>
                    <InputItem
                        {...getFieldProps('username')}
                        clear
                        placeholder="请输入你的登录帐号"
                    >帐号</InputItem>
                    <InputItem
                        {...getFieldProps('phone')}
                        clear
                        type="password"
                        placeholder="请输入你的登录密码"
                    >密码</InputItem>
                </List>

                <WhiteSpace size="lg"/>
                <WingBlank size="sm">
                    <Button onClick={this.login} type="primary">登录</Button>
                    <WhiteSpace size="lg"/>
                    <Button onClick={() => {history.push('/register')}}>注册</Button>
                </WingBlank>
            </div>
        );
    }
}

export default createForm()(Login)