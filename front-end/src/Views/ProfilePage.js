import React, { Component } from "react";
import { styled } from '@material-ui/core';
import Avatar from '@material-ui/core/Avatar';
import Box from '@material-ui/core/Box';
import Button from '@material-ui/core/Button';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import { getUserId } from '../Components/Auth/Authenticate';
import axios from 'axios';
import config from '../config';
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
            name:"",
            middle_name:"",
            last_name:"",
            email:"",
            img:"",
            bio:"",
            age:"",
            expertise:"",
            gender:"",
            interests:""
        }
    };

    componentDidMount() {
      axios.get(`${config.API_URL}${config.Profilepage_url}?owner__id=${getUserId()}`, { headers:{'Content-Type':'Application/json'}})
        .then(res => {
          const prof = res.data[0];
          this.setState({name:prof.name, middle_name:prof.middle_name, last_name:prof.last_name, bio:prof.bio, img:prof.photo_url, age:prof.age, expertise:prof.expertise, gender:prof.gender, interests:prof.interests});
        })
        axios.get(`${config.API_URL}${config.User_Path}${getUserId()}`, { headers:{'Content-Type':'Application/json'}})
          .then(res => {
            this.setState({email:res.data.email});
          })
    };

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    };
    goToLogin = () => {
        this.props.history.push("/login");
    };
    goToEditProfile = () => {
      this.props.history.push(config.Edit_Profile_Path);
    };

    render() {
      return (
        <Container>
        <UserNavbar
          logout={() => { this.props.history.push(config.Login_Path) }}
          pushProfile={() => { this.props.history.push("/profile") }}
          goHome={() => { this.props.history.push(config.Homepage_Path) }}
        />
          <Typography variant="h4" color="primary">Profile Page</Typography>
          <Grid container direction="row" justify="left" alignItems="center" >
            <Avatar src={this.state.img} class="left"/>
            <Paper elevation={6} style={{minWidth: "150px"}}>
            <p>{this.state.name+" "+this.state.last_name}</p>
            </Paper>
          </Grid>

          <Grid container spacing={2} direction="row" justify="space-evenly" alignItems="baseline">
            <Grid item sm={3}>
            </Grid>
            <Grid item sm={6}>
                <Typography variant="h5" color="primary">Biography</Typography>
                <Paper elevation={6} style={{minHeight: "100px"}}>
                <p>{this.state.bio}</p>
                </Paper>
                <Typography variant="h5" color="primary">Contact</Typography>
              <Paper elevation={6}>
              <p>{this.state.email}</p>
              </Paper>
              <Button variant="contained" color="primary" className="" onClick={this.goToEditProfile}>Edit Profile</Button>
            </Grid>
            <Grid item sm={3}>
              <Typography variant="h5" color="primary">Research Areas</Typography>
              <Paper elevation={6} style={{minHeight: "100px"}}>
              <p>{this.state.interests}</p>
              </Paper>
            </Grid>
          </Grid>

          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
        </Container>);
}

}
