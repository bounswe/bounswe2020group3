import React, { Component } from "react";
import { styled } from '@material-ui/core';
import AlertTypes from '../Common/AlertTypes.json';
import Box from '@material-ui/core/Box';
import Grid from '@material-ui/core/Grid';
import Button from '@material-ui/core/Button';
import FormControl from '@material-ui/core/FormControl';
import MenuItem from '@material-ui/core/MenuItem';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import { getAccessToken, getUserId } from '../Components/Auth/Authenticate';
import axios from 'axios';
import config from '../config';
import InputLabel from '@material-ui/core/InputLabel';
import TextField from '@material-ui/core/TextField';
import Select from '@material-ui/core/Select';
import DateComponent from "../Components/Date/DateComponent";
import UserNavbar from '../Components/TopBar/UserNavbar';

const genderTypes = {
    male: "male",
    female: "female",
    non: "do not want to share"
}
const dropdownMenuStyle = {
    minWidth: "150px",
    marginLeft: "12px",
    marginTop: "10px"
}
const width = {
    width: "60%",
    minWidth: "450px"
}
const FormWrapper = styled(Box)({
    backgroundColor: "#E0E0E0",
    border: 0,
    borderRadius: 3,
    boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
    width: "60%",
    padding: "15px",
    margin: "10px auto auto auto",
    '& .MuiTextField-root': {
  
      margin: "10px",
      width: "30%",
      minWidth: "250px"
    }
});
const Container = styled(Box)({
    background: "white",
    border: 0,
    borderRadius: 3,
    boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
    color: 'white',
    height: "98vh",
    width: "100%",
  
    '& .MuiTextField-root': {
  
      margin: "10px",
      width: "30%",
      minWidth: "250px"
    }
});
export default class EditProfilePage extends Component {
    constructor(props) {
      super(props);
      this.SnackbarRef = React.createRef();
      this.state = {
        profileId:-1,
        success: false,
        messageType: "",
        name:"",
        middle_name:"",
        last_name:"",
        email:"",
        img:"",
        bio:"",
        age:"",
        birthday: new Date(),
        expertise:"",
        gender:"",
        interests:"",
        shareBirthday: false,
        shareAffiliations: false,
        shareGender : false,
        shareBio: false,
        isPublic: false
 

      }
    };
    componentDidMount() {
      axios.get(`${config.API_URL}${config.User_Path}${getUserId()}/`,
      { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        let prof = res.data.profile[0];
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
        });
        // this.getProfile(profId);
      }
      , (error) => {
        this.setState({ success: false, message: "Error when fetching profile data.", messageType: AlertTypes.Error });
        this.handleSnackbarOpen()
        console.log(error);
      }); 
    }

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    };
    handleNameEdit = (e) => {
        this.setState({ name: e.target.value });
    };
    handleMidNameEdit = (e) => {
        this.setState({ middle_name: e.target.value });
    };
    handleLastNameEdit = (e) => {
        this.setState({ last_name: e.target.value });
    };
    handleEmailEdit = (e) => {
        this.setState({ email: e.target.value });
    }
    handleImgEdit = (e) => {
        this.setState({ img: e.target.value });
    }
    handleBioEdit = (e) => {
        this.setState({ bio: e.target.value });
    }
    handleDateChange = (date) => {
      this.setState({ birthday: date });
    };
    handleExpertiseEdit = (e) => {
        this.setState({ expertise: e.target.value });
    }
    handleGenderEdit = (e) => {
        this.setState({ gender: e.target.value });
    }
    handleShareBio = (e) => {
      this.setState({ shareBio: e.target.value });
  }
  handleShareBirthday = (e) => {
    this.setState({ shareBirthday: e.target.value });
  }
  handleShareAffiliations = (e) => {
    this.setState({ shareAffiliations: e.target.value });
  }
  handleShareGender = (e) => {
    this.setState({ shareGender: e.target.value });
  }
  handleProfilePrivacy = (e) => {
    this.setState({ isPublic: e.target.value });
  }
    handleInterestsEdit = (e) => {
        this.setState({ interests: e.target.value });
    }
    submitProfile = () => {
        const { name, middle_name, last_name, bio, birthday, expertise, gender, interests, isPublic, shareBio, shareBirthday, shareAffiliations,shareGender } = this.state; 
        const profile = {
          name: name,
          middle_name: middle_name,
          last_name: last_name,
          bio: bio,
          birthday: birthday,
          expertise: expertise,
          gender: gender,
          interests: interests,
          is_public: isPublic,
          share_birthday: shareBirthday,
          share_gender : shareGender,
          share_affiliations: shareAffiliations,
          share_bio : shareBio
        };
        axios.put(`${config.API_URL}${config.Edit_Profile_Url}${this.state.profileId}/`, profile, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
          .then(res => {
            console.log(res.data)
            this.setState({ success: true, messageType: AlertTypes.Success }, () => {
              this.handleSnackbarOpen();
              setTimeout(() => { this.props.history.push(config.Profille_Page_Path + `/${getUserId()}`); }, 3000);
            });
    
          }, (error) => {
            this.setState({ success: false, messageType: AlertTypes.Error });
            this.handleSnackbarOpen()
            console.log(error);
          })
      }

    render() {
        const { gender } = this.state;
        console.log(this.state.birthday)
        return (
          <Container>
            <UserNavbar
              logout={() => { this.props.history.push(config.Login_Path) }}
              pushProfile={() => { this.props.history.push("/profile/" + getUserId()) }}
              goHome={() => { this.props.history.push(config.Homepage_Path) }}
            />
            <FormWrapper>
              <h1 style={{ color: "black" }}> Edit Profile </h1>
              <Grid container direction="row" justify="center" alignItems="center">
                <Grid sm={6} >
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Name"
                    value={this.state.name}
                    onChange={this.handleNameEdit}
                    defaultValue=""
                    helperText="Name"
                    variant="filled"
                    style={width}
                  />
                </div>
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Midlle Name"
                    value={this.state.middle_name}
                    onChange={this.handleMidNameEdit}
                    defaultValue=""
                    helperText="Middle Name"
                    style={width}
                    variant="filled" />
                </div>          
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Last Name"
                    value={this.state.last_name}
                    onChange={this.handleLastNameEdit}
                    defaultValue=""
                    helperText="Last Name"
                    style={width}
                    variant="filled" />
                </div>
                {/* <div>
                  <TextField
                    type="text"
                    error=""
                    label="email"

                    onChange={this.handleEmailEdit}
                    defaultValue=""
                    helperText="E-mail"
                    style={width}
                    variant="filled" />
                </div> */}
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Bio"
                    value={this.state.bio}
                    onChange={this.handleBioEdit}
                    defaultValue=""
                    helperText="Bio"
                    style={width}
                    variant="filled" />
                </div> 
                </Grid>

                <Grid sm={6} >
                <div>
                  <DateComponent
                    value={this.state.birthday}
                    dateValue={this.state.birthday}
                    handleDateChange={this.handleDateChange}
                    helperText="Birthday"
                    past={true}
                    style={width}
                  />
                </div>
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Interests"
                    value={this.state.interests}
                    onChange={this.handleInterestsEdit}
                    defaultValue=""
                    helperText="Interests"
                    style={width}
                    variant="filled" />
                </div>
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Expertise"
                    value={this.state.expertise}
                    onChange={this.handleExpertiseEdit}
                    defaultValue=""
                    helperText="Expertise"
                    style={width}
                    variant="filled" />
                </div>      
                              
                <div style={{ marginBottom: "10px" }}>
                <FormControl>
                    <InputLabel style={{ marginLeft: "12px" }} id="profilePriv">Profile Privacy</InputLabel>
                    <Select
                      style={dropdownMenuStyle}
                      value={this.state.isPublic}
                      onChange={this.handleProfilePrivacy}
                      labelId="profilePriv"
                    >
                      <MenuItem value={true}>Public</MenuItem>
                      <MenuItem value={false}>Private</MenuItem>
                    </Select>
                  </FormControl>
                  <FormControl>
                    <InputLabel style={{ marginLeft: "12px" }} id="gender">Gender</InputLabel>
                    <Select
                      style={dropdownMenuStyle}
                      value={gender}
                      onChange={this.handleGenderEdit}
                      labelId="gender"
                    >
                      <MenuItem value={genderTypes.male}>Male</MenuItem>
                      <MenuItem value={genderTypes.female}>Female</MenuItem>
                      <MenuItem value={genderTypes.non}>Do not want to share</MenuItem>
                    </Select>
                  </FormControl>
                </div>
                <div>
                <FormControl>
                    <InputLabel style={{ marginLeft: "12px" }} id="sharebio">Share Bio</InputLabel>
                    <Select
                      style={dropdownMenuStyle}
                      value={this.state.shareBio}
                      onChange={this.handleShareBio}
                      labelId="sharebio"
                    >
                      <MenuItem value={true}>Yes</MenuItem>
                      <MenuItem value={false}>No</MenuItem>
                    </Select>
                  </FormControl>
                  <FormControl>
                    <InputLabel style={{ marginLeft: "12px" }} id="shareBday">Share Birthday</InputLabel>
                    <Select
                      style={dropdownMenuStyle}
                      value={this.state.shareBirthday}
                      onChange={this.handleShareBirthday}
                      labelId="shareBday"
                    >
                      <MenuItem value={true}>Yes</MenuItem>
                      <MenuItem value={false}>No</MenuItem>
                    </Select>
                  </FormControl>
                </div>
                <div>
                <FormControl>
                    <InputLabel style={{ marginLeft: "12px" }} id="genderReveal">Share Gender</InputLabel>
                    <Select
                      style={dropdownMenuStyle}
                      value={this.state.shareGender}
                      onChange={this.handleShareGender}
                      labelId="genderReveal"
                    >
                      <MenuItem value={true}>Yes</MenuItem>
                      <MenuItem value={false}>No</MenuItem>
                    </Select>
                  </FormControl>
                  <FormControl>
                    <InputLabel style={{ marginLeft: "12px" }} id="shareAff">Share Affiliations</InputLabel>
                    <Select
                      style={dropdownMenuStyle}
                      value={this.state.shareAffiliations}
                      onChange={this.handleShareAffiliations}
                      labelId="shareAff"
                    >
                      <MenuItem value={true}>Yes</MenuItem>
                      <MenuItem value={false}>No</MenuItem>
                    </Select>
                  </FormControl>
                </div>
                </Grid>
                
                {/* <div>
                  <TextField
                    type="text"
                    error=""
                    label="Age"
                    value={this.state.birthday}
                    onChange={this.handleAgeEdit}
                    defaultValue=""
                    helperText="Age"
                    style={width}
                    variant="filled" />
                </div>  */}
                
                <Button color="primary" variant="contained" style={{ marginTop: "20px" }} onClick={this.submitProfile}>Submit Changes</Button>  
              </Grid>
            </FormWrapper>
            <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpen} type={this.state.messageType} />
          </Container>);
    }

}


