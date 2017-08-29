import React, {Component} from 'react'
import {observer} from 'mobx-react';
import {createForm} from 'rc-form';
import {AdminProtected} from "./../../components/Index";


import {
    List, NavBar
} from 'antd-mobile';
import '../../styles/modules/Admin/General.less'

const Item = List.Item;


@AdminProtected
@observer
class General extends Component {
    render() {
        const {history} = this.props;
        return (
            <div id="admin-general">
                <NavBar leftContent="返回"
                        mode="dark"
                        onLeftClick={() => history.goBack()}
                >通用报修管理</NavBar>
                <List>
                    <Item arrow="horizontal" onClick={() => history.push('/admin/general-list')}>报修列表</Item>
                    <Item arrow="horizontal" onClick={() => history.push('/admin/general-order')}>我的接单</Item>
                </List>
            </div>
        );
    }
}

export default createForm()(General);