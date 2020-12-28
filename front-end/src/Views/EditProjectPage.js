import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { Button, styled } from '@material-ui/core';
import TextField from '@material-ui/core/TextField';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import DateComponent from "../Components/Date/DateComponent";
import InputLabel from '@material-ui/core/InputLabel';
import MenuItem from '@material-ui/core/MenuItem';
import "../index.scss";
import Select from '@material-ui/core/Select';
import FormControl from '@material-ui/core/FormControl';
import AlertTypes from '../Common/AlertTypes.json';
import { getAccessToken, getUserId } from '../Components/Auth/Authenticate';
import { format } from "date-fns";
import UserNavbar from "../Components/TopBar/UserNavbar";


const Messages = {
  emptyFieldError: "Please Fill All Areas!",
  titleEmpty: "Project title can not be empty!",
  projectEditFail: "Project Edit Failed. Please try again.",
  projectEditSuccess: "Project Succussfully Edited."
}
const projectTypes = {
  conference: "conference",
  journal: "journal",
  institution: "instutution"
}
const eventTypes = {
  conference: "academic conference",
  journal: "journal submission",
  institution: "funded project"
}
const projectStates = {
  seekingForCollab: "seeking for collaborators",
  openForCollab: "open for collaborators",
  inProg: "in progress",
  done: "done",
  draft: "draft",
  inviting: "inviting",
  collaborators: "collaborators", 
  submitted_to_event:"submitted to event", 
  published: "published",
  cancelled: "cancelled", 
  reopened: "reopened"
}

const leftDiv = {
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

export default class ProjectPage extends Component {
  constructor(props) {
    super(props);
    this.SnackbarRef = React.createRef();
    this.state = {
      success: null,
      message: "",
      messageType: "",
      projectTitle: "",
      projectType: "",
      projectDescription: "",
      projectRequirements: "",
      dueDate: format(new Date(), 'yyyy-MM-dd'),
      projectState: "",
      // collaborator: "",
      collaborators: [this.getSelfProfile()],  //Other members to be added later TODO
      isPublic: true,
      events: [],
      event : "",
      tags: [{
        name: "",
        color: "",
      }]
    }
  };

  componentDidMount() {
    var project_id =this.props.location.pathname.split('/')[2];
    axios.get(`${config.API_URL}${config.Projectpage_url}${project_id}`, { headers:{'Content-Type':'Application/json'}})
      .then(res => {
        const prof = res.data;
        //const temp_members = prof.members;
        this.setState({projectTitle:prof.name, projectDescription:prof.description, projectRequirements:prof.requirements,  projectState:prof.state, age:prof.age, projectType:prof.project_type, dueDate:prof.due_date, tags:prof.tags});
        if(prof.event == null){
          this.setState({events:[]});
        }else{
          this.setState({events:[prof.event]});
        }
        this.setState({tags:[{name:"alpha",color:"#F8C471"}]});

      });
    axios.get(`${config.API_URL}/api/users/${getUserId()}/`, { headers:{'Content-Type':'Application/json', 'Authorization': `Token ${getAccessToken()}`}})
      .then(res => {
        let name = res.data.profile[0].name;
        let mname = res.data.profile[0].middle_name;
        let lastname = res.data.profile[0].last_name;
        name = name + " " + mname;
        let photoUrl = (res.data.profile[0].photo_url)
        this.setState({ username:name , userlastname: lastname, photoUrl:photoUrl });
      });
  };


  handleDateChange = (date) => {
    this.setState({ dueDate: date });
  };
  handleTitleChange = (e) => {
    this.setState({ projectTitle: e.target.value });
  };
  handleTypeChange = (e) => {
    this.setState({ projectType: e.target.value, event: "" },() => {
      this.fetchRelatedEvents();
    });
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
  handleEventChange = (e) => {
    this.setState({ event: e.target.value });
  }
  getSelfProfile = () => {
    const id = getUserId()
    const url = `${config.API_URL}/api/users/${id}/`;
    return url;
  }
  fetchRelatedEvents = (callback) => {
    const { projectType } = this.state
    let type = ""
    if(projectType === projectTypes.conference){ type = eventTypes.conference }
    else if (projectType === projectTypes.institution){ type = eventTypes.institution }
    else if (projectType === projectTypes.journal){ type = eventTypes.journal }

    if(type === ""){
      return;
    }
    const event_filter = { event_type : type };
    axios.get(`${config.API_URL}${config.Event_Creation_Url}?event_type=${event_filter.event_type}`, event_filter, 
      { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        console.log(res.data);
        const events = res.data;
        this.setState({events : events}, () =>{
          if(callback) callback();
        } );

      })
  }
  renderEvents = () => {
    const { projectType, events, event } = this.state
    let errorMsg = ""
    if(projectType === "")
      errorMsg = "Please provide a project type.";
    else
      errorMsg = "No such events at the moment"
    return (
      <FormControl>
        <InputLabel style={{ marginLeft: "12px" }} id="events">Events</InputLabel>
        <Select
          style={dropdownMenuStyle}
          value={event}
          onChange={this.handleEventChange}
          labelId="events"
        >
          {events.length !== 0
            ?
            Object.keys(events).map((id, i) => (
              <MenuItem value={`${config.API_URL}${config.Event_Creation_Url}${id}/`}>{events[i]["title"]}</MenuItem>
            ))
            :
            <MenuItem disabled value="">{errorMsg}</MenuItem>
          }
        </Select>
      </FormControl>
    )
  }

  editProject = () => {
    const { projectTitle, projectDescription, projectRequirements, collaborators,
      isPublic, projectState, projectType, dueDate, event } = this.state;      /* members [] for now */
    
    if (projectTitle === "" || projectDescription === "" || projectRequirements === "" || collaborators === []
      ) {
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
      stat: projectState,
      type: projectType,
      due_date: dueDate,
      events: event
    };
    if(projectType !== "" )
      project.project_type = projectType;
    if(event !== "")
      project.events = [event]
    if (projectState !== "")
      project.state = projectState

    var project_id =this.props.location.pathname.split('/')[2];
    console.log("project")
    console.log(project)
    axios.patch(`${config.API_URL}${config.Projectpage_url}${project_id}/`, project, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        console.log("project")
        console.log(res.data)
        this.setState({ success: true, message: Messages.projectEditSuccess, messageType: AlertTypes.Success }, () => {
          this.handleSnackbarOpen();
          setTimeout(() => { this.props.history.push("/project/" + project_id); }, 5000);
        });

      }, (error) => {
        this.setState({ success: false, message: Messages.projectEditFail, messageType: AlertTypes.Error });
        this.handleSnackbarOpen()
        console.log(error);
      })


  }

  render() {
    const { isPublic, projectType, projectState } = this.state;
    console.log(this.state)
    return (
      <Container>
        <UserNavbar
          logout={() => { this.props.history.push(config.Login_Path) }}
          pushProfile={() => { this.props.history.push("/profile") }}
          goHome={() => { this.props.history.push(config.Homepage_Path) }}
        />
        <FormWrapper>
          <h1 style={{ color: "black" }}> Edit Project </h1>
          <div style={leftDiv}>
            <div>
              <TextField
                type="text"
                error=""
                input value={this.state.projectTitle}
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
                input value={this.state.projectDescription}
                onChange={this.handleDescriptionChange}
                defaultValue=""
                placeholder="Please describe the project."
                helperText="Project Description"
                rows={10}
                multiline
                style={width}
                variant="filled" />
            </div>
            <div>
              <DateComponent
                value={this.state.dueDate}
                handleDateChange={this.handleDateChange}
                helperText="Due Date"
                style={width}
              />
            </div>

          </div>
          <div style={rightDiv}>
            <div>
              <TextField
                style={width}
                type="text"
                error=""
                input value={this.state.projectRequirements}
                onChange={this.handleRequirementChange}
                defaultValue=""
                placeholder="Please list the requirements for this project."
                helperText="Project Requirements"
                multiline
                rows={6}
                variant="filled" />
            </div>
            <div style={{ marginBottom: "10px" }}>
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
                  <MenuItem value={projectStates.draft}>In Draft</MenuItem>
                  <MenuItem value={projectStates.cancelled}>Canceled</MenuItem>
                  <MenuItem value={projectStates.inviting}>Inviting</MenuItem>
                  <MenuItem value={projectStates.submitted_to_event}>Submitted to Event</MenuItem>
                  <MenuItem value={projectStates.reopened}>Reopened</MenuItem>
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
              {this.renderEvents()}
            </div>
            <Button color="primary" variant="contained" style={{ marginTop: "20px" }} onClick={this.editProject}>Edit Project</Button>

          </div>

          
          {/* TODO
           <TextField
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

