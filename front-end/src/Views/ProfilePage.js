import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled } from '@material-ui/core';
import Avatar from '@material-ui/core/Avatar';
import TextField from '@material-ui/core/TextField';
import Box from '@material-ui/core/Box';
import Button from '@material-ui/core/Button';
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

    renderAreas(){
      var areas = ["Machine Learning","AI","Deep Learning"];
      return areas.map((item) => {return (<p>{item}</p>)});
    };
    renderBio(){
      var bio = ["Ali Celal Şengör ( born 24 march 1955) is a turkish geologist." ];
      return bio.map((item) => {return (<p>{item}</p>)});
    };
    renderContacts(){
      var contacts = ["Celalsengor1955@gmail.com" ];
      return contacts.map((item) => {return (<p>{item}</p>)});
    };
    renderComments(){
      var comments = ["I worked with him","Celal is a very diciplined and he learns fast"];
      return comments.map((item) => {return (<p>{item}</p>)});
    };
    renderProfile(){
      var info = ["Prof. Ali Celal Şengör","Istanbul"];
      return info.map((item) => {return (<p>{item}</p>)});
    };
    renderGraph(){
      var info = ["Followers:155","Following:255","Favourites:78","Projects:9"];
      return info.map((item) => {return (<Paper>{item}</Paper>)});
    };

    render() {
      // console.log(this.props.history, "asd")
        if (!this.state.success) {
            return (
                <Container>
                  <PrimarySearchAppBar loginNav={this.goToLogin}/>
                  <h1> Profile Page </h1>

                  <Grid container direction="row" justify="left" alignItems="center">
                    <Avatar class="left"/>
                    <Paper>
                    {this.renderProfile()}
                    </Paper>
                  </Grid>
                  <Grid container direction="row" justify="left" alignItems="center">
                  {this.renderGraph()}
                  </Grid>

                  <div class="row">
                    <div class="column left">
                      <h2> Comments </h2>
                      <Paper>
                      {this.renderComments()}
                      </Paper>
                    </div>
                    <div class="column middle">
                      <div>
                        <h2> Biography </h2>
                        <Paper>
                        {this.renderBio()}
                        </Paper>
                      </div>
                      <div>
                      <h2> Contact </h2>
                      <Paper>
                      {this.renderContacts()}
                      </Paper>
                    </div>
                    </div>
                    <div class="column right">
                    <h2> Research Areas </h2>
                      <Paper>
                      {this.renderAreas()}
                      </Paper>
                    </div>
                  </div>
                  <Button type="submit" variant="contained" color="primary" className="">Edit Profile</Button>
                  <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
                </Container>);
        }
        else
            return (<p style={{ color: "green", textAlign: "center", fontWeight: "bold", fontSize: 25, fontFamily: 'Fira Sans' }}>Registration is completed !</p>);

    }

}
