import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {Button} from 'antd-mobile';

@inject("store")
@observer
export default class Login extends Component {
    constructor(props) {
        super(props);
        this.store = props.store;
        this.history = props.history;
    }

    login=()=>{
        this.store.isLogin = true;
        const { from } = this.props.location.state || { from: { pathname: '/' } }
        this.history.push(from)
    };

    render(){
        return (
            <div id="login">
                <Button onClick={this.login}>登录</Button>
            </div>
        );
    }
}

