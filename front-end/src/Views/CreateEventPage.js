import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { Button, styled } from '@material-ui/core';
import TextField from '@material-ui/core/TextField';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import PrimarySearchAppBar from '../Components/TopBar/PrimarySearchAppBar';
import DateComponent from "../Components/Date/DateComponent";
import InputLabel from '@material-ui/core/InputLabel';
import MenuItem from '@material-ui/core/MenuItem';
import "../index.scss";
import Select from '@material-ui/core/Select';
import FormControl from '@material-ui/core/FormControl';
import { theme } from "../Common/ColorTheme";
import AlertTypes from '../Common/AlertTypes.json';
import { getAccessToken, getUserId } from '../Components/Auth/Authenticate';
import { format } from "date-fns";

const Messages = {
  emptyFieldError: "Please Fill All Areas!",
  titleEmpty: "Event title can not be empty!",
  EventCreationFail: "Event Creation Failed. Please try again.",
  EventCreationSuccess: "Event Created."
}
const eventTypes = {
  conference: "conference",
  journal: "journal",
  institution: "instutution"
}

const leftDiv = {
  // float: 'left',
  margin: "auto",
  width: "50%",
  textAlign: "center",
  minWidth: "500px",
  display: "inline-block",
  height: "420px",
  verticalAlign: "middle",
  lineHeight: "1"

}
const rightDiv = {
  // float: 'right',
  margin: "auto",
  width: "50%",
  textAlign: "center",
  minWidth: "500px",
  display: "inline-block",
  height: "420px",
  verticalAlign: "middle",
  lineHeight: "1"

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
  backgroundColor: theme.palette.secondary.light,
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

export default class CreateEventPage extends Component {
  constructor(props) {
    super(props);
    this.SnackbarRef = React.createRef();
    this.state = {
      success: null,
      message: "",
      messageType: "",
      eventTitle: "",
      eventType: null,
      eventDescription: "",
      date: format(new Date(), 'yyyy-MM-dd'),
      eventState: "",
      // collaborator: ,
      deadlineDate: null,
      isPublic: true

    }
  };
  handleDateChange = (date) => {
    this.setState({ date: date });
  };
  handleDeadlineChange = (date) => {
    this.setState({ deadlineDate: date });
  };
  handleTitleChange = (e) => {
    this.setState({ eventTitle: e.target.value });
  };
  handleTypeChange = (e) => {
    this.setState({ eventType: e.target.value });
  };

  handleSnackbarOpen = () => {
    this.SnackbarRef.current.turnOnSnackbar();
  };
  handlePrivacyChange = (e) => {
    this.setState({ isPublic: e.target.value });
  }
  handleDescriptionChange = (e) => {
    this.setState({ eventDescription: e.target.value });
  }
  // handleCollaboratorChange = (e) =>{
  //   this.setState({collaborator: e.target.value});
  // }
  handleProjectStateChange = (e) => {
    this.setState({ eventState: e.target.value });
  }
//   getSelfProfile = () => {
//     const id = getUserId()
//     const url = `${config.API_URL}/api/users/${id}/`;
//     return url;
//   }

  submitProject = () => {
    const { projectTitle, projectDescription, projectRequirements, collaborators,
      isPublic, projectState, projectType, date } = this.state;      /* members [] for now */
    if (projectTitle === "" || projectDescription === "" || projectRequirements === "" || collaborators === []
      || projectState === "" || projectType === "") {
      this.setState({ message: Messages.emptyFieldError, messageType: AlertTypes.Warning }, () => {
        this.handleSnackbarOpen();
      });
      return;
    }
    const project = {
      name: projectTitle,
      description: projectDescription,
      requirements: projectRequirements,
      members: collaborators,
      is_public: isPublic,
      state: projectState,
      project_type: projectType,
      due_date: date
      ///ADD EVENTS HERE
    };
    axios.post(`${config.API_URL}${config.Create_Project_Url}`, project, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        console.log(res.data)
        this.setState({ success: true, message: Messages.projectCreationSuccess, messageType: AlertTypes.Success }, () => {
          this.handleSnackbarOpen();
          setTimeout(() => { this.props.history.push(config.Homepage_Path); }, 1500);
        });

      }, (error) => {
        this.setState({ success: false, message: Messages.projectCreationFail, messageType: AlertTypes.Error });
        this.handleSnackbarOpen()
        console.log(error);
      })


  }

  render() {
    const { isPublic, projectType, projectState } = this.state;
    return (
      <Container>
        <PrimarySearchAppBar />
        <FormWrapper>
          <h1 style={{ color: "black" }}> Create a Project </h1>

          <div style={leftDiv}>
            <div>
              <TextField
                type="text"
                error=""
                label="Title"
                onChange={this.handleTitleChange}
                defaultValue=""
                helperText="Title of the Project"
                variant="filled"
                style={width}
              />
            </div>
            <div>
              <TextField
                type="text"
                error=""
                label="Project Description"
                onChange={this.handleDescriptionChange}
                defaultValue=""
                placeholder="Please describe the project."
                helperText=""
                rows={10}
                multiline
                style={width}
                variant="filled" />
            </div>
            <div>
              <DateComponent
                handleDateChange={this.handleDateChange}
                helperText="Date of the Event"
                style={width}
              />
            </div>

          </div>
          <div style={rightDiv}>
            <div>
              {/* <TextField
                type="text"
                error=""
                label="Type"
                onChange={this.handleTypeChange}
                defaultValue=""
                helperText="Type of the Project"
                variant="filled"
                style={width}
              /> */}

            </div>
            <div style={{ marginBottom: "10px" }}>
              <FormControl>
                <InputLabel style={{ marginLeft: "12px" }} id="projectType">Project Type</InputLabel>
                <Select
                  style={dropdownMenuStyle}
                  value={eventType}
                  onChange={this.handleTypeChange}
                  labelId="projectType"
                >
                  <MenuItem value={eventTypes.conference}>Conference</MenuItem>
                  <MenuItem value={eventTypes.institution}>Institution</MenuItem>
                  <MenuItem value={eventTypes.journal}>Journal</MenuItem>
                </Select>
              </FormControl>
            </div>
            <Button color="primary" variant="contained" style={{ marginTop: "20px" }} onClick={this.submitProject}>Create Project</Button>

          </div>
          {/* <TextField
                type="text"
                label="Collaborators"
                onChange={this.handleCollaboratorChange}
                defaultValue=""
                placeholder="Collaborators"
                multiline
                style={{width:"90%"}}
                variant="filled" /> */}
        </FormWrapper>
        <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
      </Container>);
  }
}

