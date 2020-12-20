import React, { Component } from "react";
import { Button, styled } from '@material-ui/core';
import Avatar from '@material-ui/core/Avatar';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import { getUserId, getAccessToken } from '../Components/Auth/Authenticate';
import axios from 'axios';
import config from '../config';
import UserNavbar from '../Components/TopBar/UserNavbar';
const privateGender = "do not want to share";
const titleStyle = {
  textAlign: "left",
  marginTop: "10px"
}
const titleStyleCenter = {
  textAlign: "center",
  marginTop: "10px"
}
const textStyle = {
  textAlign: "left",
  minHeight: "100px",
  padding: "2px 12px"
}
const SelfContainer = styled(Box)({
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
  overflow: "scroll",
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
      profileId: "",
      name: "",
      middle_name: "",
      last_name: "",
      email: "",
      img: "",
      bio: "",
      age: "",
      expertise: "",
      gender: "",
      interests: "",
      affiliations: "",
      shareBio: false,
      shareGender: false,
      shareAffiliations: false,
      shareAge: false,
      self: false,
      follow_reqs:[],
      followers:[],
      following:[],
      milestones: []
    }
  };

  componentDidMount() {
    var profileId = this.props.location.pathname.split('/')[2];
    this.setState({ profileId: profileId })
    axios.get(`${config.API_URL}${config.User_Path}${profileId}`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}`} })
        .then(res => {
          const user = res.data;
          console.log(user);
          console.log(user.followers);
          const prof = user.profile[0];
          this.setState({
            profileId: prof.id,
            name: prof.name,
            middle_name: prof.middle_name,
            last_name: prof.last_name,
            bio: prof.bio,
            img: prof.photo_url,
            age: prof.age, expertise: prof.expertise,
            gender: prof.gender,
            interests: prof.interests,
            affiliations: prof.affiliations,
            shareBio: prof.share_bio,
            shareGender: prof.share_gender,
            shareAffiliations: prof.share_affiliations,
            shareAge: prof.share_age,
            self: user.id === getUserId(),
            email: user.email,
            follow_reqs:user.follow_requests,
            followers:user.followers,
            following:user.following
          });
        });
    axios.get(`${config.API_URL}${config.OwnMilestoneUrl}`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
    .then(res => {
      this.setState({ milestones: res.data.result });
    });
  };

  handleSnackbarOpen = () => {
    this.SnackbarRef.current.turnOnSnackbar();
  };
  goToLogin = () => {
    this.props.history.push("/login");
  };
  goToEditProfilePage = () => {
    this.props.history.push("/edit-profile");
  };
  renderMilestones() {
    const { milestones } = this.state;
    return (
      <Box style={{ overflowY: "scroll", maxHeight: "500px", paddingTop: "10px", paddingBottom: "10px" }}>

        {milestones.length !== 0
          ?
          milestones.map((item) => {
            return (
              <Paper elevation={6}
                style={{
                  padding: "15px", maxHeight: "160px", width: "80%",
                  background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
                }}
                borderColor="primary" border={1}>
                <Typography variant="h6" color="primary"
                  style={{ cursor: "pointer", width: "50%", textAlign: "left" }}
                >{item.date}</Typography>
                <Typography variant="h6" color="primary"
                  style={{ cursor: "pointer", width: "50%", textAlign: "left", paddingBottom: "5px" }}
                >{item.project}</Typography>
                <hr />
                <Typography nowrap variant="body2" style={{ textAlign: "left", color: "black" }}>
                  {item.description.substr(0, 120)}
                  {/*May need more fine tuning as a future work.*/}
                </Typography>
              </Paper>
            )
          })
          :
          <Paper elevation={6}
            style={{
              padding: "15px", maxHeight: "160px", width: "80%",
              background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
            }}
            borderColor="primary" border={1}>
            <Typography variant="h6" color="textPrimary" style={{ "textAlign": 'center' }}>No Upcoming Milestones</Typography>
          </Paper>
        }


      </Box>)

  };
renderGraph(){
    return (
        <Paper elevation={6}  style={{padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
          <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}><b>{this.state.self?this.state.follow_reqs.length:0}</b> following request</Typography>
          <hr />
          <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}><b>{this.state.self?this.state.following.length:0}</b> followings</Typography>
          <hr />
          <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}><b>{this.state.self?this.state.followers.length:0}</b> followers</Typography>
        </Paper>);
  };

  render() {
    return (
      <SelfContainer>
        <UserNavbar
          logout={() => { this.props.history.push(config.Login_Path) }}
          pushProfile={() => { this.props.history.push("/profile/" + getUserId() )}}
          goHome={() => { this.props.history.push(config.Homepage_Path) }}
        />

        <Grid container direction="row" justify="center" alignItems="center" >
          <Grid container spacing={2} direction="row" justify="space-evenly" alignItems="baseline">

            <Grid item sm={3}>
              <Typography variant="h5" color="primary" style={titleStyleCenter}>Upcoming Milestones</Typography>
              {this.renderMilestones()}
            </Grid>
            <Grid container spacing={2} item sm={6}>
              <Grid item sm={12} >
                <Avatar src={this.state.img} style={{ width: "150px", height: '150px', margin: 'auto', marginTop: '10px' }} />
                <Paper elevation={6} style={{ padding: "10px", minHeight: '30px', maxWidth: "300px", margin: '15px auto 20px auto' }}>
                  <Typography>{this.state.name + " " + this.state.middle_name} <br />
                    {this.state.last_name.toUpperCase()}</Typography>
                </Paper>
              </Grid>

              <Grid item sm={6} >

                {this.showBio()
                  ? <>
                    <Typography variant="h5" color="primary" style={titleStyle}>Biography</Typography>
                    <Paper elevation={6} style={textStyle}>
                      <p>{this.state.bio}</p>
                    </Paper>
                  </>
                  :
                  <><Typography variant="h5" color="primary" style={titleStyle}>Biography</Typography>
                    <Paper elevation={6} style={textStyle}>
                      <p>{this.state.bio}</p>
                    </Paper></>
                }

                <Typography variant="h5" color="primary" style={titleStyle}>Contact Info</Typography>
                <Paper elevation={6} style={textStyle}>
                  <p>{"Email : " + this.state.email}</p>
                </Paper>
                {(this.showPersonalInfo() ?
                  <>
                    <Typography variant="h5" color="primary" style={titleStyle}>Personal Information</Typography>
                    <Paper elevation={6} style={textStyle}>
                      <p>{"Age : " + this.state.age} <br />
                        {(this.state.gender !== privateGender ? "Gender : " + this.state.gender : "")}</p>
                    </Paper>
                  </>
                  :
                  <></>
                )}
              </Grid>
              <Grid item sm={6} >
                <Typography variant="h5" color="primary" style={titleStyle}>Expertise</Typography>
                <Paper elevation={6} style={textStyle}>
                  <p>{this.state.expertise}</p>
                </Paper>
                <Typography variant="h5" color="primary" style={titleStyle}>Interests</Typography>
                <Paper elevation={6} style={textStyle}>
                  <p>{this.state.interests}</p>
                </Paper>
                {(this.showAffiliations() ?
                  <>
                    <Typography variant="h5" color="primary" style={titleStyle}>Affiliations</Typography>
                    <Paper elevation={6} style={textStyle}>
                      <p>{this.state.affiliations === "" ? "None" : this.state.affiliations}</p>
                    </Paper>
                  </>
                  :
                  <></>
                )}
              </Grid>
            </Grid>
            <Grid item sm={3}>
              {this.renderGraph()}
            </Grid>
            <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={this.goToEditProfilePage}>Edit Profile</Button>
          </Grid>
        </Grid>
        <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
      </SelfContainer>);

  }
  showPersonalInfo = () => {
    return this.showGender() && this.showAge();
  }

  showGender = () => {
    const { shareGender } = this.state;
    if (shareGender)
      return true;
    else
      return false;
  }
  showAge = () => {
    const { shareAge } = this.state;
    if (shareAge)
      return true;
    else
      return false;
  }
  showBio = () => {
    const { shareBio } = this.state;
    if (shareBio)
      return true;
    else
      return false;
  }
  showAffiliations = () => {
    const { shareAffiliations } = this.state;
    if (shareAffiliations)
      return true;
    else
      return false;
  }
}
