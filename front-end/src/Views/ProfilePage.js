import React, { Component } from "react";
import { styled } from '@material-ui/core';
import Avatar from '@material-ui/core/Avatar';
import Box from '@material-ui/core/Box';
// import Button from '@material-ui/core/Button';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import { getUserId } from '../Components/Auth/Authenticate';
import axios from 'axios';
import config from '../config';
import UserNavbar from '../Components/TopBar/UserNavbar';

const titleStyle = {
  textAlign: "left"
}
const textStyle = {
  textAlign: "left",
  minHeight: "100px",
  padding: "2px 12px"
}
const Container = styled(Box)({
  background: "#f9f9eb",
  border: 0,
  borderRadius: 3,
  boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
  color: 'white',
  height: "calc(98vh - 64px)",
  paddingBottom: "60px",
  top: "0",
  bottom: "0",
  left: "0",
  right: "0",
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
      name: "",
      middle_name: "",
      last_name: "",
      email: "",
      img: "",
      bio: "",
      age: "",
      expertise: "",
      gender: "",
      interests: ""
    }
  };

  componentDidMount() {
    axios.get(`${config.API_URL}${config.Profilepage_url}?owner__id=${getUserId()}`, { headers: { 'Content-Type': 'Application/json' } })
      .then(res => {
        const prof = res.data[0];
        this.setState({ name: prof.name, middle_name: prof.middle_name, last_name: prof.last_name, bio: prof.bio, img: prof.photo_url, age: prof.age, expertise: prof.expertise, gender: prof.gender, interests: prof.interests });
      })
    axios.get(`${config.API_URL}${config.User_Path}${getUserId()}`, { headers: { 'Content-Type': 'Application/json' } })
      .then(res => {
        this.setState({ email: res.data.email });
      })
  };

  handleSnackbarOpen = () => {
    this.SnackbarRef.current.turnOnSnackbar();
  };
  goToLogin = () => {
    this.props.history.push("/login");
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
        <Avatar src={this.state.img} style={{ width: "150px", height: '150px', margin: 'auto' }} />
        <br />
        <Paper elevation={6} style={{ padding: "10px", minHeight: '30px', maxWidth: "300px", margin: '15px auto 20px auto' }}>
          <Typography>{this.state.name + " " + this.state.middle_name} <br/> 
          {this.state.last_name.toUpperCase()}</Typography>
        </Paper>
        <Grid container direction="row" justify="center" alignItems="center" >


          <Grid container spacing={2} direction="row" justify="space-evenly" alignItems="baseline">
            <Grid item sm={3}>
              Projects
            </Grid>
            <Grid container spacing={2} item sm={6}>

              <Grid item sm={6} >
                <Typography variant="h5" color="primary" style={titleStyle}>Biography</Typography>
                <Paper elevation={6} style={textStyle}>
                  <p>{this.state.bio}</p>
                </Paper>

                <Typography variant="h5" color="primary" style={titleStyle}>Contact Info</Typography>
                <Paper elevation={6} style={textStyle}>
                  <p>{"Email : " + this.state.email}</p>
                </Paper>

              </Grid>
              <Grid item sm={6} >
                <Typography variant="h5" color="primary" style={titleStyle}>Interests</Typography>
                <Paper elevation={6} style={textStyle}>
                  <p>{this.state.expertise} <br />
                    {this.state.interests}
                  We are expecting tags here</p>
                </Paper>

                <Typography variant="h5" color="primary" style={titleStyle}>Personal Information</Typography>
                <Paper elevation={6} style={textStyle}>
                  <p>{"Age : " + this.state.age} <br /> {"Gender : " + this.state.gender}</p>
                </Paper>
              </Grid>
            </Grid>
            <Grid item sm={3}>
              {/*  SAĞDAKİ RELEVANT ŞEYLER BURAYA GELECEK  */}
            </Grid>
          </Grid>
        </Grid>

        <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
      </Container>);
  }

}
