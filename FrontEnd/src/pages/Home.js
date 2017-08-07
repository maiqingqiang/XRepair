import React, {Component} from 'react'
import {observer, inject} from 'mobx-react';
import {Grid, Icon} from 'antd-mobile';
import '../styles/pages/Home.less';
import GeneralRepair from '../asset/general_repair.svg';
import Net from '../asset/net.svg';
import Feedback from '../asset/feedback.svg';

const data = [{
    icon: GeneralRepair,
    title: '通用报修',
    sub: '集合多种报修项目',
    color1: '#4de685',
    color2: '#0cd257'
}, {
    icon: Net,
    title: '宽带报修',
    sub: '宽带报修入口',
    color1: '#0cd6ec',
    color2: '#13b1f8'
}, {
    icon: Feedback,
    title: '建议反馈',
    sub: '功能不好?来吐槽!',
    color1: '#fd8741',
    color2: '#fa4f1d'

}, {
    icon: Feedback,
    title: '???',
    sub: '更多功能敬请期待',
    color1: '#e8e8e8',
    color2: '#c5c5c5'
}];


@inject("store")
@observer
class Home extends Component {
    constructor(props) {
        super(props);
        this.store = props.store;
        console.log(this.store)
    }

    render() {
        const {token} = this.store;
        return (
            <div>
                <Grid data={data}
                      columnNum={2}
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

export default Home