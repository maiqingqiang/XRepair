import React, {Component} from 'react'
import {observer} from 'mobx-react';
import {Card, WingBlank, WhiteSpace, Badge, Button, List} from 'antd-mobile';

const Item = List.Item;

@observer
export default class Home extends Component {
    constructor(props) {
        super(props);
    }


    render() {
        return (
            <div id="admin-general">
                <WingBlank size="lg">
                    <WhiteSpace size="lg"/>
                    <Card>
                        <Card.Header
                            title="2017-08-20 03:07"
                            extra={<Badge text="自动缴费"
                                          style={{
                                              marginLeft: 12,
                                              padding: '0 0.06rem',
                                              backgroundColor: '#fff',
                                              borderRadius: 2,
                                              color: '#f19736',
                                              border: '1px solid #f19736',
                                          }}
                            />}
                        />
                        <Card.Body>
                            <List renderHeader={() => '报修信息'} className="my-list">
                                <Item extra={'extra content'}>姓名</Item>
                                <Item extra={'extra content'}>区域</Item>
                                <Item extra={'extra content'}>类型</Item>
                                <Item extra={'extra content'}>描述</Item>
                            </List>
                        </Card.Body>
                        <Card.Footer content={<Button type="primary" inline size="small">接单</Button>}
                                     extra={<Button type="primary" inline size="small">查看</Button>}/>
                    </Card>
                    <WhiteSpace size="lg"/>
                </WingBlank>
            </div>
        );
    }
}

