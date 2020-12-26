import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { Button, styled, Chip } from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import UserNavbar from '../Components/TopBar/UserNavbar';
import Profilebar from '../Components/ProfileBar/Profilebar';
import { colorCodes } from "../Common/ColorTheme";
import { getUserId, getAccessToken, getPhoto, setProfileId } from "../Components/Auth/Authenticate";

const Container = styled(Box)({
    background: "#f9f9eb",
    border: 0,
    borderRadius: 3,
    boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
    color: 'white',
    paddingBottom:"60px",
    top:"0",
    bottom:"0",
    left:"0",
    right:"0",
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
            name:"",
            lastName:"",
            message: "",
            messageType: "",
            projects:[],
            events:[],
            milestones:[],
        }
    };

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    };
    goToLogin = () => {
        this.props.history.push(config.Login_Path);
    };
    goToRegister = () => {
        this.props.history.push(config.Register_Path);
    };
    goToProjectCreation = () => {
      this.props.history.push(config.Create_Project_Path);
    };
    goToEventCreation = () => {
      this.props.history.push(config.Event_Creation_Path);
    };
    goToProject = (pid) => {
      this.props.history.push(config.Projectpage_Path+"/"+pid);
    };
    goToEvent = (eid) => {
      this.props.history.push(config.Event_Path+"/"+eid);
    };

    componentDidMount() {
      axios.get(`${config.API_URL}${config.Create_Project_Url}`, { headers:{ 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}`}})
        .then(res => {
          const projects = res.data;
          console.log(projects);
          this.setState({ projects:projects });
        });
      axios.get(`${config.API_URL}${config.Event_Creation_Url}`, { headers:{'Content-Type':'Application/json'}})
        .then(res => {
          this.setState({ events:res.data });
        });
        axios.get(`${config.API_URL}${config.OwnMilestoneUrl}`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          this.setState({ milestones: res.data.result });
        });
      axios.get(`${config.API_URL}/api/users/${getUserId()}/`, { headers:{'Content-Type':'Application/json', 'Authorization': `Token ${getAccessToken()}`}})
        .then(res => {
          let name = res.data.profile[0].name;
          let mname = res.data.profile[0].middle_name;
          let lastname = res.data.profile[0].last_name;
          name = name + " " + mname;
          let profileId = res.data.profile[0].id;
          setProfileId(profileId);
          this.setState({ name:name , lastName: lastname });

        });
  }
  renderTags(tags) {
    return tags.map((item) => {
      return (
        <Chip style={{ background: colorCodes[item.color], margin: "3px", textTransform: "capitalize" }} label={item.name} />
      )
    });
  };
    renderProject(){
      var projects = this.state.projects;
      return projects.map((item) => {return (
      <Paper elevation={6}  style={{padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
        <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToProject(item.id)}>{item.name}</Typography>
        <Typography  style={{textAlign:"left", color:"black"}}>{this.renderTags(item.tags)}</Typography>
        <Typography  style={{textAlign:"left", color:"black"}}>
          {item.description}
        </Typography>
        </Paper>)});
  };
                          
    renderMilestones(){
      var milestones = this.state.milestones;
      return milestones.map((item) => {return (
      <Paper elevation={6}  style={{padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
        <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToProject(item.id)}>{item.name}</Typography>
        <Typography noWrap style={{textAlign:"left", color:"black"}}>
          {item.description}
        </Typography>
        </Paper>)
         });
    };
    renderFeed(){
      var news = [];
      return news.map((item) => {return (<p>{item}</p>)});
    };
    renderEvents(){
      var events = this.state.events;
      return events.map((item) => {return (<Paper elevation={6}  style={{padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
        <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToEvent(item.id)}>{item.title}</Typography>
        <Typography noWrap style={{textAlign:"left", color:"black"}}>
          {item.description}
        </Typography>
        </Paper>)});
    };
    

    render() {
      return (
        <Container style={{backgroundColor: '#f7f7f5'}}>
        <UserNavbar
            logout={() => { this.props.history.push(config.Login_Path) }}
            pushProfile={() => { this.props.history.push( "/profile/" + getUserId() ) }}
            goHome={() => { this.props.history.push(config.Homepage_Path) }}
          />
          <Box style={{marginTop:"8px"}}>

            <Profilebar 
              name={this.state.name}
              lastName={this.state.lastName}
              photoUrl={getPhoto()}
              goToProjectCreation={this.goToProjectCreation}
              goToProfile={() => { this.props.history.push( "/profile/" + getUserId() ); }}
            />

          <Grid container spacing={2} direction="row" justify="space-between" alignItems="baseline" style={{overflowY:"scroll", marginLeft:"200px", width:`calc(100% - 200px)`}}>
            
             <Grid item sm={9} style={{ maxHeight:"88vh"}}>
               <Typography variant="h3" color="primary">Home</Typography>
               {this.renderProject()}
             </Grid> 
            <Grid item sm={3} >
              <Grid style={{ maxHeight: "40vh", overflowY: "scroll" }} item sm={12}>
                <Typography variant="h5" color="primary">Upcoming Events</Typography>
                {this.renderEvents()}
              </Grid>
              <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={this.goToEventCreation}>Create an Event</Button>
              <Typography variant="h5" color="primary">Milestones</Typography>
              <Grid style={{maxHeight:"40vh", overflowY:"scroll"}} item sm={12}>
                {this.renderMilestones()}
              </Grid>
            </Grid>
          </Grid>
          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
          </Box>
        </Container>);
    }
}
