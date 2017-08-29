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
    @observable isRefreshing = false;
    @observable refreshing = false;

    @observable repairDetails = [];

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
                } else {
                    Toast.fail(data.message, 1.5);
                }
            }).catch((e) => {
                Toast.offline(e.message, 1.5)
            });
        }
    }

    @action
    onRefresh() {
        if (this.isRefreshing) {
            return
        } else {
            this.refreshing = true;
            this.isRefreshing = true;
        }

        this.repairListPage = 1;
        this.repairList = []

        let _this = this;
        axios.post('/XRepair/BackEnd/public/service/common/getRepairList', qs.stringify({page: this.repairListPage})).then((res) => {
            let data = res.data;
            if (data.code == 200) {
                _this.hasMore = data.row >= 10;
                if (this.repairListPage > 1) {
                    _this.repairList = [..._this.repairList, ...data.result];
                } else {
                    _this.repairList = data.result;
                }
                this.repairListPage++;

                if (_this.isRefreshing) {
                    _this.refreshing = false;
                    _this.isRefreshing = false;
                }
            } else {
                _this.hasMore = false;
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5)
        });
    }

    //获取报修列表
    @action
    getRepair() {
        if (this.isRefreshing) {
            return
        }

        if (this.isLoading) {
            return false;
        }

        if (!this.hasMore) {
            return false;
        }

        this.isLoading = true;

        let _this = this;
        axios.post('/XRepair/BackEnd/public/service/common/getRepairList', qs.stringify({page: this.repairListPage})).then((res) => {
            _this.isLoading = false;
            let data = res.data;
            if (data.code == 200) {
                _this.hasMore = data.row >= 10;
                if (this.repairListPage > 1) {

                    _this.repairList = [..._this.repairList, ...data.result];
                } else {
                    _this.repairList = data.result;

                }
                this.repairListPage++;

                if (this.isRefreshing) {
                    this.refreshing = false;
                    this.isRefreshing = false;
                }
            } else {
                _this.hasMore = false;
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5)
        });
    }

    //获取报修详情
    @action
    getRepairDetails(id) {
        this.repairDetails = [];
        let _this = this;
        axios.post('/XRepair/BackEnd/public/service/common/getRepairDetails', qs.stringify({id})).then((res) => {
            let data = res.data;
            if (data.code == 200) {
                _this.repairDetails = data.result;
            } else {
                Toast.fail(data.message, 1.5)
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5)
        });
    }

    @action
    cancelOrder = (id) => {
        axios.post('/XRepair/BackEnd/public/service/common/cancelOrder', qs.stringify({id})).then((res) => {
            let data = res.data;
            if (data.code == 200) {
                Toast.success(data.message, 1, () => {
                    this.onRefresh();
                    window.history.back();
                });
            } else {
                Toast.fail(data.message, 1.5)
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5)
        });
    };

    //刷新报修列表
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

    @computed
    get getRepairStatus() {
        return this.repairDetails.status ? this.repairDetails.status : 0;
    }
}

const repairStore = new RepairStore();

export default repairStore;

export {RepairStore}