import {observable, action} from "mobx"
import {Toast, ListView} from 'antd-mobile'
import axios from 'axios'
import Qs from 'qs'

class AdminStore {

    @observable generalRepairList = [];
    @observable generalRepairListPage = 1;
    @observable generalIsLoading = false;
    @observable generalHasMore = true;

    @observable repairDetails = [];

    ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});

    //获取报修列表
    @action
    getGeneralRepair(data) {
        if (this.generalIsLoading && !this.generalHasMore) {
            return false;
        }

        if (!this.generalHasMore) {
            return false;
        }

        this.generalIsLoading = true;

        let post = Object.assign(data, {page: this.generalRepairListPage});

        let _this = this;
        axios.post('/XRepair/BackEnd/public/service/admin/repairListPage', Qs.stringify(post)).then((res) => {
            _this.generalIsLoading = false;
            let data = res.data;
            if (data.code == 200) {
                _this.generalHasMore = data.row >= 10;
                if (_this.generalRepairListPage > 1) {
                    _this.generalRepairList = [..._this.generalRepairList, ...data.result];
                } else {
                    _this.generalRepairList = data.result;
                }
                this.generalRepairListPage++;
            } else {
                _this.generalHasMore = false;
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5)
        });
    }

}

const adminStore = new AdminStore();

export default adminStore;

export {AdminStore}