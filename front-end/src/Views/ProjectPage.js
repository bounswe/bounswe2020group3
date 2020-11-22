import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled } from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import PrimarySearchAppBar from '../Components/TopBar/PrimarySearchAppBar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import SvgIcon from '@material-ui/core/SvgIcon';
import Typography from "@material-ui/core/Typography";

const Container = styled(Box)({
    background: "white",
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
            events:[]
        }
    };

    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    };
    goToLogin = () => {
        this.props.history.push("/login");
    };
    componentDidMount() {
      var project_id =this.props.location.pathname.split('/')[2];
      axios.get(`${config.API_URL}${config.Projectpage_url}${project_id}`, { headers:{'Content-Type':'Application/json'}})
        .then(res => {
          const prof = res.data;
          const temp_members = prof.members;
          this.setState({name:prof.name, desc:prof.description, reqs:prof.requirements,  stat:prof.state, age:prof.age, type:prof.project_type, due:prof.due_date, events:prof.events});
          temp_members.forEach((item) => {axios.get(`${item}`,{ headers:{'Content-Type':'Application/json'}})
          .then(ress=>{
            var last_members = this.state.members;
            const member = ress.data.profile[0];
            last_members.push(member.name+" "+member.last_name);
            this.setState({members:last_members});
          })})
        })
    };

    renderComment(){
      var projects = ["It is a good project"];
      return projects.map((item) => {return (<p>{item}</p>)});
    };
    renderContributor(){
      var mems = this.state.members;
      return mems.map((item) => {return (<p>{item}</p>)});
    };
    renderEvents(){
      var events = this.state.events;
      return events.map((item) => {return (<Paper>{item}</Paper>)});
    };

    render() {
      return (
        <Container>
          <PrimarySearchAppBar loginNav={this.goToLogin}/>
          <Typography variant="h4" color="primary">Project Page</Typography>
          <Grid container direction="row" justify="space-evenly" alignItems="baseline">
            <Grid item sm={1}/>
            <Grid item sm={6}>
              <Typography variant="h5" color="primary">{this.state.name}</Typography>
              <Typography variant="h5" color="primary">Brief Description</Typography>
              <Paper style={{minHeight: "200px"}}>
              <p>{this.state.desc}</p>
              </Paper>
              <Typography variant="h5" color="primary">Colaboration Qualifications</Typography>
              <Paper style={{minHeight: "200px"}}>
              <p>{this.state.reqs}</p>
              </Paper>
              <Typography variant="h5" color="primary">Comments</Typography>
              <Paper style={{minHeight: "200px"}}>
              {this.renderComment()}
              </Paper>
            </Grid>
            <Grid item sm={3}>
              <Paper>
              <SvgIcon><svg width="24" height="24" viewBox="0 0 24 24"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg></SvgIcon>
              Follow()
              </Paper>
              <Typography variant="h5" color="primary">Contributors</Typography>
              <Paper style={{minHeight: "200px"}}>
              {this.renderContributor()}
              </Paper>
              <Typography variant="h5" color="primary">Related Events</Typography>
              <Paper style={{minHeight: "200px"}}>
              {this.renderEvents()}
              </Paper>
            </Grid>
            </Grid>
          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message}/>
        </Container>);
    }

}
