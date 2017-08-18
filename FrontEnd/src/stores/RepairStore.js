import {observable, action, computed} from "mobx"
import {Toast, ListView} from 'antd-mobile'
import axios from 'axios'
import qs from 'qs'

class RepairStore {
    @observable regionList = [];
    @observable regionCols = 1;
    @observable repairList = [];
    @observable repairListPage = 1;
    @observable isLoading = false;
    @observable hasMore = true;

    ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

    //获取区域
    @action
    getRegion() {
        if (this.regionList.length <= 0) {
            let _this = this;
            axios.get('/XRepair/BackEnd/public/service/common/getRegion').then((res) => {
                let data = res.data;
                if (data.code == 200) {
                    _this.regionList = res.data.result.list;
                    _this.regionCols = res.data.result.cols;
                    console.log(_this.regionList)
                } else {
                    Toast.fail(data.message, 1.5);
                }
            }).catch((e) => {
                Toast.offline(e.message, 1.5)
            });
        }
    }

    //获取报修结果
    @action
    getRepair() {
        console.log('1' + this.isLoading)
        console.log('2' + this.hasMore)
        console.log('3:' + (this.isLoading && !this.hasMore))
        if (this.isLoading && !this.hasMore) {
            return false;
        }

        if (!this.hasMore) {
            return false;
        }

        this.isLoading = true;

        let _this = this;
        axios.post('/XRepair/BackEnd/public/service/common/getRepairList', qs.stringify({page: this.repairListPage++})).then((res) => {
            _this.isLoading = false;
            let data = res.data;
            if (data.code == 200) {
                _this.hasMore = data.row >= 10;
                _this.repairList = [..._this.repairList, ...data.result];
            } else {
                _this.hasMore = false;
                // Toast.fail(data.message, 1.5);
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5)
        });
    }

    @action
    refreshRepairList() {
        this.repairList = [];
        this.repairListPage = 1;
        this.isLoading = false;
        this.hasMore = true;
    }

    @computed
    get repairListDataSource() {
        return this.ds.cloneWithRows(this.repairList.slice());
    }

    @computed
    get isLoadingTitle() {
        if (this.hasMore) {
            return this.isLoading ? '正在努力加载数据...' : '下拉加载';
        } else {
            return '没有数据啦';
        }
    }
}

const repairStore = new RepairStore();

export default repairStore;

export {RepairStore}