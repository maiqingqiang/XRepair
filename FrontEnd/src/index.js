import React from 'react';
import ReactDOM from 'react-dom';
import {BrowserRouter as Router} from 'react-router-dom'
import {Provider} from "mobx-react";
import * as store from './stores';
import FastClick from 'fastclick';
import axios from 'axios';
import App from './App'
import URI from 'urijs';
import qs from 'qs';

axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
axios.defaults.baseURL = 'http://' + window.location.host;

function generateGetCodeUrl(id) {
    document.location = new URI("https://open.weixin.qq.com/connect/oauth2/authorize")
        .addQuery("appid", id)
        .addQuery("redirect_uri", document.location.href)
        .addQuery("response_type", "code")
        .addQuery("scope", "snsapi_userinfo")
        .addQuery("response_type", "code")
        .hash("wechat_redirect")
        .toString();
}

let ua = navigator.userAgent.toLowerCase();
if (ua.match(/MicroMessenger/i) == "micromessenger") {
    if (localStorage.wxUserInfo) {
        store.userStore.wxUserInfo = JSON.parse(localStorage.wxUserInfo);
        store.userStore.wxLogin()
    } else {
        const uri = new URI(document.location.href);
        const query = uri.query(true);
        const {code} = query;
        if (code) {
            axios.post('/XRepair/BackEnd/public/service/public/getWxUserInfo', qs.stringify({code})).then((res) => {
                store.userStore.wxUserInfo = res.data;
                localStorage.wxUserInfo = JSON.stringify(res.data);
                store.userStore.wxLogin()
            });
        } else {
            if (localStorage.appid) {
                generateGetCodeUrl(localStorage.appid);
            } else {
                axios.get('/XRepair/BackEnd/public/service/public/getAppId').then((res) => {
                    let data = res.data;
                    if (data.code == 200) {
                        localStorage.appid = data.result;
                        generateGetCodeUrl(data.result);
                    }
                });
            }
        }
    }
}
window.addEventListener('load', () => {
    FastClick.attach(document.body);
});

React.Component.prototype.axios = axios;

let basename = window.location.host+':'+window.location.port !== '192.168.31.188:8080' ? '/XRepair/BackEnd/public/webapp/app/index' : '';

ReactDOM.render(
    <Provider {...store}>
        <Router basename={basename}>
            <App/>
        </Router>
    </Provider>, document.getElementById('container'));
