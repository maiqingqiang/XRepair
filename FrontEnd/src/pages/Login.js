import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, InputItem, Button, WhiteSpace, WingBlank, Toast} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import {createForm} from 'rc-form';
import Qs from 'qs';
import Geetest from 'geetest3'
import '../styles/geetest.less';

@inject('userStore')
@observer
class Login extends Component {

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
    }

    login = () => {
        let result = this.captcha.getValidate();

        if (this.captcha.getValidate()) {
            let data = Object.assign(this.props.form.getFieldsValue(), result, {
                random: this.random,
                offline: this.offline
            });

            this.axios.post('/XRepair/BackEnd/public/service/public/login', Qs.stringify(data)).then((res) => {
                let data = res.data;
                if (data.code == 200) {
                    const {userStore} = this.props;
                    userStore.setToken(data.result.token, data.result.userInfo);
                    const {from} = this.props.location.state || {from: {pathname: '/'}};
                    this.props.history.replace(from)
                } else {
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
                        {...getFieldProps('password')}
                        clear
                        type="password"
                        placeholder="请输入你的登录密码"
                    >密码</InputItem>
                </List>

                <List renderHeader={() => '验证'}>
                    <div id="captcha"></div>
                    {this.state.captchaTips ? '正在加载验证码……' : ''}
                </List>

                <WhiteSpace size="lg"/>
                <WingBlank size="sm">
                    <Button onClick={this.login} type="primary">登录</Button>
                    <WhiteSpace size="lg"/>
                    <Button onClick={() => {
                        history.push('/register')
                    }}>注册</Button>
                </WingBlank>
            </div>
        );
    }
}

export default createForm()(Login)