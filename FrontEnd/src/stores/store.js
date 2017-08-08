import { observable} from "mobx"

class store {
    @observable token = "123"
    @observable isLogin = false
}

export default new store()