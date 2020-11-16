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
import SvgIcon from '@material-ui/core/SvgIcon';

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
      var projects = ["Machine Learning Project"];
      return projects.map((item) => {return (<h2>{item}</h2>)});
    };
    renderDesc(){
      var projects = ["Fake news spreads like a wildfire and this is a big issue in this area. learning how to distinguish fake news from a real one is an important concept."];
      return projects.map((item) => {return (<p>{item}</p>)});
    };
    renderColab(){
      var projects = ["ML techniques","Social Networks","Scale Free Graphs"];
      return projects.map((item) => {return (<p>{item}</p>)});
    };
    renderComment(){
      var projects = ["It is a good project"];
      return projects.map((item) => {return (<p>{item}</p>)});
    };
    renderContributor(){
      var news = ["alpha", "beta", "gama","delta" ];
      return news.map((item) => {return (<p>{item}</p>)});
    };
    renderUpdate(){
      var events = ["Update number one","Update number two","Update number three"];
      return events.map((item) => {return (<p>{item}</p>)});
    };
    renderGraph(){
      var events = ["39"];
      return events;
    };

    render() {
        if (!this.state.success) {
            return (
                <Container>
                  <PrimarySearchAppBar loginNav={this.goToLogin}/>
                  <h1> Project Page </h1>
                  <Grid container direction="row" justify="space-evenly" alignItems="baseline">
                    <Grid item sm={1}/>
                    <Grid item sm={6}>
                      {this.renderProject()}
                      <h2> Brief Description </h2>
                      <Paper>
                      {this.renderDesc()}
                      </Paper>
                      <h2> Colaboration Qualifications </h2>
                      <Paper>
                      {this.renderColab()}
                      </Paper>
                      <h2> Comments </h2>
                      <Paper>
                      {this.renderComment()}
                      </Paper>
                    </Grid>
                    <Grid item sm={3}>
                      <Paper>
                      <SvgIcon><svg width="24" height="24" viewBox="0 0 24 24"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg></SvgIcon>
                      Follow({this.renderGraph()})
                      </Paper>
                      <h2> Contributors </h2>
                      <Paper>
                      {this.renderContributor()}
                      </Paper>
                      <h2> Recent Updates </h2>
                      <Paper>
                      {this.renderUpdate()}
                      </Paper>
                    </Grid>
                    </Grid>
                  <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
                </Container>);
        }
    }

}
