import React from "react";
import {inject, observer} from "mobx-react";
import {Redirect} from "react-router-dom";

export default function AdminProtected(Component) {
    @observer
    @inject("userStore")
    class AdminAuthenticatedComponent extends Component {
        constructor(props) {
            super(props);
            this.store = this.props.store;
        }

        render() {
            const {userStore} = this.props;
            return (
                <div className="authComponent">
                    {userStore.isLogin ? userStore.userInfo.isAdmin
                        ? <Component {...this.props} />
                        : <Redirect
                            to={{
                                pathname: "/admin/not-admin",
                                state: {from: this.props.location}
                            }}
                        />
                        : <Redirect
                            to={{
                                pathname: "/login",
                                state: {from: this.props.location}
                            }}
                        />
                    }
                </div>
            );
        }
    }

    return AdminAuthenticatedComponent;
}