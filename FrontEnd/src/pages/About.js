import React, { Component } from 'react'
import {observer, inject} from 'mobx-react';
import { Button } from 'antd-mobile';

@inject("userStore")
@observer
class About extends Component {
    constructor(props) {
        super(props);
        this.store = props.userStore;
    }

    render() {
        const {userStore} =this.props
        return (
            <div>
                <h2>about{userStore.token}</h2>
                <Button>about</Button>
            </div>
        );
    }
}

export default About