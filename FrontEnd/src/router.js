import React from 'react';
import LazyRoute from "lazy-route";

const routes = [
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

export default routes