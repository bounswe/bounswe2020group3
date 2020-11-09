import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled } from '@material-ui/core';
import Avatar from '@material-ui/core/Avatar';
import TextField from '@material-ui/core/TextField';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import PrimarySearchAppBar from '../Components/TopBar/PrimarySearchAppBar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';


const errorMessages = {
    emptyFieldError: "Please Fill All Areas!"
}

const Container = styled(Box)({
    background: 'linear-gradient(90deg, rgba(0,151,255,1) 10%, rgba(0,151,255,1) 90%)',
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

export default class HomePage extends Component {
    constructor(props) {
        super(props);
        this.SnackbarRef = React.createRef();
        this.state = {
            success: null,
            message: "",
            messageType: ""
        }
    };


    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    };
    goToLogin = () => {
        this.props.history.push("/login");
    };

    renderProject(){
      var projects = ["ML","AI","DL"];
      return projects.map((item) => {return (<p>{item}</p>)});
    };
    renderFeed(){
      var news = ["alpha", "beta", "gama","delta","epsilon","zeta" ];
      return news.map((item) => {return (<p>{item}</p>)});
    };
    renderEvents(){
      var events = ["Hackathon number one","Hackathon number two","Hackathon number three"];
      return events.map((item) => {return (<p>{item}</p>)});
    };

    render() {
      // console.log(this.props.history, "asd")
        if (!this.state.success) {
            return (
                <Container>
                  <PrimarySearchAppBar loginNav={this.goToLogin}/>
                  <Grid container direction="row" justify="center" alignItems="center">
                    <Avatar/>
                  </Grid>
                  <h1> Home Page </h1>
                  <div class="row">
                    <div class="column left">
                      <h2> Projects </h2>
                      <Paper>
                      {this.renderProject()}
                      </Paper>
                    </div>
                    <div class="column middle">
                    <h2> Feeds </h2>
                      <Paper>
                      {this.renderFeed()}
                      </Paper>
                    </div>
                    <div class="column right">
                    <h2> Upcoming Events </h2>
                      <Paper>
                      {this.renderEvents()}
                      </Paper>
                    </div>
                  </div>
                  <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
                </Container>);
        }
        else
            return (<p style={{ color: "green", textAlign: "center", fontWeight: "bold", fontSize: 25, fontFamily: 'Fira Sans' }}>Registration is completed !</p>);

    }

}
