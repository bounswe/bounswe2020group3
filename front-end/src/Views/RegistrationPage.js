import React, { Component } from "react";
import "../App.css"
import axios from 'axios';
import { styled } from '@material-ui/core';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import AlertTypes from '../Common/AlertTypes.json';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import PrimarySearchAppBar from '../Components/TopBar/PrimarySearchAppBar';
import config from "../config";
import Box from '@material-ui/core/Box';
import { theme } from "../Common/ColorTheme";
import Typography from '@material-ui/core/Typography';

const Messages = {
    emptyFieldError: "Please Fill All Areas!",
    registerSuccess: "Registration Successful! You'll be redirected to login.",
    somethingWrong : "Something Went Wrong!"

}
  const Container = styled(Box)({
    // background: theme.palette.secondary.light,
    background: "white",
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

export default class RegistrationPage extends Component {
    
    constructor(props) {
        super(props);
        this.SnackbarRef = React.createRef();
        this.state = {
            username: "",
            email: "",
            password: "",
            success: null,
            message: "",
            messageType: "",
        }
    }

    handleUsername = event => {
        this.setState({
            username: event.target.value
        });
    };

    handleEmail = event => {
        this.setState({
            email: event.target.value
        });
    };

    handlePassword = event => {
        this.setState({
            password: event.target.value
        });
    };

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    }

    handleSubmit = (event) => {
        const { username, email, password } = this.state;
        event.preventDefault()
        if (username === ""|| email === "" || password === "" )
        {
            console.log("open")
            
            this.setState({message: Messages.emptyFieldError, messageType:AlertTypes.Warning, password:""} , () => {
                this.handleSnackbarOpen();
            });
            return ;     
        } 
        const user = {
            username: username,
            email: email,
            password: password
        };
        
        axios.post(`${config.API_URL}${config.Register_Url}`, user, { headers: { 'Content-Type': 'Application/json' } })
            .then(res => {
                this.setState({ success: true, messageType: AlertTypes.Success, message: Messages.registerSuccess }, () => {
                    this.handleSnackbarOpen()
                });
                console.log(res);
                console.log(res.data);
                setTimeout(() => { this.props.history.push(config.Login_Path); }, 5000);    


            }, (error) => {
                this.setState({ success: false, messageType:AlertTypes.Error, message: Messages.somethingWrong } , () =>{
                    this.handleSnackbarOpen();
                });
                console.log(error);
            })
    }
    goToLogin = () => {
        this.props.history.push(config.Login_Path);
    }
    goToRegister = () => {
        this.props.history.push(config.Register_Path);
    }

    render() {
        console.log(theme.palette)
            return (
                <Container color="secondary">
                  <PrimarySearchAppBar  loginNav={this.goToLogin}/>
                    <form className="" onSubmit={this.handleSubmit}>
                        <Typography variant="h5" color="textPrimary">Registration</Typography>
                        <div className="">
                            <TextField
                                color="primary"
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
                                color="primary"
                                type="email"
                                error=""
                                id="standard-error-helper-text"
                                label="Email"
                                onChange={this.handleEmail}
                                defaultValue=""
                                helperText=""
                            />
                        </div>

                        <div className="">
                            <TextField
                                color="primary"
                                type="password"
                                error=""
                                id="standard-error-helper-text"
                                label="Password"
                                onChange={this.handlePassword}
                                defaultValue=""
                                helperText=""
                            />
                        </div>
                 
                        <Button type="submit" variant="contained"  color="primary" className=""   /*style={{color: "#c3fdff", backgroundColor:"#90caf9"}}*/ >Register</Button>

                        <p className="">
                            Already registered? <a href="/login">Login.</a>
                        </p>
                    </form>
                    <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
                </Container>);
    }
}    