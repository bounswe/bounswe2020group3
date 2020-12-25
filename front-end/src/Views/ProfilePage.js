import React, { Component } from "react";
import { Button, Input, styled } from '@material-ui/core';
import Avatar from '@material-ui/core/Avatar';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import { getUserId, getAccessToken, getPhoto } from '../Components/Auth/Authenticate';
import axios from 'axios';
import config from '../config';
import UserNavbar from '../Components/TopBar/UserNavbar';
import Profilebar from '../Components/ProfileBar/Profilebar';

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
  height: "calc(100vh - 60px)",
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
const Container = styled(Box)({
  background: "#f9f9eb",
  border: 0,
  borderRadius: 3,
  boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
  color: 'white',
  paddingBottom: "60px",
  top: "0",
  bottom: "0",
  left: "0",
  right: "0",
  height:"calc(98vh - 60px)",
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
      profileId: "",
      name: "",
      middle_name: "",
      last_name: "",
      email: "",
      img: "",
      bio: "",
      birthday: "",
      expertise: "",
      gender: "",
      interests: "",
      affiliations: "",
      shareBio: false,
      shareGender: false,
      shareAffiliations: false,
      shareBirthday: false,
      self: false,
      selfName: "",
      selfLastName: "",
      follow_reqs:[],
      followers:[],
      following:[],
      milestones: [],
      projects: [],
      file : undefined,
      showUpload: false,
      loading: true // For eradicating glitches due to request delays
    }
  };

  componentDidMount() {

    var userId = this.props.location.pathname.split('/')[2];
    axios.get(`${config.API_URL}${config.User_Path}${userId}/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        this.setState({ email: res.data.email, self: res.data.id === parseInt(getUserId()), });
        const prof = res.data.profile[0];
        const user = res.data;
        let windowUserId = res.data.id;
        if (windowUserId === parseInt(getUserId()) || res.data.profile[0].is_public) {
          this.setState({
            isPublic: prof.is_public,
            profileId: prof.id,
            name: prof.name,
            middle_name: prof.middle_name,
            last_name: prof.last_name,
            bio: prof.bio,
            img: prof.photo_url,
            birthday: prof.birthday, 
            expertise: prof.expertise,
            gender: prof.gender,
            interests: prof.interests,
            affiliations: prof.affiliations,
            shareBio: prof.share_bio,
            shareGender: prof.share_gender,
            shareAffiliations: prof.share_affiliations,
            shareBirthday: prof.share_birthday,
            self: windowUserId === parseInt(getUserId()),
            follow_reqs:user.follow_requests,
            followers:user.followers,
            following:user.following,
            loading: false
          });
          if(windowUserId === parseInt(getUserId())){
          axios.get(`${config.API_URL}${config.OwnMilestoneUrl}`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
            .then(res => {
              this.setState({ milestones: res.data.result });
            });
            axios.get(`${config.API_URL}${config.Projectpage_url}?owner__id=${getUserId()}`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
              .then(res => {
                this.setState({ projects: res.data });
              });

          }
        }
        else if (prof.is_public === false) {
          this.setState({
            self: false,
            isPublic: prof.is_public,
            profileId: prof.id,
            name: prof.name,
            middle_name: prof.middle_name,
            last_name: prof.last_name,
            img: prof.photo_url,
            loading:false
          })
        }

      },(error) => {
        this.props.history.push("/"); // Forwards from unexisting profiles to homepage
      }
      
      );
    
      axios.get(`${config.API_URL}${config.User_Path}${getUserId()}/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        this.setState({ selfName: res.data.profile[0].name +" " +  res.data.profile[0].middle_name,
          selfLastName: res.data.profile[0].last_name
        });
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
  goToProjectCreation = () => {
    this.props.history.push(config.Create_Project_Path);
  };
  renderProjects() {
    const { projects } = this.state;
    return (
      <Box style={{ overflowY: "scroll", maxHeight: "500px", paddingTop: "10px", paddingBottom: "10px" }}>

        {projects.length !== 0
          ?
          projects.map((item) => {
            return (
              <Paper elevation={6}
                style={{
                  padding: "15px", maxHeight: "160px", width: "80%",
                  background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
                }}
                borderColor="primary" border={1}>
                <Typography variant="h6" color="primary"
                  style={{ cursor: "pointer", width: "50%", textAlign: "left" }}
                  onClick={()=>{    this.props.history.push("/project/" + item.id);}}
                >{item.name}</Typography>
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
            <Typography variant="h6" color="textPrimary" style={{ "textAlign": 'center' }}>No Projects Found</Typography>
          </Paper>
        }
      </Box>)
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
                  style={{ cursor: "pointer", width: "50%", textAlign: "left", display:"inline-block"}}
                  onClick={() => { this.props.history.push(`${config.Projectpage_Path}/${item.project}`) }}
                >{item.project_name}</Typography>
                <Typography variant="h6" color="primary"
                  style={{ cursor: "pointer", width: "50%", textAlign: "right", display:"inline-block" }}
                >{item.date}</Typography>
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
  renderMidRightColumn() {
    return (
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
    );
  }
  renderMidLeftColumn() {
    return (<Grid item sm={6} >

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
            <p>{"Birthday : " + this.state.birthday} <br />
              {(this.state.gender !== privateGender ? "Gender : " + this.state.gender : "")}</p>
          </Paper>
        </>
        :
        <></>
      )}
    </Grid>
    );
  }
  renderGraph() {
    return (
      <>{this.state.self ?
        <Button variant="outlined" color="primary" style={{width:"50", fontSize:'10px', marginBottom:"50px"}} onClick={() => { 
          this.deletePhoto( this.getUserPhoto(this.state.profileId))       
          window.location.reload(false);
           }}> Delete Photo </Button>
        :
        <></>
      }
        <Paper elevation={6} style={{ padding: "15px", width: "80%", background: "white", margin: "auto", marginBottom: "10px" }} borderColor="primary" border={1}>
          {/* <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}><b>{this.state.self?this.state.follow_reqs.length:0}</b> following request</Typography>
          <hr />
          <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}><b>{this.state.self?this.state.following.length:0}</b> followings</Typography>
          <hr />
          <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}><b>{this.state.self?this.state.followers.length:0}</b> followers</Typography> */}
        </Paper>
      </>);
  };
  handleProfilePictureChange = (e) => {
    this.setState({ file: e.target.files[0] });
  }
  handleShowUpload = (e) => {
    this.setState({ showUpload: true });
  }
  submitPhoto = () => {
    const { file } = this.state;
    console.log(file);
    if(file === undefined){
      return;
    }
    const data = new FormData();
    data.append("profile_picture", file);
    axios.put(`${config.API_URL}/api/profile_picture/${this.state.profileId}/`, data, 
    { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } } )
    .then(res => {
      window.location.reload(false);
    })
  }

  renderSelfProfile() {
    return (<SelfContainer>
      <UserNavbar
        logout={() => { this.props.history.push(config.Login_Path) }}
        pushProfile={() => { this.props.history.push("/profile/" + getUserId()) }}
        goHome={() => { this.props.history.push(config.Homepage_Path) }}
      />

      <Grid container direction="row" justify="center" alignItems="center" >
        <Grid container spacing={2} direction="row" justify="space-evenly" alignItems="baseline">

          <Grid item sm={3}>
            {this.state.self ?
              <>
                <Typography variant="h5" color="primary" style={titleStyleCenter}>Upcoming Milestones</Typography>
                {this.renderMilestones()}
                <Typography variant="h5" color="primary" style={titleStyleCenter}>Projects</Typography>
                {this.renderProjects()}
              </>
              :
              <></>
            }
          </Grid>

          <Grid container spacing={2} item sm={6}>
            <Grid item sm={12} >
              <Avatar src={this.getUserPhoto(this.state.profileId)} style={{ width: "150px", height: '150px', margin: 'auto', marginTop: '10px' }} />
              {this.state.showUpload ?
                <><Input type="file" onChange={this.handleProfilePictureChange}></Input>
                {this.state.file !== undefined ?
                  <Button color='primary'
                    type='outlined'
                    style={{ width: '40px', fontSize: "8px" }}
                    onClick={this.submitPhoto}
                  > Save Picture </Button>
                :
                <></>
                }
                </>
                :
                <Button color='primary'
                  type='outlined'
                  style={{ width: '40px', fontSize: "8px" }}
                  onClick={this.handleShowUpload}
                >Change Picture</Button>
              }
              <Paper elevation={6} style={{ padding: "10px", minHeight: '30px', maxWidth: "300px", margin: '15px auto 20px auto' }}>
                <Typography style={{textTransform:"capitalize "}}>{this.state.name + " " + this.state.middle_name} <br />
                  {this.state.last_name.toUpperCase()}</Typography>
              </Paper>
            </Grid>

            {(this.state.self || this.state.isPublic) ? this.renderMidLeftColumn() : <></>}
            {(this.state.self || this.state.isPublic) ? this.renderMidRightColumn() : <></>}

          </Grid>
          <Grid item sm={3}>
            {/*  SAĞDAKİ RELEVANT ŞEYLER BURAYA GELECEK  */}
            {this.renderGraph()}

          </Grid>
          {
            this.state.self ?
              <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={this.goToEditProfilePage}>Edit Profile</Button>
              :
              <></>
          }
        </Grid>
      </Grid>
      <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
    </SelfContainer>);
  }
  renderOtherProfile() {
    return (<Container>
      <UserNavbar
        logout={() => { this.props.history.push(config.Login_Path) }}
        pushProfile={() => {
          this.props.history.push("/profile/" + getUserId());
          window.location.reload(false);
        }}
        goHome={() => { this.props.history.push(config.Homepage_Path) }}
      />
      <Box>
        {!this.state.self && !this.state.loading ?  // So that re-render doesn't cause any glitch-like graphics.
          <Profilebar
            name={this.state.selfName}
            lastName={this.state.selfLastName}
            photoUrl={getPhoto()}
            goToProjectCreation={this.goToProjectCreation}
            goToProfile={() => {
              this.props.history.push("/profile/" + getUserId()); 
              window.location.reload(false);
            }}
          />
          :
          <></>
        }
        <Grid container direction="row" justify="center" alignItems="center" >
          <Grid container spacing={2} direction="row" justify="space-evenly" alignItems="baseline">

            <Grid item sm={3}>
{/* Burasi bos kalacak */}
            </Grid>

            <Grid container spacing={2} item sm={6}>
              <Grid item sm={12} >
                <Avatar src={this.getUserPhoto(this.state.profileId)} style={{ width: "150px", height: '150px', margin: 'auto', marginTop: '10px' }} />
                <Paper elevation={6} style={{ padding: "10px", minHeight: '30px', maxWidth: "300px", margin: '15px auto 20px auto' }}>
                  <Typography style={{textTransform:"capitalize"}}>{this.state.name + " " + this.state.middle_name} <br />
                    {this.state.last_name.toUpperCase()}</Typography>
                </Paper>
              </Grid>

              {(this.state.self || this.state.isPublic) ? this.renderMidLeftColumn() : <></>}
              {(this.state.self || this.state.isPublic) ? this.renderMidRightColumn() : <></>}

            </Grid>
            <Grid item sm={3}>
{ /* Buraya bir seyler gelecek - recommendation vb. */ }
            </Grid>
            {
              this.state.isPublic ?
              <></>
              :
                <Typography variant="h5" color="error"> This Profile is Private </Typography>
            }
          </Grid>
        </Grid>
        <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
      </Box>
    </Container>);
  }
  render() {
    if (this.state.self)
      return (<>{this.renderSelfProfile()}</>);
    else {
      return (<>{this.renderOtherProfile()}</>)
    }

  }

  getUserPhoto = (profileId) =>{
    return `${config.API_URL}/api/profile_picture/${profileId}/`;
  }
  
  deletePhoto = (url) =>{
    axios.delete(url, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } });
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
    const { shareBirthday } = this.state;
    if (shareBirthday)
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
