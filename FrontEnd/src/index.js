import React from 'react';
import ReactDOM from 'react-dom';
import registerServiceWorker from './registerServiceWorker';
import {BrowserRouter as Router, Route,Switch} from 'react-router-dom'
import {Provider} from "mobx-react";
import store from './stores/store';
import routes from './router';


ReactDOM.render(
    <Provider store={store}>
        <Router>
            <div>
                <Switch>
                    {routes.map((route, index) => (
                        <Route
                            key={index}
                            path={route.path}
                            exact={route.exact}
                            render={route.render}
                        />
                    ))}
                </Switch>
            </div>
        </Router>
    </Provider>, document.getElementById('root'));
registerServiceWorker();
