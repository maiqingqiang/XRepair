import React, { Component } from 'react'
import {observer, inject} from 'mobx-react';
import { Button } from 'antd-mobile';
import {Link} from 'react-router-dom'

@inject("store")
@observer
class Home extends Component {
    constructor(props) {
        super(props);
        this.store = props.store;
        console.log(this.store)
    }

    render() {
        const {token} =this.store;
        return (
            <div>
                <h2>Home{token}</h2>
                <Button>antd-mobile button</Button>
                <Link to="/about">aaaaa</Link>
            </div>
        );
    }
}

export default Home