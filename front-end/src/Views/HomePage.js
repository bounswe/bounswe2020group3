import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { Button, styled } from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import UserNavbar from '../Components/TopBar/UserNavbar';

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

export default class HomePage extends Component {
    constructor(props) {
        super(props);
        this.SnackbarRef = React.createRef();
        this.state = {
            message: "",
            messageType: "",
            projects:[],
            events:[]
        }
    };

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    };
    goToLogin = () => {
        this.props.history.push(config.Login_Path);
    };
    goToRegister = () => {
        this.props.history.push(config.Register_Path);
    };
    goToProjectCreation = () => {
      this.props.history.push(config.Create_Project_Path);
    };
    goToEventCreation = () => {
      this.props.history.push(config.Event_Creation_Path);
    };
    goToProject = (pid) => {
      this.props.history.push(config.Projectpage_Path+"/"+pid);
    };
    goToEvent = (eid) => {
      this.props.history.push(config.Event_Path+"/"+eid);
    };

    componentDidMount() {
      axios.get(`${config.API_URL}${config.Create_Project_Url}`, { headers:{'Content-Type':'Application/json'}})
        .then(res => {
          const projects = res.data;
          console.log(projects);
          this.setState({ projects:projects });
        });
      axios.get(`${config.API_URL}${config.Event_Creation_Url}`, { headers:{'Content-Type':'Application/json'}})
        .then(res => {
          this.setState({ events:res.data });
        });
    }

    renderProject(){
      var projects = this.state.projects;
      return projects.map((item) => {return (<Grid item><Button variant="outlined" color="primary" style={{width:"100%"}} onClick={()=> this.goToProject(item.id)}>{item.name}</Button></Grid>)});
    };
    renderFeed(){
      var news = [];
      return news.map((item) => {return (<p>{item}</p>)});
    };
    renderEvents(){
      var events = this.state.events;
      console.log("events is:",events);
      return events.map((item) => {return (<Grid item><Button variant="outlined" color="primary" style={{width:"100%"}} onClick={()=> this.goToEvent(item.id)}>{item.title}</Button></Grid>)});
    };

    render() {
      return (
        <Container>
        <UserNavbar
            logout={() => { this.props.history.push(config.Login_Path) }}
            pushProfile={() => { this.props.history.push("/profile") }}
            goHome={() => { this.props.history.push(config.Homepage_Path) }}
          />
          <Typography variant="h4" color="primary">Home Page</Typography>
          <Grid container spacing={2} direction="row" justify="space-between" alignItems="baseline">
            <Grid  item sm={3} >
              <Grid style={{maxHeight:"75vh", overflowY:"scroll"}} item sm={12}>
              <Typography variant="h5" color="primary">Projects</Typography>
              <Paper style={{minHeight: "250px"}} elevation={6}>
              {this.renderProject()}
              </Paper>
              </Grid>
              <Button variant="contained" color="primary" style={{marginTop:"10px"}} onClick={this.goToProjectCreation}>Create a Project</Button>
            </Grid>
            <Grid item sm={6} >
              <Typography variant="h5" color="primary">Feed</Typography>
              <Paper style={{minHeight: "350px"}} elevation={6}>
              {this.renderFeed()}
              </Paper>
            </Grid>
            <Grid item sm={3} >
            <Grid style={{maxHeight:"75vh", overflowY:"scroll"}} item sm={12}>
              <Typography variant="h5" color="primary">Upcoming Events</Typography>
              <Paper style={{minHeight: "250px"}} elevation={6}>
              {this.renderEvents()}
              </Paper>
              </Grid>
              <Button variant="contained" color="primary" style={{marginTop:"10px"}} onClick={this.goToEventCreation}>Create an Event</Button>
            </Grid>
          </Grid>
          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
        </Container>);
    }
}
