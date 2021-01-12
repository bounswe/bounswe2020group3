import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled } from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import UserNavbar from '../Components/TopBar/UserNavbar';
import Profilebar from '../Components/ProfileBar/Profilebar';
import { getUserId, getPhoto } from "../Components/Auth/Authenticate";

const Container = styled(Box)({
    backgroundColor: '#f7f7f5',
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


export default class SearchPage extends Component {
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
            profiles:[],
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
    goToProfile = (pid) => {
        this.props.history.push(config.Profille_Page_Path+"/"+pid);
    };
    goToEvent = (eid) => {
        this.props.history.push(config.Event_Path+"/"+eid);
    };



    renderProject(){
        const projects = this.state.projects;

        return projects.map((item) => {return (
            <Paper elevation={6}  style={{border: "solid 1px blue", padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
                <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToProject(item.id)}>{item.name}</Typography>

                <Typography  style={{textAlign:"left", color:"black"}}>
                    {item.description}
                </Typography>
            </Paper>)});
    };
    renderProfiles(){
        const profiles = this.state.profiles;
        console.log(profiles)
        return profiles.map((item) => {return (
            <Paper elevation={6}  style={{border: "solid 1px blue", padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
                <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToProfile(item.owner_id)}>{item.name+" "+item.last_name}</Typography>

                <Typography  style={{textAlign:"left", color:"black"}}>
                    {item.description}
                </Typography>
            </Paper>)});
    };

    renderEvents(){
        const events = this.state.events;
        return events.map((item) => {return (
            <Paper elevation={6}  style={{border: "solid 1px blue", padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
                <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToEvent(item.id)}>{item.title}</Typography>

                <Typography noWrap  style={{textAlign:"left", color:"black"}}>
                    {item.description}
                </Typography>
            </Paper>)});
    }

    componentDidMount() {
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
        const query = { keyword: this.props.location.pathname.split('/')[2]};
        axios.post(`${config.API_URL}${config.Search_url}`,query, { headers:{ 'Content-Type': 'Application/json'}}).then(res=>{
            this.setState(res.data);
            console.log(this.state);
        });
    }

    render() {
        return (
            <Container>
                <UserNavbar
                    logout={() => { this.props.history.push(config.Login_Path) }}
                    pushProfile={() => { this.props.history.push( "/profile/" + getUserId() ) }}
                    goHome={() => { this.props.history.push(config.Homepage_Path) }}
                    history={this.props.history}
                />
                <Box style={{marginTop:"8px"}}>

                    <Profilebar
                        name={this.state.name}
                        lastName={this.state.lastName}
                        photoUrl={getPhoto()}
                        goToProjectCreation={this.goToProjectCreation}
                        goToProfile={() => { this.props.history.push( "/profile/" + getUserId() ); }}
                        goToEventCreation ={this.goToEventCreation}
                    />

                    <Grid container spacing={2} direction="row" justify="space-between" alignItems="baseline" style={{ maxHeight:`calc(100% - 200px)`, marginLeft:"200px", width:`calc(100% - 200px)`}}>

                        <Grid item sm={4} style={{ maxHeight:"90vh", overflowY: "scroll"}}>
                            <Typography variant="h3" color="primary">Projects</Typography>
                            {this.renderProject()}
                        </Grid>
                        <Grid item sm={4} style={{ maxHeight:"90vh", overflowY: "scroll"}}>
                            <Typography variant="h3" color="primary">Profiles</Typography>
                            {this.renderProfiles()}
                        </Grid>
                        <Grid item sm={4} >
                            <Grid style={{ maxHeight: "90vh", overflowY: "scroll" }} item sm={12}>
                                <Typography variant="h3" color="primary">Events</Typography>
                                {this.renderEvents()}
                            </Grid>
                        </Grid>
                    </Grid>
                    <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
                </Box>
            </Container>);
    }
}
