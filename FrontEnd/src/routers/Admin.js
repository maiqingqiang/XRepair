import React from 'react';
import LazyRoute from "lazy-route";

export default [
    {
        path: '/admin/index',
        render: props => (<LazyRoute {...props} component={import('./../modules/Admin/Index')}/>)
    },
    {
        path: '/admin/general',
        render: props => (<LazyRoute {...props} component={import('./../modules/Admin/General')}/>)
    },
    {
        path: '/admin/general-list',
        render: props => (<LazyRoute {...props} component={import('./../modules/Admin/GeneralList')}/>)
    },
    {
        path: '/admin/general-order',
        render: props => (<LazyRoute {...props} component={import('./../modules/Admin/GeneralOrder')}/>)
    },
    {
        path: '/admin/net',
        render: props => (<LazyRoute {...props} component={import('./../modules/Admin/Net')}/>)
    },
]