import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {Grid, Icon} from 'antd-mobile';
import {HeadTitle} from './../../components/Index'


@inject("store")
@observer
export default class Index extends Component {
    constructor(props) {
        super(props);
        this.store = props.store;
    }

    render() {
        return (
            <div id="general-index">
                <HeadTitle title="通用报修" subTitle="集合多种报修项目"/>
            </div>
        );
    }
}