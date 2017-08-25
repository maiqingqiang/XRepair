import {observable, action, computed} from "mobx"
import {Toast, ListView} from 'antd-mobile'
import axios from 'axios'
import qs from 'qs'

class AdminGeneralListStore {
    @observable repairList = [];
    @observable repairListPage = 1;
    @observable repairCount = null;
    @observable isLoading = false;
    @observable hasMore = true;
    @observable isRefreshing = false;
    @observable refreshing = false;

    ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

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
        axios.post('/XRepair/BackEnd/public/service/admin/getGeneralRepair', qs.stringify({page: this.repairListPage})).then((res) => {
            let data = res.data;
            if (data.code == 200) {
                _this.hasMore = data.result.length >= 10;
                _this.repairList = [..._this.repairList, ...data.result];
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
    getRepair(post=[]) {
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

        // let data = [{page: this.repairListPage},...post];

        let data = Object.assign({page: this.repairListPage},post);

        let _this = this;
        axios.post('/XRepair/BackEnd/public/service/admin/getGeneralRepair', qs.stringify(data)).then((res) => {
            _this.isLoading = false;
            let data = res.data;
            if (data.code == 200) {
                _this.hasMore = data.result.length >= 10;
                _this.repairList = [..._this.repairList, ...data.result];
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

    @computed
    get repairListDataSource() {
        return this.ds.cloneWithRows(this.repairList.slice());
    }

    //刷新报修列表
    @action
    resetRepairList() {
        this.repairList = [];
        this.repairListPage = 1;
        this.isLoading = false;
        this.hasMore = true;
    }

}

const adminGeneralListStore = new AdminGeneralListStore();

export default adminGeneralListStore;

export {AdminGeneralListStore}