import React, {Component} from 'react'
import {observer} from 'mobx-react';
import {Grid, Icon,NavBar} from 'antd-mobile';
import '../../styles/modules/Admin/Index.less';
import GeneralRepair from '../../asset/general_repair.svg';
import Net from '../../asset/net.svg';
import {AdminProtected} from "./../../components/Index";

const data = [{
    icon: GeneralRepair,
    title: '通用报修管理',
    color1: '#4de685',
    color2: '#0cd257',
    to: '/admin/general'
}, {
    icon: Net,
    title: '宽带报修管理',
    color1: '#0cd6ec',
    color2: '#13b1f8',
    to: '/admin/net'
}];

@AdminProtected
@observer
export default class Index extends Component {

    render() {
        const {history} = this.props;
        return (
            <div id="admin-index">
                <NavBar leftContent="返回"
                        mode="dark"
                        onLeftClick={() => history.goBack()}
                >后台管理</NavBar>
                <Grid data={data}
                      columnNum={2}
                      onClick={_el => history.push(_el.to)}
                      renderItem={dataItem => (
                          <div className="grid-item">
                              <div className="icon" style={{
                                  background: `linear-gradient(${dataItem.color1},${dataItem.color2})`
                              }}>
                                  <Icon className="icon-img" type={dataItem.icon} alt="icon"/>
                              </div>
                              <div className="icon-title">
                                  <span className="title">{dataItem.title}</span>
                                  <span className="sub-title">{dataItem.sub}</span>
                              </div>
                          </div>
                      )}
                />
            </div>
        );
    }
}

