import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, InputItem, Button, WhiteSpace, WingBlank,Toast} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import {createForm} from 'rc-form';
import Qs from 'qs';
import '../styles/pages/Register.less';
import Geetest from 'geetest3'
import $ from 'jquery'

@inject('userStore')
@observer
class Register extends Component {

    componentDidMount(){
        this.initCaptcha();
    }

    register = () => {
        Toast.loading('正在提交……',0);
        let data = this.props.form.getFieldsValue();
        this.axios.post('/XRepair/BackEnd/public/service/public/register',Qs.stringify(data)).then((res)=>{
            let data = res.data;
            if (data.code==200){
                Toast.success(data.message+',2s后自动跳转~~',2,()=>this.props.history.push('/login'));
            }else {
                Toast.fail(data.message,1.5);
            }
        }).catch((e)=>{
            Toast.offline(e.message,1.5);
        });
    };

    initCaptcha=()=>{
        let data = this.props.form.getFieldsValue();
        this.axios.post('/XRepair/BackEnd/public/service/public/initCaptcha',Qs.stringify(data)).then((res)=>{
            let data = res.data;
            console.log(data);
            if (data.success==1){
                var captcha = new Geetest({
                    gt: data.gt,
                    challenge: data.challenge,
                    offline: !data.success,
                    product: 'embed',
                    // jsonp: true,
                    lang: 'en'
                });
                captcha.appendTo('#captcha');

                captcha.onReady(function () {
                    $('#tip').hide();
                });

                $('#submit').click(function (e) {
                    var result = captcha.getValidate();
                    if (result) {
                        // login(result);
                    } else {
                        alert('please complete verification');
                    }
                    e.preventDefault();
                })
            }else {
                Toast.fail('验证码初始化失败',1.5);
            }
        }).catch((e)=>{
            Toast.offline(e.message,1.5);
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
                        placeholder="请输入你的登录密码"
                    >再输入密码</InputItem>
                    <div className="field">
                        <label>verify: </label>
                        <div id="captcha"></div>
                        <div id="tip">loading captcha</div>
                    </div>
                    {/*<InputItem*/}
                        {/*{...getFieldProps('captcha')}*/}
                        {/*placeholder="请输入验证码"*/}
                        {/*className='captcha'*/}
                        {/*extra={<img*/}
                            {/*src={this.axios.defaults.baseURL+'/XRepair/BackEnd/public/captcha/new.html?width=160&amp;font_size=30'}*/}
                            {/*onClick={(_el) => {*/}
                                {/*_el.target.src = this.axios.defaults.baseURL+'/XRepair/BackEnd/public/captcha/new.html?width=160&amp;font_size=30&amp;time=' + Math.random();*/}
                            {/*}}*/}
                            {/*title="点击换一张"/>}*/}
                    {/*>验证码</InputItem>*/}
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