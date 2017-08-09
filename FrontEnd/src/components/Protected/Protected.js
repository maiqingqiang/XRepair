import React from "react";
import {inject, observer} from "mobx-react";
import {Redirect} from "react-router-dom";

export default function Protected(Component) {
    @observer
    @inject("userStore")
    class AuthenticatedComponent extends Component {
        constructor(props) {
            super(props);
            this.store = this.props.store;
        }

        render() {
            const {userStore} = this.props;
            return (
                <div className="authComponent">
                    {userStore.isLogin
                        ? <Component {...this.props} />
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

    return AuthenticatedComponent;
}