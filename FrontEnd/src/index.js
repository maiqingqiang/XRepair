import React from 'react';
import ReactDOM from 'react-dom';
import registerServiceWorker from './registerServiceWorker';
import {BrowserRouter as Router, Route, Switch} from 'react-router-dom'
import {Provider} from "mobx-react";
import * as store from './stores';
import routes from './router';
import axios from 'axios';


let host = '192.168.31.188';

axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
axios.defaults.baseURL = 'http://' + host;

React.Component.prototype.axios = axios;

// http request 拦截器
// axios.interceptors.request.use(
//     config => {
//         // if (store.state.token) {
//         //     config.headers.Authorization = store.state.token;
//         // }
//         return config;
//     },
//     err => {
//         return Promise.reject(err);
//     });
//
// // http response 拦截器
// axios.interceptors.response.use(
//     response => {
//         return response;
//     },
//     error => {
//         if (error.response) {
//             switch (error.response.status) {
//                 case 401:
//
//                     break;
//             }
//         }
//         return Promise.reject(error.response.data) // 返回接口返回的错误信息
//     });

let basename = window.location.host === host ? '/XRepair/BackEnd/public/webapp/app/index' : '';

ReactDOM.render(
    <Provider {...store}>
        <Router basename={basename}>
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
        </Router>
    </Provider>, document.getElementById('root'));
registerServiceWorker();
