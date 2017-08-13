import React from 'react';
import ReactDOM from 'react-dom';
import registerServiceWorker from './registerServiceWorker';
import {BrowserRouter as Router, Route, Switch} from 'react-router-dom'
import {Provider} from "mobx-react";
import {} from 'mobx';
import * as store from './stores';
import routes from './router';
import FastClick from 'fastclick';
import config from './utils/config';
import axios from './utils/axios';

window.addEventListener('load', () => {
    FastClick.attach(document.body);
});

React.Component.prototype.axios = axios;

let basename = window.location.host === config.host ? '/XRepair/BackEnd/public/webapp/app/index' : '';

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
    </Provider>, document.getElementById('container'));
registerServiceWorker();
