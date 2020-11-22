import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { Button, styled } from '@material-ui/core';
import TextField from '@material-ui/core/TextField';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import UserNavbar from '../Components/TopBar/UserNavbar';
import DateComponent from "../Components/Date/DateComponent";
import InputLabel from '@material-ui/core/InputLabel';
import MenuItem from '@material-ui/core/MenuItem';
// import "../index.scss";
import Select from '@material-ui/core/Select';
import FormControl from '@material-ui/core/FormControl';
// import { theme } from "../Common/ColorTheme";
import AlertTypes from '../Common/AlertTypes.json';
import { getAccessToken } from '../Components/Auth/Authenticate';
import { format } from "date-fns";

const Messages = {
  emptyFieldError: "Please Fill All Areas!",
  titleEmpty: "Event title can not be empty!",
  eventCreationFail: "Event Creation Failed. Please try again.",
  eventCreationSuccess: "Event Created."
}
const eventTypes = {
  conference: "academic conference",
  journal: "journal submission",
  institution: "funded project"
}

const middleDiv = {
  margin: "auto",
  width: "50%",
  textAlign: "center",
  minWidth: "500px",
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
      // collaborator: ,
      deadlineDate: (new Date(), 'yyyy-MM-dd'),
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

  handleDescriptionChange = (e) => {
    this.setState({ eventDescription: e.target.value });
  }
  submitProject = () => {
    const { eventTitle, eventDescription, eventType, date, deadlineDate } = this.state;      /* members [] for now */
    if (eventTitle === "" || eventDescription === "" || eventType === "") {
      this.setState({ message: Messages.emptyFieldError, messageType: AlertTypes.Warning }, () => {
        this.handleSnackbarOpen();
      });

      return;
    }
    const event = {
      title: eventTitle,
      description: eventDescription,
      event_type: eventType,
      date: date,
      deadline: deadlineDate
    };
    axios.post(`${config.API_URL}${config.Event_Creation_Url}`, event, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        console.log(res.data)
        this.setState({ success: true, message: Messages.eventCreationSuccess, messageType: AlertTypes.Success }, () => {
          this.handleSnackbarOpen();
          setTimeout(() => { this.props.history.push(config.Homepage_Path); }, 3000);
        });

      }, (error) => {
        this.setState({ success: false, message: Messages.eventCreationFail, messageType: AlertTypes.Error });
        this.handleSnackbarOpen()
        console.log(error);
      })


  }

  render() {
    const { eventType } = this.state;
    return (
      <Container>
        <UserNavbar 
          logout={() => { this.props.history.push(config.Login_Path) }}
          pushProfile={() => { this.props.history.push("/profile") }} 
          goHome={() => { this.props.history.push(config.Homepage_Path) }}
          />
        <FormWrapper>
          <h1 style={{ color: "black" }}> Create an Event </h1>

          <div style={middleDiv}>
            <div>
              <TextField
                type="text"
                error=""
                label="Title"
                onChange={this.handleTitleChange}
                defaultValue=""
                helperText="Event Title"
                variant="filled"
                style={width}
              />
            </div>
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
                helperText="Date of the Event"
                style={width}
              />
            </div>
            <div>
              <DateComponent
                handleDateChange={this.handleDeadlineChange}
                helperText="Deadline for Submissions"
                style={width}
              />
            </div>
                        
            <div style={{ marginBottom: "10px" }}>
              <FormControl>
                <InputLabel style={{ marginLeft: "12px" }} id="projectType">Event Type</InputLabel>
                <Select
                  style={dropdownMenuStyle}
                  value={eventType}
                  onChange={this.handleTypeChange}
                  labelId="projectType"
                >
                  <MenuItem value={eventTypes.conference}>Academic Conference</MenuItem>
                  <MenuItem value={eventTypes.institution}>Funded Project</MenuItem>
                  <MenuItem value={eventTypes.journal}>Journal Submission</MenuItem>
                </Select>
              </FormControl>
            </div>
            <Button color="primary" variant="contained" style={{ marginTop: "20px" }} onClick={this.submitProject}>Create Event</Button>  
          </div>
        </FormWrapper>
        <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
      </Container>);
  }
}

