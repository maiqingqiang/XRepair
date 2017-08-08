import React from 'react';
import LazyRoute from "lazy-route";

export default [
    {
        path: '/general/index',
        exact: true,
        render: props => (<LazyRoute {...props} component={import('./../modules/General/index')}/>)
    },
]