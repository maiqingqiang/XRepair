import {observable, action} from "mobx"
import axios from 'axios'

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