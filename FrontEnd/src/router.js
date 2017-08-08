import React from 'react';
import LazyRoute from "lazy-route";
import General from './routers/General'

let routes = [];

routes=[...routes,...General];

let Common = [
    {
        path: '/',
        exact: true,
        render: props => (<LazyRoute {...props} component={import('./pages/Home')}/>)
    },
    {
        path: '/about',
        exact: true,
        render: props => (<LazyRoute {...props} component={import('./pages/About')}/>)
    },
    {
        render: props => (<LazyRoute {...props} component={import('./pages/NoMatch')}/>)
    },
];

routes=[...routes,...Common];

export default routes