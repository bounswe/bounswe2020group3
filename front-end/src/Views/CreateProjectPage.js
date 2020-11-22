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
  titleEmpty: "Project title can not be empty!",
  projectCreationFail: "Project Creation Failed. Please try again.",
  projectCreationSuccess: "Project Created."
}
const projectTypes = {
  conference: "conference",
  journal: "journal",
  institution: "instutution"
}
const projectStates = {
  seekingForCollab: "seeking for collaborators",
  openForCollab: "open for collaborators",
  inProg: "in progress",
  done: "done"
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

export default class CreateProjectPage extends Component {
  constructor(props) {
    super(props);
    this.SnackbarRef = React.createRef();
    this.state = {
      success: null,
      message: "",
      messageType: "",
      projectTitle: "",
      projectType: null,
      projectDescription: "",
      projectRequirements: "",
      dueDate: format(new Date(), 'yyyy-MM-dd'),
      projectState: "",
      // collaborator: ,
      collaborators: [this.getSelfProfile()],
      date: null,
      isPublic: true

    }
  };
  handleDateChange = (date) => {
    this.setState({ dueDate: date });
  };
  handleTitleChange = (e) => {
    this.setState({ projectTitle: e.target.value });
  };
  handleTypeChange = (e) => {
    this.setState({ projectType: e.target.value });
  };

  handleSnackbarOpen = () => {
    this.SnackbarRef.current.turnOnSnackbar();
  };
  handlePrivacyChange = (e) => {
    this.setState({ isPublic: e.target.value });
  }
  handleDescriptionChange = (e) => {
    this.setState({ projectDescription: e.target.value });
  }
  handleRequirementChange = (e) => {
    this.setState({ projectRequirements: e.target.value });
  }
  // handleCollaboratorChange = (e) =>{
  //   this.setState({collaborator: e.target.value});
  // }
  handleProjectStateChange = (e) => {
    this.setState({ projectState: e.target.value });
  }
  getSelfProfile = () => {
    const id = getUserId()
    const url = `${config.API_URL}/api/users/${id}/`;
    return url;
  }

  submitProject = () => {
    const { projectTitle, projectDescription, projectRequirements, collaborators,
      isPublic, projectState, projectType, dueDate } = this.state;      /* members [] for now */
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
      due_date: dueDate
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
                helperText="Due Date"
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
            <div>
              <TextField
                style={width}
                type="text"
                error=""
                label="Project Requirements"
                onChange={this.handleRequirementChange}
                defaultValue=""
                placeholder="Please list the requirements for this project."
                helperText=""
                multiline
                rows={6}
                variant="filled" />
            </div>
            <div style={{ marginBottom: "10px" }}>
              {/* <TextField
                type="text"
                label="Project State"
                onChange={this.handleProjectStateChange}
                defaultValue=""
                placeholder=""
                multiline
                style={width}
                variant="filled" /> */}

              {/* 
                <InputLabel style={{ marginLeft: "12px" }} id="projectState">Project State</InputLabel>
                <Select
                  style={{ minWidth: "120px", marginLeft: "12px", marginTop: "10px" }}
                  value={projectState}
                  onChange={this.handleProjectStateChange}
                  labelId="projectState"
                >
                  <MenuItem value={projectStates.seekingForCollab}>Seeking For Collaborators</MenuItem>
                  <MenuItem value={projectStates.openForCollab}>Open for Collaboration</MenuItem>
                  <MenuItem value={projectStates.inProg}>In Progress</MenuItem>
                  <MenuItem value={projectStates.done}>Done</MenuItem>
                </Select> */}
              <FormControl>
                <InputLabel style={{ marginLeft: "12px" }} id="projectState">Project State</InputLabel>
                <Select
                  style={dropdownMenuStyle}
                  value={projectState}
                  onChange={this.handleProjectStateChange}
                  labelId="projectState"
                >
                  <MenuItem value={projectStates.seekingForCollab}>Seeking For Collaborators</MenuItem>
                  <MenuItem value={projectStates.openForCollab}>Open for Collaboration</MenuItem>
                  <MenuItem value={projectStates.inProg}>In Progress</MenuItem>
                  <MenuItem value={projectStates.done}>Done</MenuItem>
                </Select>
              </FormControl>


            </div>
            <div style={{ marginBottom: "10px" }}>
              <FormControl>
                <InputLabel style={{ marginLeft: "12px" }} id="isPublic">Accesibility</InputLabel>
                <Select
                  style={dropdownMenuStyle}
                  value={isPublic}
                  onChange={this.handlePrivacyChange}
                  labelId="isPublic"
                >
                  <MenuItem value={true}>Public</MenuItem>
                  <MenuItem value={false}>Private</MenuItem>
                </Select>
              </FormControl>
            </div>
            <div style={{ marginBottom: "10px" }}>
              <FormControl>
                <InputLabel style={{ marginLeft: "12px" }} id="projectType">Project Type</InputLabel>
                <Select
                  style={dropdownMenuStyle}
                  value={projectType}
                  onChange={this.handleTypeChange}
                  labelId="projectType"
                >
                  <MenuItem value={projectTypes.conference}>Conference</MenuItem>
                  <MenuItem value={projectTypes.institution}>Institution</MenuItem>
                  <MenuItem value={projectTypes.journal}>Journal</MenuItem>
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

