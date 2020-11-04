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


const errorMessages = {
    emptyFieldError: "Please Fill All Areas!"
}

  const Container = styled(Box)({
    background: 'linear-gradient(90deg, rgba(0,151,255,1) 10%, rgba(255,106,106,1) 50%, rgba(0,151,255,1) 90%)',

    border: 0,
    borderRadius: 3,
    boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
    color: 'white',
    height: "100vh",
    width: "100%",
    margin: "auto",
    // padding: '10px 30px',
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
            name: "",
            surname: "",
            email: "",
            password: "",
            success: null,
            message: "",
            messageType: ""
        }
    }

    handleFirstname = event => {
        this.setState({
            name: event.target.value
        });
    };

    handleSurname = event => {
        this.setState({
            surname: event.target.value
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
        const { name, surname, email, password, message } = this.state;
        event.preventDefault()
        if (name === "" || surname === "" || email === "" || password === "" )
        {
            console.log("open")
            
            this.setState({message: errorMessages.emptyFieldError, messageType:AlertTypes.Warning} , () => {
                this.handleSnackbarOpen();
            });
            return ;     
        } 
        const user = {
            name: name.concat(" ", surname),
            email: email,
            password: password
        };

        axios.post(`${config.API_URL}/api/register`, user, { headers: { 'Content-Type': 'Application/json' } })
            .then(res => {
                this.setState({ success: true });
                console.log(res);
                console.log(res.data);
            }, (error) => {
                this.setState({ success: false });
                const temp = JSON.stringify(error.response.data);   
                const temp2 = JSON.parse(temp);
                this.setState({ message: temp2["message"] });
                console.log(error);
            })
    }

    render() {
        if (!this.state.success) {
            return (
                <Container>
                   <PrimarySearchAppBar/>
                    <form className="" onSubmit={this.handleSubmit}>
                        <h3>Registration</h3>
                        <div className="">
                            <TextField
                                error=""
                                id="standard-error-helper-text"
                                label="First Name"
                                onChange={this.handleFirstname}
                                defaultValue=""
                                helperText=""
                            />
                        </div>

                        <div className="">

                            <TextField
                                error=""
                                id="standard-error-helper-text"
                                label="Last Name"
                                onChange={this.handleSurname}
                                defaultValue=""
                                helperText=""
                            />
                        </div>

                        <div className="">
                            <TextField
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
                                type="password"
                                error=""
                                id="standard-error-helper-text"
                                label="Password"
                                onChange={this.handlePassword}
                                defaultValue=""
                                helperText=""
                            />
                        </div>

                 
                        <Button type="submit" variant="contained" color="primary" className="">Register</Button>

                        <p className="">
                            Already registered? <a href="/login">Login.</a>
                        </p>
                    </form>
                    <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
                </Container>);
        }
        else
            return (<p style={{ color: "green", textAlign: "center", fontWeight: "bold", fontSize: 25, fontFamily: 'Fira Sans' }}>Registration is completed !</p>);

    }

}    