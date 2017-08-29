import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, InputItem, Button, WhiteSpace, WingBlank} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import {createForm} from 'rc-form';

@inject('userStore')
@observer
class UserInfo extends Component {

    update=(e)=>{
        if (e) e.preventDefault();

        this.props.userStore.updateUserInfo(this.props.form.getFieldsValue());
    };

    render() {
        const {getFieldProps,getFieldValue} = this.props.form;
        const {userInfo} = this.props.userStore;

        return (
            <div id="register">
                <HeadTitle title="个人资料"/>
                <List>
                    <InputItem value={userInfo.account} disabled>帐号</InputItem>
                    <InputItem
                        {...getFieldProps('name', {
                            initialValue: userInfo.name
                        })}
                        clear
                        placeholder="请输入你的真实姓名"
                    >真实姓名</InputItem>
                    <InputItem
                        {...getFieldProps('mobile', {
                            initialValue: userInfo.mobile
                        })}
                        clear
                        type="number"
                        placeholder="请输入你的手机号码"
                    >手机号码</InputItem>
                    <InputItem
                        {...getFieldProps('email', {
                            initialValue: userInfo.email
                        })}
                        clear
                        placeholder="请输入你的邮箱"
                    >邮箱</InputItem>
                </List>

                <WhiteSpace size="lg"/>
                <WingBlank size="sm">
                    <Button onClick={this.update} disabled={getFieldValue('name')===userInfo.name && getFieldValue('mobile')===userInfo.mobile && getFieldValue('email')===userInfo.email} type="primary">更新</Button>
                    <WhiteSpace size="lg"/>
                </WingBlank>
            </div>
        );
    }
}

export default createForm()(UserInfo)