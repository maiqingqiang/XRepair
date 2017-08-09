import {observable} from "mobx"

class AppStore {
    @observable selectedTab = 'homeTab'
}

const appStore = new AppStore();

export default appStore;

export {AppStore}