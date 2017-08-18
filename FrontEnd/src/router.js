import React from 'react';
import LazyRoute from "lazy-route";
import General from './routers/General'
import Admin from './routers/Admin'

let routes = [];

routes=[...routes,...General,...Admin];

let Common = [
    {
        path: '/',
        exact: true,
        render: props => (<LazyRoute {...props} component={import('./pages/Home')}/>)
    },
    {
        path: '/login',
        render: props => (<LazyRoute {...props} component={import('./pages/Login')}/>)
    },
    {
        path: '/register',
        render: props => (<LazyRoute {...props} component={import('./pages/Register')}/>)
    },
    {
        path: '/about',
        render: props => (<LazyRoute {...props} component={import('./pages/About')}/>)
    },
    {
        path: '/repair_list',
        render: props => (<LazyRoute {...props} component={import('./pages/RepairList')}/>)
    },
    {
        render: props => (<LazyRoute {...props} component={import('./pages/NoMatch')}/>)
    }
];

routes=[...routes,...Common];

export default routes