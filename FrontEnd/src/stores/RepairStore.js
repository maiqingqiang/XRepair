import {observable, action,computed} from "mobx"
import {Toast,ListView} from 'antd-mobile'
import axios from 'axios'

class RepairStore {
    @observable regionList = [];
    @observable regionCols = 1;
    @observable repairList = [];
    @observable repairListPage = 1;
    @observable isLoading = false;
    @observable hasMore = true;

    constructor(){
        const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
        this.repairList = ds.cloneWithRows([]);
    }


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

    @action
    getRepair() {
        if (this.isLoading && !this.hasMore) {
            return;
        }
        let _this = this;
        this.isLoading = true;
        axios.post('/XRepair/BackEnd/public/service/common/getRepairList').then((res) => {
            console.log(1)
            this.isLoading = false;
            let data = res.data;
            if (data.code == 200) {
                _this.hasMore = data.row >= 25;
                // _this.repairList=[
                //     'John', 'Joel', 'James', 'Jimmy', 'Jackson', 'Jillian', 'Julie', 'Devin'
                // ];

                _this.repairList = _this.repairList.cloneWithRows(data.result);

                console.log(_this.repairList)
            } else {
                _this.hasMore = false;
                Toast.fail(data.message, 1.5);
            }
        }).catch((e) => {
            this.isLoading = false;
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

    // ds = new ListView.DataSource({ rowHasChanged: (r1,r2) => r1 !== r2});
    //
    // @computed get datasourceRepairList(){
    //        return this.ds.cloneWithRows(this.repairList.slice())
    //   	  }
}

const repairStore = new RepairStore();

export default repairStore;

export {RepairStore}