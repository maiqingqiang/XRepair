import {observable, action} from "mobx"
import {Toast} from 'antd-mobile'
import axios from '../utils/axios'

class GeneralStore {
    @observable categoryList = [];
    @observable categoryCols = 1;

    @action
    getCategory() {
        if (this.categoryList.length <= 0) {
            let _this = this;
            axios.get('/XRepair/BackEnd/public/service/General/getCategory').then((res) => {
                let data = res.data;
                if (data.code == 200) {
                    _this.categoryList = res.data.result.list;
                    _this.categoryCols = res.data.result.cols;
                } else {
                    Toast.fail(data.message, 1.5);
                }
            }).catch((e) => {
                Toast.offline(e.message, 1.5);
            });
        }
    }

}

const generalStore = new GeneralStore();

export default generalStore;

export {GeneralStore}