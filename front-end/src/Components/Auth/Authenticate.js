import Cookies from 'js-cookie'
import config from '../../config';
import { Route } from "react-router-dom";
import React, { Component } from "react";


export const getAccessToken = () => Cookies.get('access_token')
export const getRefreshToken = () => Cookies.get('refresh_token')
export const getUserId = () => Cookies.get('user_id');
export const isAuthenticated = () => !!getAccessToken()

export const setCookie = (token) => {
    Cookies.set("access_token", token);
}
export const setIdCookie = (id) => {
    Cookies.set("user_id", id);
}

export const authenticate = async () => {
    if (getAccessToken() && getUserId()) {
        return true;
    }
    redirectToLogin()
    return false
}

const redirectToLogin = () => {
    window.location.replace(`http://localhost:3000${config.Login_Path}`);
}
export const AuthenticatedRoute = ({
    component: Component,
    exact,
    path,
}) => (
        <Route
            exact={exact}
            path={path}
            render={props =>
                isAuthenticated() ? (
                    <Component {...props} />
                ) : (
                        <AuthenticateBeforeRender render={() => <Component {...props} />} />
                    )
            }
        />
    )
class AuthenticateBeforeRender extends Component {
    state = {
        isAuthenticated: false,
    }

    componentDidMount() {
        authenticate().then(isAuthenticated => {
            this.setState({ isAuthenticated })
        })
    }

    render() {
        return this.state.isAuthenticated ? this.props.render() : null
    }
}
export default AuthenticateBeforeRender;