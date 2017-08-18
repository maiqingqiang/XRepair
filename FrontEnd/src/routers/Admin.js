import React from 'react';
import LazyRoute from "lazy-route";

export default [
    {
        path: '/admin/not-admin',
        render: props => (<LazyRoute {...props} component={import('./../modules/Admin/NotAdmin')}/>)
    },
]