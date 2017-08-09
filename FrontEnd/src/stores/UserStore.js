import {observable} from "mobx"

class UiStore {
    @observable token = "123";
    @observable isLogin = false;
}

const uiStore = new UiStore();

export default uiStore;

export {UiStore}