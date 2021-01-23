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
import { getUserId, getAccessToken, getPhoto, getProfileId } from "../Components/Auth/Authenticate";

const Container = styled(Box)({
  backgroundColor: '#f7f7f5',
  background: "#f9f9eb",
  border: 0,
  borderRadius: 3,
  boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
  color: 'white',
  height: "calc(98vh -64px)",
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
      events: [],
      tags: [],
      milestones: [],
      username: "",
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
      owner: ""
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
  handleColabQuery = (e) => {
    this.setState({ colabQuery: e.target.value })
  };
  goToProfile = () => {
    this.props.history.push("/profile/" + getUserId());
  };
  goToEvent = (eid) => {
    this.props.history.push(config.Event_Path + "/" + eid);
  };
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
    axios.get(`${config.API_URL}${config.Projectpage_url}${project_id}/`, { headers: {  'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        const prof = res.data;
        const temp_members = (prof.members ? prof.members : [])
        this.setState({
          name: prof.name, desc: prof.description,
          membersData: (prof.members ? prof.members : []), 
          reqs: prof.requirements,
          stat: prof.state, age: prof.age, type: prof.project_type,
          due: prof.due_date, tags: prof.tags, isPublic: prof.is_public,
          owner: prof.owner
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
        this.props.history.push("/"); // Forwards from unexisting profiles to homepage
      });
    axios.get(`${config.API_URL}${config.Milestone_url}?project__id=${project_id}`, { headers: {  'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          const prof = res.data
          console.log(prof)
          if (prof == null) {
            this.setState({ milestones: [] });
          } else {
            this.setState({ milestones: prof }); // ATTENTION : May cause bugs later ! ! !
            console.log(this.state.milestones)
          }
        }, (error) => {
          this.props.history.push("/"); // Forwards from unexisting profiles to homepage
        });
  }
  getProfile = () => {
    axios.get(`${config.API_URL}/api/users/${getUserId()}/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
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
      for(let i = 0 ; i < membersData.length ; i++){
        ids.push(membersData[i].profile[0].id);
      }
      console.log(ids, membersData);
      console.log(ids, getProfileId())
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
          { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
          .then(res => {
              console.log((res.data))
              this.setState({notifications: res.data})
          });
  };

  renderContributor() {
    var mems = this.state.members;
    return mems.map((item) => {
      return (
        <Typography variant="h6" color="primary" style={{ cursor: "pointer", width: "100%", textAlign: "left", textTransform:"capitalize" }}>{item}</Typography>
      )
    });
  };

  renderEvents() {
    const { events } = this.state;
    if (events.length === 0) return (  <Typography variant='h6' color="textPrimary">No Related Events</Typography>)

    return events.map((item) => {
      console.log(item)
      return (<>
        <Typography variant="h6" color="primary" style={{ cursor: "pointer", width: "100%", textAlign: "center" }} onClick={() => this.goToEvent(item.id)}>{item.title}</Typography>
      </>)
    });
  };

  renderMilestones() {
    const milestones = JSON.parse(JSON.stringify(this.state.milestones));
    if (milestones.length === 0) return (
        <Paper elevation={6}
               style={{ border: "solid 1px blue",
                 padding: "15px", maxHeight: "80px",
                 background: "white", margin: "auto", marginBottom: "10px", textAlign: "middle", overflow: "clip"
               }}
               borderColor="primary" border={1}>
        <Typography variant='h6' color="textPrimary">No Related Milestones</Typography>
        </Paper>)

    return milestones.map((item) => {
      return (<>
        <Paper elevation={6}
               style={{ border: "solid 1px blue",
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
            <Typography variant="h6" colour="primary">{this.state.owner}</Typography>
          </Paper>
        </Grid>
    </>)
  };

  submitColabRequest = () => {
    var proj_id = this.props.location.pathname.split('/')[2];
    axios.post(`${config.API_URL}/api/collaboration_requests/`, { from_user: this.username, to_project: proj_id }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
            .then(res => {
              this.getProject(this.state.projectId);
            })
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
  }

  renderColabRequests = () => {
    const { allColabRequests } = this.state;
    
    var ids = [];
    for(var i=0; i<allColabRequests.length; i++){
      var idPair = [allColabRequests[i].id, allColabRequests[i].from_user];
      ids.push(idPair);
    }
  
    if (ids.length === 0) return (  <Typography variant='h6' color="textPrimary">No Collaborators</Typography>)
    else return ids.map((item) => {
      return (<>
        {this.getUsernameById(item[1])}
        <Typography variant="h6" color="primary" style={{ width: "100%", textAlign: "left" }}>{this.state.profname}</Typography>
        <Button variant="contained" color="primary" style={{ marginLeft:"10px" }} onClick={() => this.acceptColabRequest(item[0])} > Accept </Button>
        <Button variant="contained" color="primary" style={{ marginLeft:"10px" }} onClick={() => this.rejectColabRequest(item[0])} > Reject </Button>
      </>)
    });
  };

  renderRequests(){
    return (
      <Grid item sm={12} style={{ maxHeight: "30vh", minHeight: "10vh", overflowY: "scroll", margin: "5px 0" }}>
        <Typography variant="h6" color="primary">Collaboration Requests</Typography>
        <Paper elevation={6} style={{border: "solid 1px blue", padding: "15px", width: "90%", background: "white", margin: "auto", marginBottom: "10px" }} borderColor="primary" border={1}>
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
        //console.log(this.state.allColabRequests);
      })
  };

  // submitColabInviteQuery = () => {
  //   var proj_id = this.props.location.pathname.split('/')[2];
    
  // }

  renderRelatedEvents = () => {
    const { isPublic } = this.state;
    if (isPublic)
      return (
        <Grid item sm={12} style={{ maxHeight: "30vh", minHeight: "10vh", overflowY: "scroll", margin: "5px 0" }}>
          <Typography variant="h6" color="primary">Related Events</Typography>
          <Paper elevation={6} style={{border: "solid 1px blue", padding: "15px", width: "90%", background: "white", margin: "auto", marginBottom: "10px" }} borderColor="primary" border={1}>
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
          />
            <Profilebar
              name={this.state.username}
              lastName={this.state.userlastname}
              photoUrl={getPhoto()}
              goToProjectCreation={this.goToProjectCreation}
              goToEventCreation={() => {this.props.history.push(config.Event_Creation_Path);}}
              goToProfile={this.goToProfile}
            />
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
              <Typography variant="h6" color="primary" style={{ marginTop: '10px' }}>Project Tags</Typography>
              <Paper elevation={6} style={{ border: "solid 1px blue", borderRadius: '5px', padding: "10px", minHeight: "40px", marginTop: '20px', textAlign: "left" }}>
                {this.renderTags()}
              </Paper>
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
              {this.state.isMember ? 
                <Grid item sm={12} style={{marginTop:"20px"}}>
                <Paper elevation={6}
                  style={{ width: "40%", height: "90%", padding: "15px", background: "white", margin: "auto", marginBottom: "10px" }}
                  borderColor="primary"
                  border={1}>
                    <>
                      <Input
                        type="text"
                        color='primary'
                        style={{ width: "90%", textTransform: "capitalize" }}
                        placeholder="Please enter a collaborator"
                        onChange={(e) => { this.handleColabQuery(e); }}
                        value={this.state.colabQuery}
                      />
                      <br />
                      <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={this.submitColabInviteQuery()}>Invite Collaborator</Button>
                    </>
                </Paper>
              </Grid>
              :
              <></>
              }
              <p></p>
            </Grid>
            <Grid item sm={4}>

              {this.renderMembers()}
              {this.renderRelatedEvents()}
              {this.renderRelatedMilestones()}
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
              {this.state.isMember ? 
                <Grid item sm={12} style={{ minHeight: "10vh" }}>
                {/* <Typography variant="h5" color="primary">Tags</Typography> */}
                <Paper elevation={6}
                  style={{border: "solid 1px blue", width: "90%", height: "90%", padding: "15px", background: "white", margin: "auto", marginBottom: "10px" }}
                  borderColor="primary"
                  border={1}>
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
                </Paper>
                {this.renderRequests()}
              </Grid>
              :
              <></>
                }
              <br />
              <br />
              {this.state.isNotMember ? 
                <Grid item sm={12} style={{ minHeight: "10vh" }}>
                <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={this.submitColabRequest}>Send Colab Request</Button>
                </Grid>
              :
              <></>
              }
              
            </Grid>
          </Grid>
          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
        </Grid>
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
      axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { tags: tagIds }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
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
      axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { tags: tagIds }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          this.setState({ showAddTag: false, tagQuery: "", currTag: [] });
          this.getProject(this.state.projectId);
        });
    }

    else if (currTag.name === undefined && tag !== "") {
      axios.post(`${config.API_URL}/api/tags/`, { name: tag.toLowerCase() }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          newTagColor = res.data.color;
          newTagId = res.data.id;
          newTagName = res.data.name;
          newTag = { color: newTagColor, id: newTagId, name: newTagName };
          newTags.push(newTag);
          tagIds = this.getTagIds(newTags);
          axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { tags: tagIds }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
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
  
  //Delete this particular tag.
  deleteTag = (tag) => {
    const { tags } = this.state;
    let id = tag.id;
    let newTags = tags;
    let tagIds = this.getTagIds(newTags);
    tagIds.splice(tagIds.indexOf(id), 1);
    axios.patch(`${config.API_URL}/api/projects/${this.state.projectId}/`, { tags: tagIds }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        this.getProject(this.state.projectId);
      })

  }

  getTags = () => {
    axios.get(`${config.API_URL}/api/tags/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        let tags = res.data;
        this.setState({ allTags: tags });
      })
  }

}
