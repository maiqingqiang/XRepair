import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, InputItem, Button, WhiteSpace, WingBlank, Toast} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import {createForm} from 'rc-form';
import Qs from 'qs';
import '../styles/pages/Register.less';
import Geetest from 'geetest3'

const Item = List.Item;

@inject('userStore')
@observer
class Register extends Component {

    state = {
        captchaTips: true
    };

    constructor(props) {
        super(props);
        this.captcha = null;
        this.random = (new Date()).getTime();
        this.offline = 0;
    }

    componentDidMount() {
        this.initCaptcha();
    }

    register = () => {
        let result = this.captcha.getValidate();

        if (this.captcha.getValidate()) {
            let data = Object.assign(this.props.form.getFieldsValue(), result, {
                random: this.random,
                offline: this.offline
            });

            this.axios.post('/XRepair/BackEnd/public/service/public/register', Qs.stringify(data)).then((res) => {
                let data = res.data;
                if (data.code == 200) {
                    Toast.success(data.message + ',2s后自动跳转~~', 2, () => this.props.history.push('/login'));
                } else{
                    this.captcha.reset();
                    Toast.fail(data.message, 1.5);
                }
            }).catch((e) => {
                this.captcha.reset();
                Toast.offline(e.message, 1.5);
            });
        } else {
            Toast.fail('未点击验证', 1.5);
        }

    };

    initCaptcha = () => {
        let _this = this;
        this.axios.post('/XRepair/BackEnd/public/service/public/initCaptcha', Qs.stringify({random: this.random})).then((res) => {
            let data = res.data;
            this.offline = data.success ? 0 : 1;
            this.captcha = new Geetest({
                gt: data.gt,
                challenge: data.challenge,
                offline: !data.success,
                // jsonp: true,
                lang: 'zh-cn',
                width: '100%',
                product: 'custom',
                area: '#captcha', // 假设页面有一个id为area的标签
                next_width: '6rem',
                bg_color: 'black'
            });
            this.captcha.appendTo('#captcha');
            this.captcha.onReady(function () {
                _this.setState({captchaTips: false})
            });
        }).catch((e) => {
            Toast.offline(e.message, 1.5);
        });
    };

    render() {
        const {getFieldProps} = this.props.form;
        const {history} = this.props;
        return (
            <div id="register">
                <HeadTitle title="登录" subTitle="X 报修平台 by Mak"/>
                <List>
                    <InputItem
                        {...getFieldProps('username')}
                        clear
                        placeholder="请输入你的帐号"
                    >帐号</InputItem>
                    <InputItem
                        {...getFieldProps('name')}
                        clear
                        placeholder="请输入你的真实姓名"
                    >真实姓名</InputItem>
                    <InputItem
                        {...getFieldProps('mobile')}
                        clear
                        type="phone"
                        placeholder="请输入你的手机号码"
                    >手机号码</InputItem>
                    <InputItem
                        {...getFieldProps('email')}
                        clear
                        type="email"
                        placeholder="请输入你的邮箱"
                    >邮箱</InputItem>
                    <InputItem
                        {...getFieldProps('password')}
                        clear
                        type="email"
                        placeholder="请输入你的登录密码"
                    >密码</InputItem>
                    <InputItem
                        {...getFieldProps('password_confirm')}
                        clear
                        type="email"
                        placeholder="请再次输入你的登录密码"
                    >再输入密码</InputItem>
                </List>

                <List renderHeader={() => '验证'}>
                    <div id="captcha"></div>
                    {this.state.captchaTips ? '正在加载验证码……' : ''}
                    {/*<div id="Tips">正在加载验证码……</div>*/}
                </List>

                <WhiteSpace size="lg"/>
                <WingBlank size="sm">
                    <Button onClick={this.register} type="primary">马上注册</Button>
                    <WhiteSpace size="lg"/>
                    <Button onClick={() => {
                        history.replace('/login')
                    }}>已注册，直接登录</Button>
                </WingBlank>
            </div>
        );
    }
}

export default createForm()(Register)