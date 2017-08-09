import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {List, Button, WhiteSpace, WingBlank, Card, Badge} from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import './../styles/pages/RepairList.less'

const Item = List.Item;
const Brief = Item.Brief;

@inject("store")
@observer
export default class RepairList extends Component {
    constructor(props) {
        super(props);
        this.store = props.store;
        this.history = props.history;
    }

    login = () => {
        this.store.isLogin = true;
        const {from} = this.props.location.state || {from: {pathname: '/'}}
        this.history.push(from)
    };

    render() {
        return (
            <div id="login">
                <HeadTitle title="我的报修" subTitle="一共报修1次"/>
                <List className="my-list">
                    <Item multipleLine onClick={() => {
                    }} className="special-badge" extra={<Badge className="am-badge-45" style={{ backgroundColor: '#49a9ee',   fontSize: '0.18rem'}} text={'处理中'}/>}>
                        <Badge text="宽带"
                               style={{
                                   marginRight: 12,
                                   padding: '0 0.06rem',
                                   backgroundColor: '#fff',
                                   borderRadius: 2,
                                   color: '#49a9ee',
                                   border: '1px solid #49a9ee',
                               }}
                        />
                        T：2017年8月9日 16:04:03
                        <Brief>
                            报修项目：宽带 <br/>
                            报修描述：不能上网<br/>
                        </Brief>

                    </Item>
                    <Item multipleLine onClick={() => {
                    }} className="special-badge" extra={<Badge className="am-badge-45" style={{ backgroundColor: '#d9d9d9',   fontSize: '0.18rem'}} text={'未接单'}/>}>
                        <Badge text="通用"
                               style={{
                                   marginRight: 12,
                                   padding: '0 0.06rem',
                                   backgroundColor: '#fff',
                                   borderRadius: 2,
                                   color: '#49a9ee',
                                   border: '1px solid #49a9ee',
                               }}
                        />
                        T：2017年8月9日 16:04:03
                        <Brief>
                            报修项目：宽带 <br/>
                            报修描述：不能上网<br/>
                        </Brief>
                    </Item>
                    <Item multipleLine onClick={() => {
                    }} className="special-badge" extra={<Badge className="am-badge-45" style={{ backgroundColor: '#3dbd7d',   fontSize: '0.18rem'}} text={'已完成'}/>}>
                        <Badge text="通用"
                               style={{
                                   marginRight: 12,
                                   padding: '0 0.06rem',
                                   backgroundColor: '#fff',
                                   borderRadius: 2,
                                   color: '#49a9ee',
                                   border: '1px solid #49a9ee',
                               }}
                        />
                        T：2017年8月9日 16:04:03
                        <Brief>
                            报修项目：宽带 <br/>
                            报修描述：不能上网<br/>
                        </Brief>
                    </Item>
                </List>


            </div>
        );
    }
}
