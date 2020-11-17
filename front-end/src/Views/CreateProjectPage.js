import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { Button, styled } from '@material-ui/core';
import TextField from '@material-ui/core/TextField';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import PrimarySearchAppBar from '../Components/TopBar/PrimarySearchAppBar';
import Grid from '@material-ui/core/Grid';
import DateComponent from "../Components/Date/DateComponent";
import InputLabel from '@material-ui/core/InputLabel';
import MenuItem from '@material-ui/core/MenuItem';
import "../index.scss";
import Select from '@material-ui/core/Select';
import FormControl from '@material-ui/core/FormControl';
import { Autocomplete } from "@material-ui/lab";

const errorMessages = {
  emptyFieldError: "Please Fill All Areas!"
}
const projectTypes = {
  conference: "conference",
  journal: "journal",
  institution : "institution"
}

const leftDiv = {
  // float: 'left',
  margin: "auto",
  width: "50%",
  textAlign: "center",
  minWidth:"500px",
  display: "inline-block",
  // height: "500px"
  
}
const rightDiv = {
  // float: 'right',
  margin: "auto",
  width: "50%",
  textAlign: "center",
  minWidth:"500px",
  display: "inline-block",
  // height: "500px"

}
const width = {
  width: "60%",  
  minWidth: "450px"

}
const Container = styled(Box)({
  background: '#fafafa',
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
      projectTags: "",
      dueDate: "",
      privateProject: false,
      projectState: "",
      collaborators: "",
      date: null,
      isPublic: null

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
  handleTagChange = (e) => {
    this.setState({ projectTags: e.target.value });
  }
  handleCollaboratorChange = (e) =>{
    this.setState({collaborators: e.target.value});
  }
  handleProjectStateChange = (e) =>{
    this.setState({projectState: e.target.value});
  }

  render() {
    const { isPublic, projectType } = this.state;
    console.log(this.state)
    return (
      <Container>
        <PrimarySearchAppBar />
        <div style={{ margin:"10px auto auto auto", width:"60%", backgroundColor:"beige", padding:"15px"}}>
          <h1 style={{color:"black"}}> Create a Project </h1>
        
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
                label="Project Tags"
                onChange={this.handleTagChange}
                defaultValue=""
                placeholder="Please list relevant tags for this project."
                helperText=""
                multiline
                rows={6}
                variant="filled" />
            </div>
            <div>
              <TextField
                type="text"
                label="Project State"
                onChange={this.handleProjectStateChange}
                defaultValue=""
                placeholder=""
                multiline
                style={width}
                variant="filled" />
            </div>
            <div>
              <FormControl>
                <InputLabel style={{ marginLeft: "12px" }} id="demo-simple-select-helper-label">Accesibility</InputLabel>
                <Select
                  style={{ minWidth: "120px", marginLeft: "12px", marginTop: "10px" }}
                  value={isPublic}
                  onChange={this.handlePrivacyChange}
                  labelId="demo-simple-select-helper-label"
                >
                  <MenuItem value={true}>Public</MenuItem>
                  <MenuItem value={false}>Private</MenuItem>
                </Select>
              </FormControl>
              <FormControl>
                <InputLabel style={{ marginLeft: "12px" }} id="demo-simple-select-helper-label2">Project Type</InputLabel>
                <Select
                  style={{ minWidth: "150px", marginLeft: "12px", marginTop: "10px" }}
                  value={projectType}
                  onChange={this.handleTypeChange}
                  labelId="demo-simple-select-helper-label2"
                >
                  <MenuItem value={projectTypes.conference}>Conference</MenuItem>
                  <MenuItem value={projectTypes.institution}>Institution</MenuItem>
                  <MenuItem value={projectTypes.journal}>Journal</MenuItem>
                </Select>
              </FormControl>
            </div>

          </div>
          <TextField
                type="text"
                label="Collaborators"
                onChange={this.handleCollaboratorChange}
                defaultValue=""
                placeholder="Collaborators"
                multiline
                style={{width:"90%"}}
                variant="filled" />
        </div>
        <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
      </Container>);
  }

}

