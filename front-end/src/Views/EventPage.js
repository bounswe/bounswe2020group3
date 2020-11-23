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
            name:"",
            desc:"",
            deadline:"",
            date:"",
            type:"",
            url:"",
        }
    };

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    };
    goToLogin = () => {
        this.props.history.push("/login");
    };
    
    componentDidMount() {
      var event_id =this.props.location.pathname.split('/')[2];
      axios.get(`${config.API_URL}${config.Event_Creation_Url}${event_id}`, { headers:{'Content-Type':'Application/json'}})
        .then(res => {
          const prof = res.data;
          this.setState({name:prof.title, desc:prof.description, deadline:prof.deadline,  date:prof.date, type:prof.event_type});

        })
    };

    render() {
      return (
        <Container>
          <UserNavbar
            logout={() => { this.props.history.push(config.Login_Path) }}
            pushProfile={() => { this.props.history.push("/profile") }}
            goHome={() => { this.props.history.push(config.Homepage_Path) }}
          />
          <Typography variant="h4" color="primary">Event Page</Typography>
          <Grid container direction="row" justify="space-evenly" alignItems="baseline">
            <Grid item sm={1}/>
            <Grid item sm={6}>
              <Typography variant="h5" color="primary">{this.state.name}</Typography>
              <Typography variant="h5" color="primary">Brief Description</Typography>
              <Paper elevation={6} style={{minHeight: "100px"}}>
              <p>{this.state.desc}</p>
              </Paper>
            </Grid>
            <Grid item sm={3}>
              <Typography variant="h5" color="primary">Dates</Typography>
              <Paper elevation={6} style={{minHeight: "100px"}}>
              <p>Event Date is: {this.state.date}</p>
              <p>Deadline of Event: {this.state.deadline}</p>
              </Paper>
              <Typography variant="h5" color="primary">Event Details</Typography>
              <Paper elevation={6} style={{minHeight: "100px"}}>
              <p>{this.state.type}</p>
              <Link href={this.state.url}>{this.state.name}</Link>
              </Paper>
            </Grid>
            </Grid>
          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
        </Container>);
    }

}
