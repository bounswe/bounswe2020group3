import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import {FormControl,Select, InputLabel,TextField, MenuItem,styled, Chip, Accordion, AccordionSummary, AccordionDetails, Checkbox, FormControlLabel, Button, FormGroup, RadioGroup, Radio } from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import UserNavbar from '../Components/TopBar/UserNavbar';
import Profilebar from '../Components/ProfileBar/Profilebar';
import { colorCodes } from "../Common/ColorTheme";
import {getUserId, getPhoto, getAccessToken, setProfileId, getRequestHeader} from "../Components/Auth/Authenticate";
import ExpandMoreIcon from "@material-ui/icons/ExpandMore";
import DateComponent from "../Components/Date/DateComponent";


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
const width = {
    width: "60%",
    minWidth: "100px"

}
const dropdownMenuStyle = {
    minWidth: "150px",
    marginLeft: "12px",
    marginTop: "10px"
}

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
            notifications: [],
            events:[],
            profiles:[],
            projects_open: [],
            events_open: [],
            profiles_open: [],
            project_tag_filters: [],
            project_tag_filters_id: [],
            project_state_filters: [],
            active_project_tag_filters: [],
            active_project_state_filters: "all",
            aff:"",
            exp:"",
            date:"",
            event_date_after: "",
            event_date_before: "",
            event_deadline_after: "",
            event_deadline_before: "",
            event_type:"all",
            filter:false,
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

    handleEventBeforeChange = (date) => {
        this.setState({ event_date_before: date });
    };
    handleEventAfterChange = (date) => {
        this.setState({ event_date_after: date });
    };
    handleEDeadlineAfterChange = (date) => {
        this.setState({ event_deadline_after: date });
    };
    handleEDeadlineBeforeChange = (date) => {
        this.setState({ event_deadline_before: date });
    };
    handleAffChange = (e) => {
        this.setState({ aff: e.target.value });
    };
    handleExpChange = (e) => {
        this.setState({ exp: e.target.value });
    };
    handleTypeChange = (e) => {
        this.setState({ event_type: e.target.value });
    };
    handleStateChange = (e) => {
        this.setState({ active_project_state_filters: e.target.value });
    };
    handleTagChange = (e) => {
        const change =this.state.active_project_tag_filters;
        const index = change.indexOf(e.target.value);
        if(index===-1){
            change.push(e.target.value);
        }else{
            change.splice(index,1);
        }
        this.setState({ active_project_tag_filters: change });
    };
    handleEventChange = (e) => {
        this.setState({ event: e.target.value });
    };

    handleFilter=()=>{
        this.setState({filter:true});
    }

    renderProject(){
        const projects = this.state.projects_open;
        return projects.map((item) => {return (
            <Paper elevation={6}  style={{border: "solid 1px blue", padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
                <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToProject(item.id)}>{item.name}</Typography>
                <Typography  style={{textAlign:"left", color:"black"}}>{this.renderTags(item.tags)}</Typography>
                <Typography style={{textAlign:"left", color:"black"}}>
                    {item.description.trim().substr(0, 120) +  (item.description.length > 120 ?  "..." : "") }
                </Typography>
            </Paper>)});
    };
    renderProfiles(){
        const profiles = this.state.profiles_open;
        return profiles.map((item) => {return (
            <Paper elevation={6}  style={{border: "solid 1px blue", padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
                <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToProfile(item.owner_id)}>{item.name+" "+item.last_name}</Typography>

                <Typography  style={{textAlign:"left", color:"black"}}>
                    {item.description}
                </Typography>
            </Paper>)});
    };
    renderEvents(){
        const events = this.state.events_open;
        return events.map((item) => {return (
            <Paper elevation={6}  style={{border: "solid 1px blue", padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
                <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToEvent(item.id)}>{item.title}</Typography>

                <Typography noWrap  style={{textAlign:"left", color:"black"}}>
                    {item.description}
                </Typography>
            </Paper>)});
    }
    renderTags(tags) {
        return tags.map((item) => {
            return (
                <Chip style={{ background: colorCodes[item.color], margin: "3px", textTransform: "capitalize" }} label={item.name} />
            )
        });
    };
    renderStateFilter(){
        const state_filters =this.state.project_state_filters;
        if(state_filters!==undefined){
            return state_filters.map((item) => {
                return (
                    <FormControlLabel
                        value={item} control={<Radio/>} label={item} style={{width: "60%",minWidth: "150px"}} />
                )
            });
        }
    };
    renderTagFilter(){
        const tag_filters_id =this.state.project_tag_filters_id;
        const tag_filters =this.state.project_tag_filters;
        if(tag_filters_id!==undefined){
            return tag_filters_id.map((item) => {
                return (
                    <FormControlLabel
                        control={<Checkbox value={item} onChange={this.handleTagChange}/>} label={tag_filters[item]} style={{width: "60%",minWidth: "150px"}} />
                )
            });
        }
    };

    renderFilters(){
        return (<Accordion style={{width: '100%'}}>
            <AccordionSummary expandIcon={<ExpandMoreIcon />} >
                <Typography variant="h3" color="primary">Filters</Typography>
            </AccordionSummary>
            <AccordionDetails >
                <Grid sm={4} spacing={2} direction="column" alignItems="baseline">
                    <Typography variant="h5" color="secondary">Projects</Typography>
                    <Typography variant="body1" color="secondary">States</Typography>
                    <Grid style={{ maxHeight: "20vh", overflowY: "scroll"}} >
                        <RadioGroup onChange={this.handleStateChange}>
                            {this.renderStateFilter()}
                        </RadioGroup >
                    </Grid>
                    <Typography variant="body1" color="secondary">Tags</Typography>
                    <Grid style={{ maxHeight: "20vh", overflowY: "scroll"}} >
                        <FormGroup>
                            {this.renderTagFilter()}
                        </FormGroup>
                    </Grid>
                </Grid>
                <Grid sm={4} spacing={2} direction="column" alignItems="baseline">
                    <Typography variant="h5" color="secondary">Profiles</Typography>
                    <TextField
                        type="text"
                        error=""
                        label="Affiliations"
                        onChange={this.handleAffChange}
                        defaultValue=""
                        variant="filled"
                        style={width}
                    />
                    <TextField
                        type="text"
                        error=""
                        label="Expertise"
                        onChange={this.handleExpChange}
                        defaultValue=""
                        variant="filled"
                        style={width}
                    />
                </Grid>
                <Grid sm={4} spacing={2} direction="column" alignItems="baseline">
                    <Typography variant="h5" color="secondary">Events</Typography>
                    <Grid>
                        <DateComponent
                            handleDateChange={this.handleEventBeforeChange}
                            helperText="Event Date before"
                            style={width}
                        />
                        <DateComponent
                            handleDateChange={this.handleEventAfterChange}
                            helperText="Event Date after"
                            style={width}
                        />
                        <DateComponent
                            handleDateChange={this.handleEDeadlineBeforeChange}
                            helperText="Event Deadline Before"
                            style={width}
                        />
                        <DateComponent
                            handleDateChange={this.handleEDeadlineAfterChange}
                            helperText="Event Deadline after"
                            style={width}
                        />
                    </Grid>
                    <FormControl>
                        <InputLabel style={{ marginLeft: "12px" }} id="projectType">Project Type</InputLabel>
                        <Select
                            style={dropdownMenuStyle}
                            onChange={this.handleTypeChange}
                            labelId="projectType"
                        >
                            <MenuItem value={"all"}>All</MenuItem>
                            <MenuItem value={"academic conference"}>Conference</MenuItem>
                            <MenuItem value={"funded project"}>Institution</MenuItem>
                            <MenuItem value={"journal submission"}>Journal</MenuItem>
                        </Select>
                    </FormControl>
                </Grid>
            </AccordionDetails>
            <Button variant="contained" color="primary" style={{ margin: "10px" }}
                    onClick={this.handleFilter}>Filter Results</Button>
        </Accordion>);
    };
    renderResults(){
        return (
            <Grid container direction="row" justify="space-between" alignItems="baseline">
                <Grid item sm={4} style={{ maxHeight:"75vh", overflowY: "scroll"}}>
                <Typography variant="h3" color="primary">Projects</Typography>
                {this.renderProject()}
            </Grid>
                <Grid item sm={4} style={{ maxHeight:"75vh", overflowY: "scroll"}}>
                    <Typography variant="h3" color="primary">Profiles</Typography>
                    {this.renderProfiles()}
                </Grid>
                <Grid item sm={4} style={{ maxHeight:"75vh", overflowY: "scroll"}} >
                    <Typography variant="h3" color="primary">Events</Typography>
                    {this.renderEvents()}
                </Grid>
            </Grid>);
    };

    componentDidUpdate() {
        if(this.state.filter){
            const s_keyword = this.props.location.pathname.split('/')[2];
            const {aff, exp, event_date_after, event_date_before, event_deadline_after, event_deadline_before, event_type,active_project_state_filters, active_project_tag_filters,event} =this.state;
            let query_profile = { keyword:s_keyword ,search_type:"profile"};
            if(aff!=="")
                query_profile.profile_affiliations=aff;
            if(exp!=="")
                query_profile.profile_expertise= exp;
            axios.post(`${config.API_URL}${config.Search_url}`,query_profile, { headers:{ 'Content-Type': 'Application/json'}}).then(res=>{
                this.setState({profiles_open:res.data.profiles,filter:false});
            });
            let query_event = { keyword:s_keyword,search_type:"event"};
            if(event_date_after!=="")
                query_event.event_date_after=event_date_after;
            if(event_date_before!=="")
                query_event.event_date_before= event_date_before;
            if(event_deadline_after!=="")
                query_event.event_deadline_after=event_deadline_after;
            if(event_deadline_before!=="")
                query_event.event_deadline_before= event_deadline_before;
            if(event_type !== "all")
                query_event.event_type= event_type;
            axios.post(`${config.API_URL}${config.Search_url}`,query_event, { headers:{ 'Content-Type': 'Application/json'}}).then(res=>{
                this.setState({ events_open:res.data.events,filter:false});
            });
            let query_project = {
                keyword: s_keyword,
                search_type: "project"
            };

            if(active_project_tag_filters.length!==0){
                query_project.project_tags=active_project_tag_filters;
            }
            if(event!=="all"){
                query_project.project_event=event;
            }
            axios.post(`${config.API_URL}${config.Search_url}`,query_project, { headers:{ 'Content-Type': 'Application/json'}}).then(res=>{
                this.setState({projects_open:res.data.projects,filter:false});
            });

            if(active_project_state_filters!=="all"){
                const active_projects=this.state.projects_open.filter(item=>item.state===active_project_state_filters);
                this.setState({projects_open:active_projects,active_project_state_filters:"all",filter:false});
            }
        }
    }
    componentDidMount() {
        const preprocess= (acc,curr)=> {
            if(acc.indexOf(curr)===-1 && curr !== undefined){
                acc.push(curr)
            }
            return acc
        };
        const group= (acc,curr)=> {
            let id = curr[0];
            if(!acc[id] && curr !== undefined){
                acc[id]=curr[1];
            }
            return acc
        };

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

        axios.get(`${config.API_URL}/api/notifications/unread/`,
            getRequestHeader())
            .then(res => {
                console.log((res.data))
                this.setState({notifications: res.data})
            });

        const query = { keyword: this.props.location.pathname.split('/')[2]};
        axios.post(`${config.API_URL}${config.Search_url}`,query, { headers:{ 'Content-Type': 'Application/json'}}).then(res=>{
            this.setState(res.data);
            const projects = res.data.projects;
            const project_state = projects.map(project=>{return project.state}).flat().reduce(preprocess,[]);
            const project_tags = projects.map(project=>{return project.tags.map(tag=>{return [tag.id,tag.name]})}).flat().reduce(group,[]);
            const project_tags_id = projects.map(project=>{return project.tags.map(tag=>{return tag.id})}).flat().reduce(preprocess,[]);

            this.setState({projects_open:projects, events_open:res.data.events, profiles_open:res.data.profiles,});
            this.setState({project_state_filters:project_state, project_tag_filters:project_tags,project_tag_filters_id:project_tags_id});
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
                    notifications = {this.state.notifications}
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
                    <Grid container spacing={2} direction="row" justify="space-between" alignItems="baseline" style={{overflowY:"scroll", maxHeight:"87vh", marginLeft:"200px", width:`calc(100% - 200px)`}}>
                        <Grid item sm={12}>
                        {this.renderFilters()}
                        </Grid>
                        <Grid item sm={12}>
                            {this.renderResults()}
                        </Grid>
                    </Grid>
                    <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
                </Box>
            </Container>);
    }
}
