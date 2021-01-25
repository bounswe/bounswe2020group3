import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import {styled, Chip, Button, ButtonGroup} from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import UserNavbar from '../Components/TopBar/UserNavbar';
import Profilebar from '../Components/ProfileBar/Profilebar';
import { colorCodes } from "../Common/ColorTheme";
import { getUserId, getAccessToken, getPhoto, setProfileId, getRequestHeader, isLoggedIn } from "../Components/Auth/Authenticate";

const projectPerPage = 8;
const Container = styled(Box)({
    backgroundColor: '#f7f7f5',
    background: "#f9f9eb",
    border: 0,
    borderRadius: 3,
    boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
    height: "calc(98vh -64px)",
    color: 'white',
    // paddingBottom:"60px",
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
            page: 1,
            project_page: 1,
            pageCount: 0,
            project_page_count: 0,
            notifications: [],
            recommendations: [],
            pages : [],
            project_pages : [],
            feed:[],
            isFeed:isLoggedIn() 
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
        axios.get(`${config.API_URL}/api/feeds/timeline`, getRequestHeader()).then(res=>{
            const feed = res.data.results;
            const num_activity = res.data.count;
            let pages = [];
            let pageCount = Math.ceil(num_activity/projectPerPage);
            for (let i = 1; i <= pageCount; i++) {
                pages.push(i)
            }
            this.setState({feed:feed,pageCount:pageCount, pages:pages});
        })
        axios.get(`${config.API_URL}${config.Create_Project_Url}`, getRequestHeader())
            .then(res => {
                const projects = res.data.reverse();
                let project_pages = []
                let pageCount = Math.ceil(projects.length/projectPerPage);
                for (let i = 1; i <= pageCount; i++) {
                    project_pages.push(i)
                }
                this.setState({ projects:projects, project_page_count:pageCount, project_pages:project_pages });
            });
        axios.get(`${config.API_URL}${config.Event_Creation_Url}`, { headers:{'Content-Type':'Application/json'}})
            .then(res => {
                this.setState({ events:res.data });
            });
        axios.get(`${config.API_URL}${config.OwnMilestoneUrl}`, getRequestHeader())
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
        axios.get(`${config.API_URL}/api/notifications/unread/`,
            getRequestHeader())
            .then(res => {
                this.setState({notifications: res.data})
            });
        axios.get(`${config.API_URL}/api/projects/get_project_recommendation/?user_id=${getUserId()}&user_count=5`, getRequestHeader())
            .then(res => {
                this.setState({ recommendations: res.data });
            });

    }
    renderTags(tags) {
        return tags.map((item) => {
            return (
                <Chip style={{ background: colorCodes[item.color], margin: "3px", textTransform: "capitalize" }} label={item.name} />
            )
        });
    };
    renderRecommendations() {
        const { recommendations } = this.state;
        return (
            <Box style={{ overflowY: "scroll", maxHeight: "300px", paddingTop: "10px", paddingBottom: "10px" }}>

                {recommendations.length !== 0
                    ?
                    recommendations.map((item) => {
                        return (
                            <Paper elevation={6}
                                   style={{border: "solid 1px blue",
                                       padding: "10px", width: "80%",
                                       background: "white", margin: "auto", marginBottom: "10px", textAlign: "left",
                                   }}
                                   borderColor="primary" border={1}>
                                <Typography variant="span" color="primary"
                                            style={{ cursor: "pointer", width: "50%", textAlign: "left" }}
                                            onClick={() => { this.props.history.push("/project/" + item.id); }}
                                >{item.name}</Typography>
                            </Paper>
                        )
                    })
                    :
                    <Paper elevation={6}
                           style={{border: "solid 1px blue",
                               padding: "15px", maxHeight: "160px", width: "80%",
                               background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
                           }}
                           borderColor="primary" border={1}>
                        <Typography variant="h6" color="textPrimary" style={{ "textAlign": 'center' }}>No Projects Found</Typography>
                    </Paper>
                }
            </Box>)
    };

    renderProject(){
        const { projects, project_page } = this.state;
        return projects.map((item, id) => {
            if( id < projectPerPage*project_page && id >= projectPerPage*(project_page-1) ){
                return (
                    <Paper elevation={6} style={{ border: "solid 1px blue", padding: "15px", width: "80%", background: "white", margin: "auto", marginBottom: "10px" }} borderColor="primary" border={1}>
                        <Typography variant="h6" color="primary" style={{ cursor: "pointer", width: "100%", textAlign: "left" }} onClick={() => this.goToProject(item.id)}>{item.name}</Typography>
                        <Typography style={{ textAlign: "left", color: "black" }}>{this.renderTags(item.tags)}</Typography>
                        <Typography style={{ textAlign: "left", color: "black" }}>
                            {item.description.trim().substr(0, 120) + (item.description.length > 120 ? "..." : "")}
                        </Typography>
                    </Paper>
                )
            }
            else{
                return <></>
            }
        });
    };
    buttonRenderCond (id){
        const {page, pageCount} = this.state;
        return id===1 || id===pageCount || id===page || id === page-1 || id === page+1 || id===page-2 || id===page+2 || id ===page+3 || id===page-3
    }
    renderButtons() {
        const { pages, page } = this.state;
        return(
            <p>
                {pages.map((id) => {
                    if(this.buttonRenderCond(id)){
                        return(<Button variant={id !== page ? "outlined" : "contained"} color="primary" size="small" onClick={() => {this.setState({page:id})}}>{id}</Button>)
                    }else{
                        return <></>
                    }
                })}
            </p>)
    }
    projectButtonCond (id){
        const page = this.state.project_page;
        const pageCount = this.state.project_page_count;
        return id===1 || id===pageCount || id===page || id === page-1 || id === page+1 || id===page-2 || id===page+2 || id ===page+3 || id===page-3
        }


    renderProjectButtons() {
        const { project_pages, project_page } = this.state;
        return(
            <p>
                {project_pages.map((id) => {
                    if(this.projectButtonCond(id)){
                        return(<Button variant={id !== project_page ? "outlined" : "contained"} color="primary" size="small" onClick={() => {this.setState({project_page:id})}}>{id}</Button>)
                    }else{
                        return <></>
                    }
                })}
            </p>)
    }

    renderMilestones() {
        const { milestones } = this.state;
        if (isLoggedIn()){
            return (
                <Grid style={{ maxHeight: "500px", paddingTop: "10px", paddingBottom: "10px" }}>
                    {milestones.length !== 0
                        ?
                        milestones.map((item) => {
                            return (
                                <Paper elevation={6}
                                       style={{ border: "solid 1px blue",
                                           padding: "15px", maxHeight: "160px", width: "80%",
                                           background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
                                       }}
                                       borderColor="primary" border={1}>
                                    <Typography variant="h6" color="primary"
                                                style={{ cursor: "pointer", width: "50%", textAlign: "left", display:"inline-block"}}
                                                onClick={() => { this.props.history.push(`${config.Projectpage_Path}/${item.project}`) }}
                                    >{item.project_name}</Typography>
                                    <Typography variant="h6" color="primary"
                                                style={{ cursor: "pointer", width: "50%", textAlign: "right", display:"inline-block" }}
                                    >{item.date}</Typography>
                                    <hr />
                                    <Typography nowrap variant="body2" style={{ textAlign: "left", color: "black" }}>
                                        {item.description.substr(0, 120)}
                                        {/*May need more fine tuning as a future work.*/}
                                    </Typography>
                                </Paper>
                            )
                        })
                        :
                        <Paper elevation={6}
                               style={{
                                   padding: "15px", maxHeight: "160px", width: "80%",
                                   background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
                               }}
                               borderColor="primary" border={1}>
                            <Typography variant="h6" color="textPrimary" style={{ "textAlign": 'center' }}>No Upcoming Milestones</Typography>
                        </Paper>
                    }
                </Grid>)
        }
    };
    renderFeed(){
        const {feed,page} = this.state;
        return feed.map((act,index)=>{
            if( index < projectPerPage*page && index >= projectPerPage*(page-1)) {
                if (act.event !== undefined) {
                    return (<Paper elevation={6} style={{
                        border: "solid 1px blue",
                        padding: "15px",
                        width: "80%",
                        background: "white",
                        margin: "auto",
                        marginBottom: "10px"
                    }} borderColor="primary" border={1}>
                        <Typography variant="h6" color="primary"
                                    style={{cursor: "pointer", width: "100%", textAlign: "center"}}
                                    onClick={() => this.goToEvent(act.event.id)}>{act.event.title}</Typography>
                        <Typography variant="h6">is created </Typography>
                    </Paper>)
                } else if (act.project !== undefined) {
                    return (<Paper elevation={6} style={{
                        border: "solid 1px blue",
                        padding: "15px",
                        width: "80%",
                        background: "white",
                        margin: "auto",
                        marginBottom: "10px"
                    }} borderColor="primary" border={1}>
                        <Typography variant="h6">{act.actor.toUpperCase()} has created a new project called</Typography>
                        <Typography variant="h6" color="primary"
                                    style={{cursor: "pointer", width: "100%", textAlign: "center"}}
                                    onClick={() => this.goToProject(act.project.id)}>{act.project.name}</Typography>
                        <Typography
                            style={{textAlign: "left", color: "black"}}>{this.renderTags(act.project.tags)}</Typography>
                    </Paper>)
                } else if (act.follow !== undefined) {
                    return (<Paper elevation={6} style={{
                        border: "solid 1px blue",
                        padding: "15px",
                        width: "80%",
                        background: "white",
                        margin: "auto",
                        marginBottom: "10px"
                    }} borderColor="primary" border={1}>
                        <Typography variant="h6">{act.actor.toUpperCase()} started following</Typography>
                        <Typography variant="h6" color="primary"
                                    style={{cursor: "pointer", width: "100%", textAlign: "center"}} onClick={() => {
                            this.props.history.push("/profile/" + (act.follow.to_user.id));
                            window.location.reload(false);
                        }}>{act.follow.to_user.username.toUpperCase()}</Typography>
                    </Paper>)
                }else if(act.comment !== undefined){
                    return (<Paper elevation={6} style={{
                        border: "solid 1px blue",
                        padding: "15px",
                        width: "80%",
                        background: "white",
                        margin: "auto",
                        marginBottom: "10px"
                    }} borderColor="primary" border={1}>
                        <Typography variant="h6" color={"primary"}>{act.actor.toUpperCase()} {act.verb}</Typography>
                        <Typography variant="h6"> Comment is {act.comment.comment}</Typography>
                    </Paper>)
                }else if(act.rating !== undefined){
                    return (<Paper elevation={6} style={{
                        border: "solid 1px blue",
                        padding: "15px",
                        width: "80%",
                        background: "white",
                        margin: "auto",
                        marginBottom: "10px"
                    }} borderColor="primary" border={1}>
                        <Typography variant="h6" color={"primary"}>{act.actor.toUpperCase()} {act.verb}</Typography>
                    </Paper>)
                } else {
                    console.log(act);
                    return null;
                }
            }else{
                return <></>
            }
        });
    };
    renderEvents(){
        var events = this.state.events;
        return events.map((item) => {return (<Paper elevation={6}  style={{border: "solid 1px blue", padding:"15px", width:"80%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
            <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}} onClick={()=> this.goToEvent(item.id)}>{item.title}</Typography>
            <Typography noWrap style={{textAlign:"left", color:"black"}}>
                {item.description}
            </Typography>
        </Paper>)});
    };
    renderChange(){
        if(this.state.isFeed){
            return(
                <div>
                    <ButtonGroup style={{margin:"10px"}}>
                        {isLoggedIn() ?
                            <Button size="large" variant={"contained"} color="primary" onClick={() => { this.setState({ isFeed: true }) }}>Feed</Button>
                            :
                            <></>
                        }
                        <Button size="large" variant={"outlined"} color="primary" onClick={() => {this.setState({isFeed:false})}}>Projects</Button>
                    </ButtonGroup>
                    {this.renderFeed()}
                    {this.renderButtons()}
                </div>
            );
        }else{
            return(
                <div>
                    <ButtonGroup style={{margin:"10px"}}>
                        {isLoggedIn() ?
                            <Button size="large" variant={"outlined"} color="primary" onClick={() => { this.setState({ isFeed: true }) }}>Feed</Button>
                            :
                            <></>
                        }
                        <Button size="large" variant={"contained"} color="primary" onClick={() => {this.setState({isFeed:false})}}>Projects</Button>
                    </ButtonGroup>
                    {this.renderProject()}
                    {this.renderProjectButtons()}}
                </div>
            );
        }
    };

    render() {
        return (
            <Container>
                <UserNavbar
                    logout={() => { this.props.history.push(config.Login_Path) }}
                    pushProfile={() => { this.props.history.push( "/profile/" + getUserId() ) }}
                    goHome={() => { this.props.history.push(config.Homepage_Path) }}
                    history ={this.props.history}
                    notifications = {this.state.notifications}
                />
                <Box style={{marginTop:"8px"}}>
                    {isLoggedIn() ?
                        <Profilebar
                            name={this.state.name}
                            lastName={this.state.lastName}
                            photoUrl={getPhoto()}
                            goToProjectCreation={this.goToProjectCreation}
                            goToProfile={() => { this.props.history.push( "/profile/" + getUserId() ); }}
                            goToEventCreation ={this.goToEventCreation}
                        />
                        :
                        <></>
                    }

                    <Grid container spacing={2} direction="row" justify="space-between" alignItems="baseline"
                          style={{overflowY:"scroll", maxHeight:"calc(99vh - 55px)", marginLeft:"200px", width:`calc(100% - 200px)`}}>

                        <Grid item sm={9} style={{paddingBottom:"50px"}}>
                            {this.renderChange()}
                        </Grid>
                        <Grid item sm={3} >
                            <Grid style={{ maxHeight: "50vh", overflowY: "scroll" }} item sm={12}>
                                <Typography variant="h5" color="primary">Upcoming Events</Typography>
                                {this.renderEvents()}
                            </Grid>
                            <Typography variant="h5" color="primary" style={{ marginTop: "10px" }}>Recommended Projects</Typography>
                            <Grid style={{maxHeight:"50vh"}} item sm={12}>
                                {this.renderRecommendations()}
                            </Grid>
                        </Grid>
                    </Grid>
                    <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
                </Box>
            </Container>);
    }
}
