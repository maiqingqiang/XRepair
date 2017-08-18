import React from 'react';
import LazyRoute from "lazy-route";

export default [
    {
        path: '/general/index',
        render: props => (<LazyRoute {...props} component={import('./../modules/General/Index')}/>)
    },
    {
        path: '/general/details/:id',
        render: props => (<LazyRoute {...props} component={import('./../modules/General/Details')}/>)
    },
]