import React, { Component } from "react";
import { styled } from '@material-ui/core';
import AlertTypes from '../Common/AlertTypes.json';
import Box from '@material-ui/core/Box';
import Button from '@material-ui/core/Button';
import FormControl from '@material-ui/core/FormControl';
import MenuItem from '@material-ui/core/MenuItem';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import { getAccessToken } from '../Components/Auth/Authenticate';
import axios from 'axios';
import config from '../config';
import InputLabel from '@material-ui/core/InputLabel';
import TextField from '@material-ui/core/TextField';
import Select from '@material-ui/core/Select';

const genderTypes = {
    male: "Male",
    female: "Female",
    non: "Do not want to share"
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
const middleDiv = {
    margin: "auto",
    width: "50%",
    textAlign: "center",
    minWidth: "500px",
    verticalAlign: "middle",
    lineHeight: "1"
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
    height: "100vh",
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
        success: false,
        messageType: "",
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
    handleAgeEdit = (e) => {
        this.setState({ age: e.target.value });
    }
    handleExpertiseEdit = (e) => {
        this.setState({ expertise: e.target.value });
    }
    handleGenderEdit = (e) => {
        this.setState({ gender: e.target.value });
    }
    handleInterestsEdit = (e) => {
        this.setState({ interests: e.target.value });
    }
    submitProfile = () => {
        const { name, middle_name, last_name, email, img, bio, age, expertise, gender, interests } = this.state; 
        const profile = {
          name: name,
          middle_name: middle_name,
          last_name: last_name,
          email: email,
          img: img,
          bio: bio,
          age: age,
          expertise: expertise,
          gender: gender,
          interests: interests
        };
        axios.post(`${config.API_URL}${config.Edit_Profile_Url}`, profile, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
          .then(res => {
            console.log(res.data)
            this.setState({ success: true, messageType: AlertTypes.Success }, () => {
              this.handleSnackbarOpen();
              setTimeout(() => { this.props.history.push(config.Profilepage_Path); }, 3000);
            });
    
          }, (error) => {
            this.setState({ success: false, messageType: AlertTypes.Error });
            this.handleSnackbarOpen()
            console.log(error);
          })
      }

    render() {
        const { gender } = this.state;
        return (
          <Container>
            <FormWrapper>
              <h1 style={{ color: "black" }}> Edit Profile </h1>
    
              <div style={middleDiv}>
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Name"
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
                    onChange={this.handleLastNameEdit}
                    defaultValue=""
                    helperText="Last Name"
                    style={width}
                    variant="filled" />
                </div>
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="email"
                    onChange={this.handleEmailEdit}
                    defaultValue=""
                    helperText="E-mail"
                    style={width}
                    variant="filled" />
                </div>
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Bio"
                    onChange={this.handleBioEdit}
                    defaultValue=""
                    helperText="Bio"
                    style={width}
                    variant="filled" />
                </div> 
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Age"
                    onChange={this.handleAgeEdit}
                    defaultValue=""
                    helperText="Age"
                    style={width}
                    variant="filled" />
                </div> 
                <div>
                  <TextField
                    type="text"
                    error=""
                    label="Interests"
                    onChange={this.handleInterestsEdit}
                    defaultValue=""
                    helperText="Interests"
                    style={width}
                    variant="filled" />
                </div>                    
                <div style={{ marginBottom: "10px" }}>
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
                <Button color="primary" variant="contained" style={{ marginTop: "20px" }} onClick={this.submitProfile}>Submit Changes</Button>  
              </div>
            </FormWrapper>
            <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpen} type={this.state.messageType} />
          </Container>);
    }

}


