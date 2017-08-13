import {observable,action} from "mobx"

class UiStore {
    @observable token = '';
    @observable isLogin = false;

    @action
    cleanData(){
        this.isLogin= false;
        this.token = '';
    }
}

const uiStore = new UiStore();

export default uiStore;

export {UiStore}