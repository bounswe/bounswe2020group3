import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled,Link } from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import UserNavbar from '../Components/TopBar/UserNavbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import Profilebar from "../Components/ProfileBar/Profilebar";
import {getAccessToken, getUserId, getPhoto, getRequestHeader} from "../Components/Auth/Authenticate";

const Container = styled(Box)({
    backgroundColor: '#f7f7f5',
    background: "#f9f9eb",
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
            name:"",
            desc:"",
            deadline:"",
            date:"",
            type:"",
            url:"",
            notifications: [],
            username:"",
            userlastname:"",
            photoUrl:""
        }
    };

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    };
    goToLogin = () => {
        this.props.history.push("/login");
    };
    goToProjectCreation = () => {
        this.props.history.push(config.Create_Project_Path);
    };

    componentDidMount() {
      var event_id =this.props.location.pathname.split('/')[2];
      axios.get(`${config.API_URL}${config.Event_Creation_Url}${event_id}`, { headers:{'Content-Type':'Application/json'}})
        .then(res => {
          const prof = res.data;
          this.setState({name:prof.title, desc:prof.description, deadline:prof.deadline,  date:prof.date, type:prof.event_type});

        });
      axios.get(`${config.API_URL}/api/users/${getUserId()}/`, { headers:{'Content-Type':'Application/json', 'Authorization': `Token ${getAccessToken()}`}})
        .then(res => {
            let name = res.data.profile[0].name;
            let mname = res.data.profile[0].middle_name;
            let lastname = res.data.profile[0].last_name;
            name = name + " " + mname;
            let photoUrl = (res.data.profile[0].photo_url)
            this.setState({ username:name , userlastname: lastname, photoUrl:photoUrl });
        });
        axios.get(`${config.API_URL}/api/notifications/unread/`,
            getRequestHeader())
            .then(res => {
                console.log((res.data))
                this.setState({notifications: res.data})
            });
    };

    render() {
      return (
        <Container>
          <UserNavbar
            logout={() => { this.props.history.push(config.Login_Path) }}
            pushProfile={() => { this.props.history.push("/profile/" + getUserId()) }}
            goHome={() => { this.props.history.push(config.Homepage_Path) }}
            history ={this.props.history}
            notifications = {this.state.notifications}
          />
            <Box style={{marginTop:"8px"}}>
            <Profilebar
                name={this.state.username}
                lastName={this.state.userlastname}
                photoUrl={getPhoto()}
                goToProjectCreation={this.goToProjectCreation}
                goToEventCreation={() => {this.props.history.push(config.Event_Creation_Path);}}
                goToProfile={() => { this.props.history.push(`/profile/${getUserId()}`); }}
            />
          <Grid container direction="row" justify="space-evenly" alignItems="baseline" style={{marginLeft:"200px", width:`calc(100% - 200px)`}}>
            <Grid item sm={8}>
              <Typography variant="h5" color="primary">{this.state.name}</Typography>
              <Typography variant="h5" color="primary">Event Description</Typography>
              <Paper elevation={6} style={{border: "solid 1px blue", minHeight: "100px", padding:"20px"}}>
                  <Typography variant="body1">{this.state.desc}</Typography>
              </Paper>
            </Grid>
            <Grid item sm={3} >
              <Typography variant="h5" color="primary">Important Dates</Typography>
              <Paper elevation={6} style={{border: "solid 1px blue", minHeight: "100px", marginBottom:"10px", padding:"10px"}}>
                  <Typography variant="body1" color="secondary">Event Date is:</Typography>
                  <Typography variant="body1">{this.state.date}</Typography>
                  <Typography variant="body1" color="secondary">Deadline of Event:</Typography>
                  <Typography variant="body1">{this.state.deadline}</Typography>
              </Paper>
              <Typography variant="h5" color="primary">Event Details</Typography>
              <Paper elevation={6} style={{border: "solid 1px blue", minHeight: "60px", marginBottom:"10px", padding:"10px"}}>
                <Typography variant="body1" color="secondary">{this.state.type.toUpperCase()}</Typography>
                <Link href={this.state.url}>{this.state.name}</Link>
              </Paper>
            </Grid>
            </Grid>
          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
            </Box>
            </Container>);
    }

}
