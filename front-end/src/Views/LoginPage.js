import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled } from '@material-ui/core';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import Box from '@material-ui/core/Box';
import Typography from "@material-ui/core/Typography";
import AlertTypes from '../Common/AlertTypes.json';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import PrimarySearchAppBar from '../Components/TopBar/PrimarySearchAppBar';
import { setCookie, setIdCookie, setPhotoCookie } from '../Components/Auth/Authenticate';


const Messages = {
    emptyFieldError: "Please Fill All Areas!",
    loginSuccess: "Login Successful",
    loginFail: "Login Failed"

}

const Container = styled(Box)({
    background: "white",
    border: 0,
    borderRadius: 3,
    boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
    color: 'white',
    height: "100vh",
    width: "100%",
    margin: "auto",
    '& .MuiTextField-root': {
        margin: "10px",
        width: "30%",
        minWidth: "250px"
    }
});


export default class LoginPage extends Component {

    constructor(props) {
        super(props);
        this.SnackbarRef = React.createRef();
        this.state = {
            username: "",
            password: "",
            success: null,
            message: "",
            messageType: ""
        }
    }
    handleUsername = event => {
        this.setState({
            username: event.target.value
        })
    }

    handlePassword = event => {
        this.setState({
            password: event.target.value
        });
    };

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    }

    handleSubmit = (event) => {
        const { username, password } = this.state;
        event.preventDefault()
        if (username === "" || password === "") {
            this.setState({ message: Messages.emptyFieldError, messageType: AlertTypes.Warning }, () => {
                this.handleSnackbarOpen();
            });
            return;
        }
        const user = {
            username: username,
            password: password
        };

        axios.post(`${config.API_URL}${config.Login_Url}`, user, { headers: { 'Content-Type': 'Application/json' } })
            .then(res => {
                console.log(res.data.token, "ASD")
                let token = res.data.token;
                let user_id = res.data.id;
                this.setState({ success: true, message: Messages.loginSuccess, messageType: AlertTypes.Success }, () => {
                    setCookie(token);
                    setIdCookie(user_id);
                    this.handleSnackbarOpen();
                    axios.get(`${config.API_URL}/api/users/${user_id}/`)
                    .then(res => {
                    let profile = res.data.profile
                    if (profile && profile.photo_url) setPhotoCookie(profile.photo_url);
                    })
                    setTimeout(() => { this.props.history.push(config.Homepage_Path); }, 1500);
                }, (error) =>{
                    console.log(error, "while fetching photo");
                });
                console.log(res);
                console.log(res.data);
            }, (error) => {
                this.setState({ success: false, message: Messages.loginFail, messageType: AlertTypes.Error });
                this.handleSnackbarOpen();
                console.log(error);
            })
    }


    goToRegister = () => {
        this.props.history.push(config.Register_Path);
    }

    render() {
        return (
            <Container>
                <PrimarySearchAppBar registerNav={this.goToRegister} />
                <form className="" onSubmit={this.handleSubmit}>
                    <Typography variant="h4" color="primary">Login</Typography>
                    <div className="">
                        <TextField
                            type="text"
                            error=""
                            id="standard-error-helper-text"
                            label="Username"
                            onChange={this.handleUsername}
                            defaultValue=""
                            helperText=""
                        />
                    </div>

                    <div className="">
                        <TextField
                            type="password"
                            error=""
                            id="standard-error-helper-text"
                            label="Password"
                            onChange={this.handlePassword}
                            defaultValue=""
                            helperText=""
                        />
                    </div>
                    <Button type="submit" variant="contained" color="primary" className="">Login</Button>
                    <p>
                        <Typography variant='inherit' color="primary">
                            Don't have an account? <a href="/register">Signup!</a>
                        </Typography>
                    </p>
                </form>
                <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
            </Container>);
    }

}    