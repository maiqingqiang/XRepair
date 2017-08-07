import React, { Component } from 'react'
import {observer, inject} from 'mobx-react';
import { Button } from 'antd-mobile';

@inject("store")
@observer
class About extends Component {
    constructor(props) {
        super(props);
        this.store = props.store;
        console.log(this.store)
    }

    render() {
        const {token} =this.store
        return (
            <div>
                <h2>about{token}</h2>
                <Button>about</Button>
            </div>
        );
    }
}

export default About