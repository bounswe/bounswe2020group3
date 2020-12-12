import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled, Chip } from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import UserNavbar from '../Components/TopBar/UserNavbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import SvgIcon from '@material-ui/core/SvgIcon';
import Typography from "@material-ui/core/Typography";

const Container = styled(Box)({
  background: "#f9f9eb",
  border: 0,
  borderRadius: 3,
  boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
  color: 'white',
  height: "calc(98vh - 64px)",
  paddingBottom: "60px",
  top: "0",
  bottom: "0",
  left: "0",
  right: "0",
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
            desc:"",
            reqs:"",
            members:[],
            stat:"",
            type:"",
            due:"",
            events:[],
            tags:[]
        }
    };

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    };
    goToLogin = () => {
        this.props.history.push("/login");
    };
    goToProfile = () => {
        this.props.history.push("/profile");
    };
    goToEvent = (eid) => {
      this.props.history.push(config.Event_Path+"/"+eid);
    };
    componentDidMount() {
      var project_id =this.props.location.pathname.split('/')[2];
      axios.get(`${config.API_URL}${config.Projectpage_url}${project_id}`, { headers:{'Content-Type':'Application/json'}})
        .then(res => {
          const prof = res.data;
          const temp_members = prof.members;
          this.setState({name:prof.name, desc:prof.description, reqs:prof.requirements,  stat:prof.state, age:prof.age, type:prof.project_type, due:prof.due_date, tags:prof.tags});
          if(prof.event == null){
            this.setState({events:[]});
          }else{
            this.setState({events:[prof.event]});
          }
          this.setState({tags:[{name:"alpha",color:"#F8C471"}]});
          temp_members.forEach(item =>{
            var last_members = this.state.members;
            const member = item.profile[0];
            last_members.push(member.name+" "+member.last_name);
            this.setState({members:last_members});
          } );

        })
    };

    renderContributor(){
      var mems = this.state.members;
      return mems.map((item) => {return (<Paper elevation={6}  style={{padding:"15px", width:"100%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
        <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}>{item}</Typography>
        </Paper>)});
    };
    renderEvents(){
      var events = this.state.events;
      return events.map((item) => {return (<Paper elevation={6}  style={{padding:"15px", width:"100%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
        <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"center"}} onClick={()=> this.goToEvent(item.id)}>{item.title}</Typography>
        </Paper>)});
    };
    renderDeadlines(){
      const deadlines = JSON.parse(JSON.stringify(this.state.events));
      deadlines.push({"deadline": this.state.due});
      deadlines.sort();
      return deadlines.map((item) => {return (<Paper elevation={6}  style={{padding:"15px", width:"100%", background:"white", margin:"auto", marginBottom:"10px"}} borderColor="primary" border={1}>
        <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"center"}}>{item.deadline}</Typography>
        </Paper>)});
    };
    renderTags(){
      var tags = this.state.tags;
      return tags.map((item) => {return (
      <Chip style={{background:item.color}} label={item.name}/>)
      });
    };

    render() {
      return (
        <Container>
          <UserNavbar
            logout={() => { this.props.history.push(config.Login_Path) }}
            pushProfile={() => { this.props.history.push("/profile") }}
            goHome={() => { this.props.history.push(config.Homepage_Path) }}
          />
          <Typography variant="h4" color="primary">Project Page</Typography>
          <Grid container direction="row" justify="space-evenly" alignItems="baseline">
            <Grid item sm={1}/>
            <Grid item sm={6}>
              <Typography variant="h5" color="primary">{this.state.name}</Typography>
              <Typography variant="h5" color="primary">Brief Description</Typography>
              <Paper elevation={6}style={{minHeight: "100px"}}>
              <p>{this.state.desc}</p>
              </Paper>
              <Typography variant="h5" color="primary">Colaboration Qualifications</Typography>
              <Paper elevation={6} style={{minHeight: "100px"}}>
              <p>{this.state.reqs}</p>
              </Paper>
              <Paper elevation={6} style={{minHeight: "100px"}}>
                <p></p>
                {this.renderTags()}
              </Paper>
              <p></p>
              <Grid container direction="row" justify="space-evenly" alignItems="baseline">
                <Grid item sm={5}>
                  <Typography variant="h5" color="primary">Recommended Users</Typography>
                  <Paper elevation={6} style={{minHeight: "100px"}}>
                    <p></p>
                  </Paper>
                </Grid>
                <Grid item sm={5}>
                  <Typography variant="h5" color="primary">Similar Projects</Typography>
                  <Paper elevation={6} style={{minHeight: "100px"}}>
                    <p></p>
                  </Paper>
                </Grid>
              </Grid>
            </Grid>
            <Grid item sm={3}>
              <Grid item sm={9}>
                <Paper elevation={6} style={{padding:"5", width:"100%", background:"white", margin:"auto", marginBottom:"10px"}}>
                <SvgIcon><svg width="24" height="24" viewBox="0 0 24 24"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg></SvgIcon>
                Follow()
                </Paper>
              </Grid>
              <Grid item sm={9} style={{ maxHeight:"40vh",minHeight: "20vh"}}>
                <Typography variant="h5" color="primary">Contributors</Typography>
                {this.renderContributor()}
              </Grid>
              <Grid item sm={9} style={{ maxHeight:"40vh",minHeight: "20vh"}}>
                <Typography variant="h5" color="primary">Upcoming Events</Typography>
                {this.renderEvents()}
              </Grid>
              <Grid item sm={9} style={{ maxHeight:"40vh",minHeight: "20vh"}}>
                <Typography variant="h5" color="primary">Upcoming Deadlines</Typography>
                {this.renderDeadlines()}
              </Grid>
            </Grid>
            </Grid>
          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
        </Container>);
    }

}
