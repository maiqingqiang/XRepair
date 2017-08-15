import React, {Component} from 'react';
import {observer,inject} from 'mobx-react';
import {Route, Switch,withRouter} from 'react-router-dom'
import routes from './router';

@withRouter
@inject('userStore')
@observer
export default class App extends Component {

    componentDidMount() {
        this.props.userStore.getToken();
        this.axios.interceptors.request.use(
            config => {
                if (this.props.userStore.token) {
                    config.headers.Authorization = this.props.userStore.token;
                    config.headers.method = 'OPTIONS';
                }
                return config;
            },
            err => {
                return Promise.reject(err);
            });

        this.axios.interceptors.response.use(
            response => {
                return response;
            },
            error => {
                console.log(error.response)
                if (error.response) {
                    switch (error.response.status) {
                        case 401:
                            this.props.history.replace('/login',{from:this.props.history.location});
                            this.props.userStore.clearData();
                            break;
                    }
                }
                return Promise.reject(error)
            });
    }

    render() {
        return (
            <div>
                <Switch>
                    {routes.map((route, index) => (
                        <Route
                            key={index}
                            path={route.path}
                            exact={route.exact}
                            render={route.render}/>
                    ))}
                </Switch>
            </div>
        )
    }
}