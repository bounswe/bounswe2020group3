import React, { Component } from "react";
import "../App.css"
import axios from 'axios';
import { styled } from '@material-ui/core';
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
    somethingWrong: "Something Went Wrong!",
    emptyNameError: "Please enter your name and surname."

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
            lastName: "",
            middleName: "",
            firstName: "",
            check: false
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
    handleFirstName = event => {
        this.setState({
            firstName: event.target.value
        })
    }
    handleMiddleName = event => {
        this.setState({
            middleName: event.target.value
        })
    }
    handleLastName = event => {
        this.setState({
            lastName: event.target.value
        })
    }

    handleSubmit = (event) => {
        const { username, email, password, firstName, lastName, middleName } = this.state;
        event.preventDefault()
        if (username === "" || email === "" || password === "") {
            console.log("open")

            this.setState({ message: Messages.emptyFieldError, messageType: AlertTypes.Warning, password: "" }, () => {
                this.handleSnackbarOpen();
            });
            return;
        }
        if (firstName === "" || lastName === "") {
            this.setState({ message: Messages.emptyNameError, messageType: AlertTypes.Warning }, () => {
                this.handleSnackbarOpen();
            });
            return;
        }
        const user = {
            first_name: firstName,
            middle_name: middleName,
            last_name: lastName,
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
                this.setState({ success: false, messageType: AlertTypes.Error, message: Messages.somethingWrong }, () => {
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
    checkBoxTest(){
        this.setState({check: !this.state.check})
    }

    render() {
        console.log(theme.palette)
        console.log("baby")
        return (
            <Container color="secondary">
                <PrimarySearchAppBar loginNav={this.goToLogin} />
                <form className="" onSubmit={this.handleSubmit}>
                    <Typography variant="h5" color="primary"></Typography>
                    <div className="">
                        <h1>Terms and Conditions</h1>
                        <p>
                            YAZI BURAYA YAZILACAK AMA NE YAZILMASI VE NASIL YAZILMASI GEREKTİĞİ KONUSUNDA KALAKALDIM !!!
                        </p>
                        
                    </div>

                    
                </form>
                <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
            </Container>);
    }
}    