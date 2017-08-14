import React from 'react';
import ReactDOM from 'react-dom';
import registerServiceWorker from './registerServiceWorker';
import {BrowserRouter as Router} from 'react-router-dom'
import {Provider} from "mobx-react";
import {} from 'mobx';
import * as store from './stores';
import FastClick from 'fastclick';
import config from './utils/config';
import axios from 'axios';
import App from './App'


window.addEventListener('load', () => {
    FastClick.attach(document.body);
});

axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
axios.defaults.baseURL = 'http://' + config.host;

React.Component.prototype.axios = axios;

let basename = window.location.host === config.host || window.location.host === 'localhost'? '/XRepair/BackEnd/public/webapp/app/index' : '';

ReactDOM.render(
    <Provider {...store}>
        <Router basename={basename}>
            <App/>
        </Router>
    </Provider>, document.getElementById('container'));
registerServiceWorker();
