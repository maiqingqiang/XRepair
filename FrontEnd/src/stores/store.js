import { observable} from "mobx"

class store {

    @observable token = "123"
}

export default new store()