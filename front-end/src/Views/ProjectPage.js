import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled, Chip, Button, Input } from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import UserNavbar from '../Components/TopBar/UserNavbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import Profilebar from '../Components/ProfileBar/Profilebar';
import { colorCodes } from "../Common/ColorTheme";
import { getUserId, getPhoto, getProfileId, getRequestHeader, getAccessToken, isLoggedIn } from "../Components/Auth/Authenticate";

const Container = styled(Box)({
  backgroundColor: '#f7f7f5',
  background: "#f9f9eb",
  border: 0,
  borderRadius: 3,
  boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
  height: "calc(98vh -64px)",
  color: 'white',
  paddingBottom:"38px",
  top:0,
  left:"0",
  right:"0",
  margin: "auto",
  zIndex: 2,
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
      loop: 0,
      name: "",
      desc: "",
      reqs: "",
      members: [],
      profname: "",
      membersData : [],
      stat: "",
      type: "",
      due: "",
      colabQuery: "",
      colabInviteId: 0,
      events: [],
      tags: [],
      colabRequestText: "Send Colab Request",
      milestones: [],
      username: "",
      requestIds: [],
      requestNames: [],
      userlastname: "",
      photoUrl: "",
      projectId: "",
      showAddTag: false,
      showInviteColab: false,
      tagQuery: "",
      allColabRequests: [],
      currTag: [],
      allTags: [],
      isMember: false,
      isNotMember: true,
      isPublic: false,
      notifications: [],
      requests: [],
      owner: "",
      ownerId:-1,
      recommendations: []
    }
  };

  distinct(value, index, self) {
    return self.indexOf(value) === index;
  }

  handleSnackbarOpen = () => {
    this.SnackbarRef.current.turnOnSnackbar();
  };
  goToLogin = () => {
    this.props.history.push("/login");
  };
  handleTagQuery = (e) => {
    this.setState({ tagQuery: e.target.value })
  };
  handleColabRequestText = (myText) => {
    this.setState({colabRequestText: myText});
  };
  handleColabQuery = (e) => {
    this.setState({ colabQuery: e.target.value })
  };
  goToProfile = () => {
    this.props.history.push("/profile/" + getUserId());
  };
  goToEvent = (eid) => {
    this.props.history.push(config.Event_Path + "/" + eid);
  };
  handleLoop = () => {
    var i = this.state.loop;
    i = i + 1;
    this.setState({loop: i}); 
  }
  goToProjectCreation = () => {
    this.props.history.push(config.Create_Project_Path);
  };
  goToEditProjectPage = (pid) => {
    this.props.history.push("/edit-project/" + pid);
  };
  goToProjectFiles = (pid) => {
    this.props.history.push("/project/files/" + pid);
  }
  getProject = (project_id) => {
    axios.get(`${config.API_URL}${config.Projectpage_url}${project_id}/`, getRequestHeader())
      .then(res => {
        const prof = res.data;
        //console.log(prof);
        const temp_members = (prof.members ? prof.members : [])
        this.setState({
          name: prof.name, desc: prof.description,
          membersData: (prof.members ? prof.members : []), 
          reqs: prof.requirements,
          stat: prof.state, age: prof.age, type: prof.project_type,
          due: prof.due_date, tags: prof.tags, isPublic: prof.is_public,
          owner: prof.owner,
          ownerId: prof.owner_id
        }, () => {
          this.isMember();
        });
        if (prof.event == null) {
          this.setState({ events: [] });
        } else {
          this.setState({ events: [prof.event] }); // ATTENTION : May cause bugs later ! ! ! 
        }
        let memberNames = []
        temp_members.forEach(item => {
          const member = item.profile[0];
          memberNames.push(member.name + " " + member.last_name); // ATTENTION : WE may want to add the middle names as well.
        });

        this.setState({ members: memberNames });
      }, (error) => {
        //console.log(error);
        //this.props.history.push("/"); // Forwards from unexisting profiles to homepage
      });
    axios.get(`${config.API_URL}${config.Milestone_url}?project__id=${project_id}`, getRequestHeader())
        .then(res => {
          const prof = res.data
          //console.log(prof)
          if (prof == null) {
            this.setState({ milestones: [] });
          } else {
            this.setState({ milestones: prof }); // ATTENTION : May cause bugs later ! ! !
            //console.log(this.state.milestones)
          }
        }, (error) => {
          this.props.history.push("/"); // Forwards from unexisting profiles to homepage
        });
  }
  getProfile = () => {
    axios.get(`${config.API_URL}/api/users/${getUserId()}/`, getRequestHeader())
      .then(res => {
        let name = res.data.profile[0].name;
        let mname = res.data.profile[0].middle_name;
        let lastname = res.data.profile[0].last_name;
        name = name + " " + mname;
        this.setState({ username: name, userlastname: lastname });
      });
  };

  isMember = () => {
      const { membersData } = this.state;
      let ids = []
      //console.log(membersData)
      for(let i = 0 ; i < membersData.length ; i++){
        ids.push(membersData[i].profile[0].id);
      }
      //console.log(ids, membersData);
      //console.log(ids, getProfileId())
      if( ids.includes(parseInt(getProfileId() ) ) ){
        this.setState({isMember :true})
      }
      if( ids.includes(parseInt(getProfileId() ) ) ){
        this.setState({isNotMember :false})
      }
  }

  componentDidMount() {
    var project_id = this.props.location.pathname.split('/')[2];
    this.setState({ projectId: project_id });
    this.getProject(project_id);
    this.getProfile();
    this.getTags();
    this.getColabRequests();
    // this.getColabs();
      axios.get(`${config.API_URL}/api/notifications/unread/`,
          getRequestHeader())
          .then(res => {
              //console.log((res.data))
              this.setState({notifications: res.data})
          });
      axios.get(`${config.API_URL}/api/users/get_collaborator_recommendation/?project_id=${project_id}&project_count=5`, getRequestHeader())
          .then(res => {
              console.log(res.data)
              this.setState({ recommendations: res.data });
          });
  };

  renderContributor() {
    const { members, membersData } = this.state;
    return members.map((item, id) => {
      return (
        <Typography variant="h6" color="primary" 
        onClick={() => {this.props.history.push("/profile/"+ membersData[id].id )}}
        style={{ cursor: "pointer", width: "100%", textAlign: "left", textTransform:"capitalize" }}>{item}</Typography>
      )
    });
  };

  renderEvents() {
    const { events } = this.state;
    if (events.length === 0) return (  <Typography variant='h6' color="textPrimary">No Related Events</Typography>)

    return events.map((item) => {
      //console.log(item)
      return (<>
        <Typography variant="h6" color="primary" style={{ cursor: "pointer", width: "100%", textAlign: "center" }} onClick={() => this.goToEvent(item.id)}>{item.title}</Typography>
      </>)
    });
  };

  renderMilestones() {
    const milestones = JSON.parse(JSON.stringify(this.state.milestones));
    if (milestones.length === 0) return (
        <Paper elevation={6}
               style={{ border: "solid 1px blue", width: "90%",
                 padding: "15px", maxHeight: "80px",
                 background: "white", margin: "auto", marginBottom: "10px", textAlign: "middle", overflow: "clip"
               }}
               borderColor="primary" border={1}>
        <Typography variant='h6' color="textPrimary">No Related Milestones</Typography>
        </Paper>)

    return milestones.map((item) => {
      return (<>
        <Paper elevation={6}
               style={{ border: "solid 1px blue", width: "90%",
                 padding: "15px", maxHeight: "80px",
                 background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
               }}
               borderColor="primary" border={1}>
          <Typography variant="h6" color="primary"
                      style={{ cursor: "pointer", display:"inline-block" }}
          >{item.date}</Typography>
          <hr />
          <Typography nowrap variant="body2" style={{ textAlign: "left", color: "black" }}>
            {item.description.substr(0, 120)}
            {/*May need more fine tuning as a future work.*/}
          </Typography>
        </Paper>
      </>)
    });
  };

  renderDeadlines() {
    const deadlines = JSON.parse(JSON.stringify(this.state.events));
    deadlines.push({ "deadline": this.state.due });
    deadlines.sort();
    return deadlines.map((item) => {
      return (
        <Typography variant="h6" color="primary" style={{ cursor: "pointer", width: "100%", textAlign: "center" }}>{item.deadline}</Typography>
      )
    });
  };

  renderTags() {
    const { tags } = this.state;
    return tags.map((item) => {
      return (<>{this.state.isMember ?
        <Chip onDelete={() => { this.deleteTag(item) }}
          style={{ background: colorCodes[item.color], margin: "3px", textTransform: "capitalize" }}
          label={item.name} />
        :
        <Chip style={{ background: colorCodes[item.color], margin: "3px", textTransform: "capitalize" }} label={item.name} />
      }
      </>)
    });
  };

  renderDesiredTags = () => {
    const { tagQuery, allTags } = this.state;
    if (tagQuery === "") return;
    return allTags.map((item) => {
      let tag = item.name;
      return (<>
        {tag.toLowerCase().includes(tagQuery.toLowerCase()) && !this.inTags(tag) ?
          <Chip
            style={{ background: colorCodes[item.color], margin: "3px", cursor: "pointer", textTransform: "capitalize" }}
            onClick={() => { this.setState({ currTag: item, tagQuery: item.name }) }}
            label={item.name} />
          :
          <></>
        }
      </>
      )
    });
  }

  renderCollabQualifications = () => {
    const { isPublic } = this.state;
    return(
      <>
      {isPublic ? 
      <>
        <Typography variant="h6" color="primary" style={{ marginTop: '10px' }}>Collaboration Qualifications</Typography>
        <Paper elevation={6} style={{ border: "solid 1px blue", borderRadius: '5px', textAlign: "left", minHeight: "100px", padding: "10px" }}>
          <div style={{ height: "100%", width: "100%" }}>
            {this.state.reqs}
          </div>
        </Paper>
        </>
        :
        <></>
      }
      </>
    )
  };

  renderMembers = () => {
    const { isPublic } = this.state;
    if (isPublic)
      return (
        <Grid item sm={12} style={{ maxHeight: "30vh", minHeight: "10vh", overflowY: "scroll", margin: "5px 0" }}>
          <Typography variant="h6" color="primary">Contributors</Typography>
          <Paper elevation={6} style={{border: "solid 1px blue", padding: "15px", width: "90%", background: "white", margin: "auto", marginBottom: "10px" }} borderColor="primary" border={1}>
            {this.renderContributor()}
          </Paper>
        </Grid>
      )
    else return(<>
    <Grid item sm={12} style={{ maxHeight: "30vh", minHeight: "10vh", overflowY: "scroll", margin: "5px 0" }}>
          <Typography variant="6" color="primary">Owner</Typography>
          <Paper elevation={6} style={{ padding: "15px", width: "90%", background: "white", margin: "auto", marginBottom: "10px" }} borderColor="primary" border={1}>
          <Typography variant="h6" color="primary"
            style={{ cursor: "pointer" }}
            onClick={() => {this.props.history.push("/profile/"+this.state.ownerId)}}>{this.state.owner}</Typography>
          </Paper>
        </Grid>
    </>)
  };

  submitColabRequest = () => {
    var proj_id = this.props.location.pathname.split('/')[2];
    axios.post(`${config.API_URL}/api/collaboration_requests/`, { from_user: getUserId(), to_project: proj_id }, getRequestHeader() )
          .then(res => {
            this.getProject(this.state.projectId);
            var myText = "Colab Request Sent";
            this.handleColabRequestText(myText);
        }); 
  };

  deleteColabRequest = (myId) => {
    axios.delete(`${config.API_URL}/api/collaboration_requests/${myId}/`, { id: myId }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
            .then(res => {
              this.getProject(this.state.projectId);
            })
        }); 
  }

  acceptColabRequest = (myId) => {
    axios.post(`${config.API_URL}/api/collaboration_requests/${myId}/accept_collaboration/`, { id: myId }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          this.deleteColabRequest(myId);
          window.location.reload(true);
        }); 
  };

  rejectColabRequest = (myId) => {
    axios.post(`${config.API_URL}/api/collaboration_requests/${myId}/reject_collaboration/`, { id: myId }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          this.deleteColabRequest(myId);
          window.location.reload(true);
        }); 
  };

  getUsernameById(id){
    axios.get(`${config.API_URL}/api/users/${id}/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        let name = res.data.profile[0].name;
        let mname = res.data.profile[0].middle_name;
        let lastname = res.data.profile[0].last_name;
        let userName = name + " " + mname + " " + lastname;

        this.setState({profname : userName});
      });
  };

  renderColabRequests = () => {
    const {requests} = this.state;
    if(this.state.loop < 3){
      this.getColabRequests();
      this.handleLoop();
    }
    
    if (requests.length === 0) return (  <Typography variant='h6' color="textPrimary">No Collaboration Requests</Typography>)
    else return requests.map((item) => {
      return (<>
        <Typography variant="h6" color="primary" style={{ width: "100%", textAlign: "left" }}>{item[0]}</Typography>
        <Button variant="contained" color="primary" style={{ marginLeft:"10px" }} onClick={() => this.acceptColabRequest(item[1])} > Accept </Button>
        <Button variant="contained" color="primary" style={{ marginLeft:"10px" }} onClick={() => this.rejectColabRequest(item[1])} > Reject </Button>
      </>)
    });
  };

  renderRequests(){
    return (
      <Grid item sm={12} style={{ maxHeight: "30vh", minHeight: "10vh", overflowY: "scroll", margin: "5px 0" }}>
        <Typography variant="h6" color="primary">Collaboration Requests</Typography>
        <Paper elevation={6} style={{border: "solid 1px blue", padding: "15px",  background: "white", margin: "auto", marginBottom: "10px" }} borderColor="primary" border={1}>
          {this.renderColabRequests()}
        </Paper>
      </Grid>
    )
  }

  getColabRequests = () => {
    axios.get(`${config.API_URL}/api/collaboration_requests/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        let colabRequests = res.data;
        let reqs = [];
        var len = colabRequests.length;

        for(var i=0; i<len; i++){

          var proj_id = this.props.location.pathname.split('/')[2];
          var myproj = colabRequests[i].to_project;
          // eslint-disable-next-line
          if(proj_id == myproj){
            reqs.push(colabRequests[i]);
          }
        }
        var uniReqs = reqs.filter(this.distinct);
        this.setState({ allColabRequests: uniReqs });
        console.log(this.state.allColabRequests);
        // ________________________________________

        const { allColabRequests } = this.state;
        var ids = [];
        for(var k=0; k<allColabRequests.length; k++){
          var idPair = [allColabRequests[k].id, allColabRequests[k].from_user];
          ids.push(idPair);
        }
        this.setState({requestIds: ids});
        //console.log(this.state.requestIds);
        // _________________________________________

        var usernames = [];
        let promises = [];
        for(var t=0; t<ids.length; t++){
          promises.push(
            axios.get(`${config.API_URL}/api/users/${ids[t][1]}/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } }).then(res => {
              let name = res.data.profile[0].name;
              let mname = res.data.profile[0].middle_name;
              let lastname = res.data.profile[0].last_name;
              let userName = name + " " + mname + " " + lastname;
              usernames.push(userName);
            }))
        }
        Promise.all(promises).then(() => {
          console.log(usernames);
          this.setState({requestNames: usernames});
          //console.log(this.state.requestNames);
        });
        //console.log(this.state.requestNames);
        var reqDatas = [];
        for(var n=0; n<ids.length; n++){
          var reqData = [this.state.requestNames[n], ids[n][0]];
          //console.log(reqData);
          reqDatas.push(reqData);
        }
        //console.log(reqDatas);
        this.setState({requests: reqDatas});
      });
  };

  getUserIdFromUsername = (username) => {
    if(username.length > 0){
      axios.get(`${config.API_URL}/api/users/?username=${username}`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        if(res.data.length > 0){
          let data = res.data[0];
          //console.log(data.id);
          let myId = data.id;
          // eslint-disable-next-line
          if(this.state.colabInviteId != myId){
            this.setState({colabInviteId: myId});
         }
        }
      });
    }
  };

  submitColabInviteQuery = (id) => {
    var proj_id = this.props.location.pathname.split('/')[2];
    axios.post(`${config.API_URL}/api/collaboration_invites/`, { to_user: id, to_project: proj_id }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
            this.getProject(this.state.projectId);
            window.location.reload(true);
        }); 
  };

  renderRecommendations = () => {
        console.log(this.state.recommendations)
        const recommendations = this.state.recommendations;
        return (
            <Box style={{ overflowY: "scroll", maxHeight: "32vh", paddingTop: "10px", paddingBottom: "10px" }}>

                {recommendations.length !== 0
                    ?
                    recommendations.map((item) => {
                        return (
                            <Paper elevation={6}
                                   style={{border: "solid 1px blue",
                                       padding: "15px", maxHeight: "160px", width: "90%",
                                       background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
                                   }}
                                   borderColor="primary" border={1}>
                                <Typography variant="h7" color="primary"
                                            style={{ cursor: "pointer", width: "90%", textAlign: "left" }}
                                            onClick={() => { this.props.history.push("/profile/" + item.id); }}
                                >{item.username}</Typography>
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
                        <Typography variant="h6" color="textPrimary" style={{ "textAlign": 'center' }}>No Recommend Users</Typography>
                    </Paper>
                }
            </Box>)
    };

  renderRelatedEvents = () => {
    const { isPublic } = this.state;
    if (isPublic)
      return (
        <Grid item sm={12} style={{ maxHeight: "30vh", minHeight: "10vh", overflowY: "scroll", margin: "5px 0" }}>
          <Typography variant="h6" color="primary">Related Events</Typography>
          <Paper elevation={6} style={{border: "solid 1px blue", padding: "15px", background: "white" }} borderColor="primary" border={1}>
            {this.renderEvents()}
          </Paper>
        </Grid>
      )
    else return (<></>)
  }

  renderRelatedMilestones = () => {
    const { isPublic } = this.state;
    if (isPublic)
      return (
          <Grid item sm={12} style={{ maxHeight: "35vh", minHeight: "10vh", overflowY: "scroll", margin: "5px 0" }}>
            <Typography variant="h6" color="primary">Milestones</Typography>
              {this.renderMilestones()}
          </Grid>
      )
    else return (<></>)
  }

  render() {
    var project_id = this.props.location.pathname.split('/')[2];
    return (
      <Container>
          <UserNavbar
            logout={() => { this.props.history.push(config.Login_Path) }}
            pushProfile={this.goToProfile}
            goHome={() => { this.props.history.push(config.Homepage_Path) }}
            history ={this.props.history}
            notifications = {this.state.notifications}
            style={{zIndex:3}}
          />
            <Box style={{marginTop:"8px", height:"calc(100vh -64px)", overflowY:"scroll"}}>
          {isLoggedIn() ? 
            <Profilebar 
              name={this.state.username}
              lastName={this.state.userLastName}
              photoUrl={getPhoto()}
              goToProjectCreation={this.goToProjectCreation}
              goToProfile={() => { this.props.history.push( "/profile/" + getUserId() ); }}
              goToEventCreation ={this.goToEventCreation}
            />
            :
            <></>
          }

        <Grid container spacing={2} direction="row" justify="space-between" alignItems="baseline" style={{ height:"calc(91vh - 40px)",   marginLeft: "225px", marginTop: "10px", width: `calc(100% - 225px)` }}>
          <Grid container direction="row" justify="space-evenly" alignItems="baseline">
            <Grid item sm={7}>
              <Typography variant="h4" color="primary">{this.state.name}</Typography>

              {!this.state.isPublic && !this.state.isMember ?
                <Typography variant="h6" color="error">(Private Project)</Typography>
                :
                <></>
              }
              <Typography variant="h6" color="primary">Brief Description</Typography>
              <Paper elevation={6} style={{ border: "solid 1px blue", borderRadius: '5px', textAlign: "left", minHeight: "100px", padding: "10px" }}>
                <p>{this.state.desc}</p>
              </Paper>
              {this.renderCollabQualifications()}
                {this.state.isMember ?
                    <Grid item sm={12} style={{ maxHeight: "30vh", minHeight: "10vh", overflowY: 'scroll', margin: "5px 0" }}>
                        <Typography variant="h6" color="primary">Upcoming Deadlines</Typography>
                        <Paper elevation={6} style={{border: "solid 1px blue", padding: "15px", background: "white", margin: "auto", marginBottom: "10px" }} borderColor="primary" border={1}>
                            {this.renderDeadlines()}
                        </Paper>
                    </Grid>
                    :
                    <></>
                }
                {this.renderRelatedEvents()}
              <Typography variant="h6" color="primary" >Project Tags</Typography>
              <Paper elevation={6} style={{ border: "solid 1px blue", borderRadius: '5px', padding: "10px", minHeight: "40px",  textAlign: "left" }}>
                {this.renderTags()}
              </Paper>
                {this.state.isMember ?
                    <Grid item sm={12} style={{ minHeight: "10vh" ,marginTop: "10px" }}>
                        {/* <Typography variant="h5" color="primary">Tags</Typography> */}
                            {this.state.showAddTag ?
                                <>
                                    <Input
                                        type="text"
                                        color='primary'
                                        style={{ width: "90%", textTransform: "capitalize" }}
                                        placeholder="Please enter a new tag and press enter"
                                        onChange={(e) => { this.handleTagQuery(e); }}
                                        value={this.state.tagQuery}
                                    />
                                    {this.renderDesiredTags()}
                                    <br />
                                    <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={this.submitTagQuery}>Add Tag</Button>
                                </>
                                :
                                <Button color="primary" variant="outlined" onClick={() => { this.setState({ showAddTag: true }) }}>Add New Tag</Button>
                            }
                    </Grid>
                    :
                    <></>
                }
                {this.state.isMember ?
                    <Grid item sm={12} style={{ minHeight: "10vh" }}>
                        {/* <Typography variant="h5" color="primary">Tags</Typography> */}
                        {this.renderRequests()}
                    </Grid>
                    :
                    <></>
                }

              {this.state.isMember  ?
                  <Grid item sm={12} style={{ marginTop:"20px"}}>
                    <Button variant="contained" color="primary" style={{ marginTop: "10px", marginRight:"10px" }} onClick={() => this.goToEditProjectPage(project_id)}>Edit Project</Button>
                    <Button variant="contained" color="primary" style={{ marginTop: "10px", marginRight:"10px" }} onClick={() => this.goToProjectFiles(project_id)}>Project Files</Button>
                    <Button variant="contained" color="primary" style={{ marginTop: "10px" }}
                            onClick={() => { this.props.history.push("/issue-milestone", { projectId: this.state.projectId }); }}>Set New Milestone</Button>
                  </Grid>
                  :
                  <></>
              }

              <p></p>
            </Grid>
            <Grid item sm={4}>

              {this.renderMembers()}
              {this.renderRelatedMilestones()}
              {this.state.isMember ?
                    <Grid style={{maxHeight:"50vh"}} item sm={12}>
                        <Typography variant="h6" color="primary">Recommended Collaborators</Typography>
                    {this.renderRecommendations()}
                  </Grid>
                  :
                  <></>}
                {this.state.isMember && (this.state.stat === "inviting collaborators" || this.state.stat === "open for collaborators") ?
                    <Grid item sm={12} style={{marginTop:"20px"}}>
                        <Paper elevation={6}
                               style={{ width: "60%", height: "90%", padding: "15px", background: "white", margin: "auto", marginBottom: "10px" }}
                               borderColor="primary"
                               border={1}>
                            <>
                                <Input
                                    type="text"
                                    color='primary'
                                    style={{ width: "90%" }}
                                    placeholder="Please enter a collaborator"
                                    onChange={(e) => { this.handleColabQuery(e); }}
                                    value={this.state.colabQuery}
                                />
                                <br />
                                {this.getUserIdFromUsername(this.state.colabQuery)}
                                <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={() => this.submitColabInviteQuery(this.state.colabInviteId)}>Invite Collaborator</Button>
                            </>
                        </Paper>
                    </Grid>
                    :
                    <></>
                }

              <br />
              <br />
              {this.state.isNotMember && this.state.stat === "open for collaborators" ? 
                <Grid item sm={12} style={{ minHeight: "10vh" }}>
                <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={this.submitColabRequest}>{this.state.colabRequestText}</Button>
                </Grid>
              :
              <></>
              }
              
            </Grid>
          </Grid>
          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
        </Grid>
        </Box>
      </Container>);
  }

  submitTagQuery = () => {
    const { tagQuery, currTag, tags, allTags } = this.state;
    let newTagId = undefined;
    let newTagColor = undefined;
    let newTagName = undefined;
    let newTag = {};
    let newTags = tags;
    let tagIds = []
    if (tagQuery === undefined) return;
    let tag = tagQuery.trim();
    if (currTag.name !== undefined && currTag.name.toLowerCase() === tag.toLocaleLowerCase()) {
      newTags.push(currTag);
      for (let i = 0; i < newTags.length; i++) {
        tagIds.push(newTags[i].id);
      }
      axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { tags: tagIds }, getRequestHeader())
        .then(res => {
          this.setState({ showAddTag: false, tagQuery: "", currTag: [] });
          this.getProject(this.state.projectId);
        })
    }
    else if (currTag.name === undefined && tag !== "" && this.inAllTags()) {
      for (let i = 0; i < allTags.length; i++) {
        if (allTags[i].name.toLowerCase() === tagQuery.toLowerCase()) {
          newTags.push(allTags[i]);
          break;
        }
      }
      tagIds = this.getTagIds(newTags);
      axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { tags: tagIds }, getRequestHeader())
        .then(res => {
          this.setState({ showAddTag: false, tagQuery: "", currTag: [] });
          this.getProject(this.state.projectId);
        });
    }

    else if (currTag.name === undefined && tag !== "") {
      axios.post(`${config.API_URL}/api/tags/`, { name: tag.toLowerCase() }, getRequestHeader())
        .then(res => {
          newTagColor = res.data.color;
          newTagId = res.data.id;
          newTagName = res.data.name;
          newTag = { color: newTagColor, id: newTagId, name: newTagName };
          newTags.push(newTag);
          tagIds = this.getTagIds(newTags);
          axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { tags: tagIds }, getRequestHeader())
            .then(res => {
              this.setState({ showAddTag: false, tagQuery: "", currTag: [] });
              this.getProject(this.state.projectId);
            })
          // STH
        });
    }

  }


  //Get tag ids for patch operations
  getTagIds = (newTags) => {
    let tagIds = []
    for (let i = 0; i < newTags.length; i++) {
      tagIds.push(newTags[i].id);
    }
    return tagIds;
  }
  //Check if the query is one of all system tags
  inAllTags = () => {
    const { tagQuery, allTags } = this.state;
    let tag = tagQuery.trim().toLowerCase();
    for (let i = 0; i < allTags.length; i++) {
      if (allTags[i].name.toLowerCase() === tag) {
        return true;
      }
    }
  }
  //Check if the query is in your own tags
  inTags = (query) => {
    const { tags } = this.state;
    let tag = query.trim().toLowerCase();
    for (let i = 0; i < tags.length; i++) {
      if (tags[i].name.toLowerCase() === tag) {
        return true;
      }
    }
  }

  // getColabs = () => {
  //   axios.get(`${config.API_URL}/api/collaboration_invites/`, getRequestHeader())
  //     .then(res => {
  //       let colabs = res.data;
  //       this.setState({ allColabs: colabs });
  //     })
  // }
  
  //Delete this particular tag.
  deleteTag = (tag) => {
    const { tags } = this.state;
    let id = tag.id;
    let newTags = tags;
    let tagIds = this.getTagIds(newTags);
    tagIds.splice(tagIds.indexOf(id), 1);
    axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { tags: tagIds }, getRequestHeader())
      .then(res => {
        this.getProject(this.state.projectId);
      })

  }

  getTags = () => {
    axios.get(`${config.API_URL}/api/tags/`, getRequestHeader())
      .then(res => {
        let tags = res.data;
        this.setState({ allTags: tags });
      })
  }

}
