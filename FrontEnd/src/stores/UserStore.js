import {observable, action} from "mobx"
import {Toast} from 'antd-mobile'
import axios from 'axios'
import Qs from 'qs';

class UiStore {
    @observable token = '';
    @observable isLogin = false;
    @observable userInfo = [];

    @action
    clearData() {
        this.userInfo = [];
        this.isLogin = false;
        this.token = '';
    }


    @action
    setToken(token,userInfo){
        this.isLogin=true;
        this.token=token;
        this.userInfo=userInfo;
    }

    @action
    updateToken(){
        axios.post('/XRepair/BackEnd/public/service/common/updateToken').then((res) => {
            let data = res.data;
            if (data.code == 200) {
                this.setToken(data.result.token,data.result.userInfo);
            }
        });
    }

    @action
    updateUserInfo(userInfo){
        Toast.loading('正在提交中…',0);
        axios.post('/XRepair/BackEnd/public/service/common/updateUserInfo', Qs.stringify(userInfo)).then((res) => {
            let data = res.data;
            if (data.code == 200) {
                this.updateToken();
                Toast.success(data.message,1.5);
            } else{
                Toast.fail(data.message, 1.5);
            }
        }).catch((e) => {
            Toast.offline(e.message, 1.5);
        });
    }


    @action
    getToken(){
        axios.post('/XRepair/BackEnd/public/service/public/getToken').then((res) => {
            let data = res.data;
            if (data.code == 200) {
                this.setToken(data.result.token,data.result.userInfo);
            }
        });
    }
}

const uiStore = new UiStore();

export default uiStore;

export {UiStore}