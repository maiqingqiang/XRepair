import React from 'react';
import {Result, Icon, WhiteSpace, WingBlank, Button} from 'antd-mobile';

const NotAdmin = ({location, history}) => (
    <div id="not-admin">
        <Result
            img={<Icon type="cross-circle-o" style={{fill: '#F13642', width: '1.2rem', height: '1.2rem'}}/>}
            title="非法操作"
            message="你不是管理员不能进入此页面"
        />
        <WhiteSpace size="lg"/>
        <WingBlank size="sm">
            <Button className="btn" type="primary" onClick={()=>history.replace('/')}>返回首页</Button>
        </WingBlank>
    </div>
);

export default NotAdmin