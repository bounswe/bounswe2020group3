import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { Button, styled } from '@material-ui/core';
import TextField from '@material-ui/core/TextField';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import UserNavbar from '../Components/TopBar/UserNavbar';
import DateComponent from "../Components/Date/DateComponent";
import AlertTypes from '../Common/AlertTypes.json';
import { getAccessToken, getUserId } from '../Components/Auth/Authenticate';
import { format } from "date-fns";

const Messages = {
  emptyDateError: "Please Choose a Date",
  eventCreationFail: "Setting Milestone Failed. Please try again.",
  eventCreationSuccess: "Milestone Set.",
  noProjectError: "Please go to a project, and click Set New Milestone.",
  emptyDescriptionError: "Please Write a Description for the Milestone"
}

const middleDiv = {
  margin: "auto",
  width: "50%",
  textAlign: "center",
  minWidth: "500px",
  verticalAlign: "middle",
  lineHeight: "1"

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
  backgroundColor: '#f7f7f5',
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

export default class IssueMilestonePage extends Component {
  constructor(props) {
    super(props);
    this.SnackbarRef = React.createRef();
    this.state = {
      success: null,
      message: "",
      messageType: "",
      milestoneDescription: "",
      projectId: "",
      date: format(new Date(), 'yyyy-MM-dd'),
      
    }
  };
  componentDidMount() { 
    var projectId = this.props.location.state.projectId;
    this.setState({projectId : projectId});
  }
  handleDateChange = (date) => {
    this.setState({ date: date });
  };
  handleDescriptionChange = (e) => {
    this.setState({ milestoneDescription: e.target.value });
  };

  handleSnackbarOpen = () => {
    this.SnackbarRef.current.turnOnSnackbar();
  };
  submitMilestone = () => {
    const { date, milestoneDescription, projectId } = this.state;  
    if(projectId === undefined){
      this.setState({ message: Messages.noProjectError, messageType: AlertTypes.Error }, () => {
        this.handleSnackbarOpen();
      });
      return; 
    }    
    if (date === "" || date === undefined) {
      this.setState({ message: Messages.emptyDateError, messageType: AlertTypes.Warning }, () => {
        this.handleSnackbarOpen();
      });
      return;
    }
    if(milestoneDescription === ""){
      this.setState({ message: Messages.emptyDescriptionError, messageType: AlertTypes.Warning }, () => {
        this.handleSnackbarOpen();
      });
      return;
    }
    const milestone = {
      project: parseInt(projectId),
      description: milestoneDescription,
      date: date
    };
    axios.post(`${config.API_URL}${config.Milestone_url}`, milestone, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        console.log(res.data)
        this.setState({ success: true, message: Messages.eventCreationSuccess, messageType: AlertTypes.Success }, () => {
          this.handleSnackbarOpen();
          var projectId = this.props.location.state.projectId;
          setTimeout(() => { this.props.history.push("/project/" + projectId); }, 5000);
        });

      }, (error) => {
        this.setState({ success: false, message: Messages.eventCreationFail, messageType: AlertTypes.Error });
        this.handleSnackbarOpen()
        console.log(error);
      })


  }


  render() {
    console.log(this.state);
    return (
      <Container>
        <UserNavbar 
          logout={() => { this.props.history.push(config.Login_Path) }}
          pushProfile={() => { this.props.history.push("/profile/" + getUserId()) }} 
          goHome={() => { this.props.history.push(config.Homepage_Path) }}
          history ={this.props.history}
          />
        <FormWrapper>
          <h1 style={{ color: "black" }}> Set a Milestone </h1>

          <div style={middleDiv}>
            <div>
              <TextField
                type="text"
                error=""
                label="Event Description"
                onChange={this.handleDescriptionChange}
                defaultValue=""
                placeholder="Please write a short description for the event."
                helperText=""
                rows={10}
                multiline
                style={width}
                variant="filled" />
            </div>
            <div>
              <DateComponent
                handleDateChange={this.handleDateChange}
                helperText="Milestone Date"
                style={width}
              />
            </div>      
            <Button color="primary" variant="contained" style={{ marginTop: "20px" }} onClick={this.submitMilestone}>Set Milestone</Button>  
          </div>
        </FormWrapper>
        <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
      </Container>);
  }
}

