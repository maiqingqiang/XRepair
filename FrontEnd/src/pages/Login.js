import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {Grid, Icon} from 'antd-mobile';

@inject("store")
@observer
export default class Login extends Component {
    constructor(props) {
        super(props);
        this.store = props.store;
        this.history = props.history;
    }

    render() {
        // const {token} = this.store;
        const {history} =this;
        return (
            <div id="login">
                login
            </div>
        );
    }
}

