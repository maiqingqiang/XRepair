import {observable, action} from "mobx"
import {Toast} from 'antd-mobile'
import axios from 'axios'

class RepairStore {
    @observable regionList = [];
    @observable regionCols = 1;


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
                Toast.offline(e.response.data, 1.5)
            });
        }
    }

}

const repairStore = new RepairStore();

export default repairStore;

export {RepairStore}