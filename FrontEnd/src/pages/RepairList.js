import React, {Component} from 'react'
import {observer,inject} from 'mobx-react';
import {List, Badge,ListView } from 'antd-mobile';
import {HeadTitle} from './../components/Index'
import './../styles/pages/RepairList.less'

const Item = List.Item;
const Brief = Item.Brief;


@inject('repairStore')
@observer
export default class RepairList extends Component {

    state={
        list:[],
        dataSource:[]
    }

    constructor(props) {
        super(props);
        this.history = props.history;
        this.store = {
            repairStore: props.repairStore
        };
        const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
        this.state = {
            dataSource: ds.cloneWithRows([
                'John', 'Joel', 'James', 'Jimmy', 'Jackson', 'Jillian', 'Julie', 'Devin'
            ])
        };
    }

    componentDidMount() {

        console.log(this.store.repairStore.repairList)
    }

    onEndReached=(e)=>{
        this.store.repairStore.getRepair();
    }

    render() {
        const row = (rowData, sectionID, rowID) => {
            return (
                    <Item key={rowID} multipleLine onClick={() => {
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
            );
        };

        return (
            <div id="login">
                <HeadTitle title="我的报修" subTitle="一共报修1次"/>
                <List className="my-list">
                {/*<ListView ref="lv"*/}
                          {/*dataSource={this.store.repairStore.repairList}*/}
                          {/*renderFooter={() => (<div style={{ padding: 30, textAlign: 'center' }}>*/}
                              {/*{this.store.repairStore.isLoading ? 'Loading...' : 'Loaded'}*/}
                          {/*</div>)}*/}
                          {/*renderRow={row}*/}
                          {/*className="am-list"*/}
                          {/*useBodyScroll*/}
                          {/*onScroll={() => { console.log('scroll'); }}*/}
                          {/*scrollRenderAheadDistance={500}*/}
                          {/*scrollEventThrottle={200}*/}
                          {/*onEndReached={this.onEndReached}*/}
                          {/*onEndReachedThreshold={10}*/}
                {/*/>*/}

                </List>
                23
                <ListView className="am-list"
                          renderFooter={() => (<div style={{ padding: 30, textAlign: 'center' }}>
                    {this.store.repairStore.isLoading ? 'Loading...' : 'Loaded'}
                </div>)}
                          useBodyScroll
                          dataSource={this.store.repairStore.repairList}
                          renderRow={(rowData) => <div>31222{rowData}</div>}
                />
                123
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
