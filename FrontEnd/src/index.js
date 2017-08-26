import React from 'react';
import ReactDOM from 'react-dom';
// import registerServiceWorker from './registerServiceWorker';
import {BrowserRouter as Router} from 'react-router-dom'
import {Provider} from "mobx-react";
import {} from 'mobx';
import * as store from './stores';
import FastClick from 'fastclick';
import config from './utils/config';
import axios from 'axios';
import App from './App'
import URI from 'urijs';


window.addEventListener('load', () => {
    FastClick.attach(document.body);
});

function generateGetCodeUrl(redirectURL) {
    return new URI("https://open.weixin.qq.com/connect/oauth2/authorize")
        .addQuery("appid", config.wechat.appid)
        .addQuery("redirect_uri", redirectURL)
        .addQuery("response_type", "code")
        .addQuery("scope", "snsapi_userinfo")
        .addQuery("response_type", "code")
        .hash("wechat_redirect")
        .toString();
};

const uri = new URI(document.location.href);
const query = uri.query(true);

const {code} = query;

if(code) {
    alert(code)
} else {
    document.location = generateGetCodeUrl(document.location.href);
}

axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
axios.defaults.baseURL = 'http://' + config.host;

React.Component.prototype.axios = axios;

let basename = window.location.host === config.host || window.location.host === 'localhost'? '/XRepair/BackEnd/public/webapp/app/index' : '';

ReactDOM.render(
    <Provider {...store}>
        <Router basename='/XRepair/BackEnd/public/webapp/app/index'>
            <App/>
        </Router>
    </Provider>, document.getElementById('container'));
// registerServiceWorker();
