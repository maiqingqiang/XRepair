import React,{Component} from 'react';
import {Route,Redirect} from 'react-router-dom'
import {observer, inject} from 'mobx-react';


@inject("store")
@observer
class PrivateRoute extends Component{
    constructor(props) {
        super(props);
        this.store = props.store;
        this.rest = props.rest;
        this.render = props.render;
    }

    render() {
        const {token,isLogin} = this.store;
        console.log('islogin'+isLogin)
        return (
            <Route {...this.rest} render={isLogin?(this.render):(props => (
                <Redirect to={{pathname: '/login', state: { from: props.location }}}/>
            ))}/>
        );
    }
}


// const PrivateRoute = ({store, render, ...rest }) => (
//     <Route {...rest} render={props.store.isLogin?(props => (
//         <Redirect to={{pathname: '/login', state: { from: props.location }}}/>
//     )):(render)}/>
// );

export default PrivateRoute;
