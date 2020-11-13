import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled } from '@material-ui/core';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import Box from '@material-ui/core/Box';
import AlertTypes from '../Common/AlertTypes.json';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import PrimarySearchAppBar from '../Components/TopBar/PrimarySearchAppBar';
import { setCookie } from '../Components/Auth/Authenticate';
import { theme } from "../Common/ColorTheme";



const Messages = {
    emptyFieldError: "Please Fill All Areas!",
    loginSuccess: "Login Successful",
    loginFail: "Login Failed"

}

const Container = styled(Box)({
    background: theme.palette.secondary.light,
    border: 0,
    borderRadius: 3,
    height: "100vh",
    width: "100%",
    margin: "auto",
    '& .MuiTextField-root': {
        margin: "10px",
        width: "30%",
        minWidth: "250px"
    }
});


export default function LoginPage(props) {
    const [username, setUsername] = React.useState("");
    const  [password, setPassword] = React.useState("");
    const [message, setMessage] = React.useState("");
    const [messageType, setMessageType] = React.useState("");
    const SnackbarRef = React.createRef();


const handleUsername = event => {
    setUsername(event.target.value);
}


const handlePassword = event => {
    setPassword(event.target.value);
};

const handleSnackbarOpen = () => {
    SnackbarRef.current.turnOnSnackbar();
}

const handleSubmit = (event) => {
    event.preventDefault()
    if (username === "" || password === "") {
        setMessage(Messages.emptyFieldError);
        setMessageType(AlertTypes.Warning);
        handleSnackbarOpen();
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
            setMessage(Messages.loginSuccess);
            setMessageType(AlertTypes.Success);
            setCookie(token);
            handleSnackbarOpen();
            console.log(res);
            console.log(res.data);
        }, (error) => {
            setMessage(Messages.loginSuccess);
            setMessageType(AlertTypes.Success);
            console.log(error);
        })
}


const goToRegister = () => {
    props.history.push(config.Register_Path);
}

return (
    <Container>
        <PrimarySearchAppBar registerNav={goToRegister} />
        <form className="" onSubmit={handleSubmit}>
            <h3>Login</h3>
            <div className="">
                <TextField
                    type="text"
                    error=""
                    id="standard-error-helper-text"
                    label="Username"
                    onChange={handleUsername}
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
                    onChange={handlePassword}
                    defaultValue=""
                    helperText=""
                />
            </div>
            <Button type="submit" variant="contained" color="primary" className="">Login</Button>

            <p className="">
                Don't have an account? <a href="/register">Signup!</a>
            </p>
        </form>
        <CustomSnackbar ref={SnackbarRef} OpenSnackbar={handleSnackbarOpen} type={messageType} message={message} />
    </Container>)
    

}    