import React, { Component } from "react";
import axios from 'axios';
import config from '../config';
import { styled, Button, Input, TextField } from '@material-ui/core';
import Box from '@material-ui/core/Box';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import UserNavbar from '../Components/TopBar/UserNavbar';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from "@material-ui/core/Typography";
import Profilebar from '../Components/ProfileBar/Profilebar';
import AlertTypes from "../Common/AlertTypes.json";
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

export default class FileViewer extends Component {
  constructor(props) {
    super(props);
    this.SnackbarRef = React.createRef();
    this.state = {
      name: "",
      desc: "",
      reqs: "",
      members: [],
      membersData : [],
      stat: "",
      type: "",
      due: "",
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
      colabQuery: "",
      currTag: [],
      allTags: [],
      isMember: false,
      isNotMember: true,
      isPublic: false,
      owner: "",
      files : [],
      currFile: undefined,
      showUpload: false,
      newFile: undefined,
      remark: ""
    }
  };

  handleSnackbarOpen = () => {
    this.SnackbarRef.current.turnOnSnackbar();
  };
  handleRemark = (e) => {
    this.setState({remark: e.target.value});
  }
  goToLogin = () => {
    this.props.history.push("/login");
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
          let isMem = this.isMember();
          if(!isMem){
            this.props.history.push(config.Homepage_Path);
          }
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
  getFiles = (projectId) => {
    axios.get(`https://paperlayer.herokuapp.com/api/files/?project=${projectId}`, 
    { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
    .then((res) => {
      let files = res.data
      for(let i = 0 ; i < files.length; i++){
        files[i].fileName =  files[i].file.split("/")[4];
      }
      
      this.setState({files: files});
    })
  }
  isMember = () =>{
      const { membersData } = this.state;
      let ids = []
      for(let i = 0 ; i < membersData.length ; i++){
        ids.push(membersData[i].profile[0].id);
      }
      if( ids.includes(parseInt(getProfileId() ) ) ){
        this.setState({isMember :true})
        this.setState({isNotMember :false})
        return true;
      }
      return false;
  }

  componentDidMount() {
    var project_id = this.props.location.pathname.split('/')[3];
    this.setState({ projectId: project_id });
    this.getProject(project_id);
    this.getProfile();
    this.getFiles(project_id);
  };
  renderFiles = () => {
    const { files } = this.state;
    
    return files.map((item) => {
      return <Paper elevation={6} style={{ textAlign: "left", minHeight:"30px", marginBottom:"10px",padding:"5px", width:"95%" }}>
        <Typography
          variant="caption"
          color="primary"
          style={{ cursor:'pointer', display: "inline-block", maxWidth: "85%", fontSize:"15px", overflowWrap:"break-word" }}
          onClick={() => { 
            axios.get(`${config.API_URL}/api/files/${item.id}/retrieve_file/`, 
              { headers: {  'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
            .then(res => {
              let file = res.data;
              console.log(file);
              this.setState({currFile:file});
            })
          }}
        >{item.fileName}</Typography>
        <hr />
          <Typography variant="caption" color="textPrimary"
            style={{ textAlign: "right", display: "inline-block", minWidth: "40px", marginRight:"20px", cursor: "pointer", fontSize: "14px" }}
            onClick={() => { this.downloadFile(item.fileName, item.id) }}
          >download</Typography> 
          <Typography variant="caption" color="error"
            style={{ textAlign: "right", display: "inline-block", minWidth: "40px", marginRight:"20px", cursor: "pointer", fontSize: "14px" }}
            onClick={() => { this.deleteFile(item.fileName, item.id) }}
          >delete</Typography>
    </Paper>
    })
  }
  renderFileContent = () => {
    const {currFile} = this.state;
    if(currFile === undefined) return <Typography variant="h6" color="primary" style={{textAlign:"center"}}>You can choose a plain text file to display and edit here.</Typography> ;
    return (<p style={{ minHeight:"50vh", overflowX:'scroll' }}>{currFile}</p>);
  }
  handleNewFile = (e) => {
    this.setState({ newFile: e.target.files[0] });
  }
  submitFile = () => {
    const { newFile, remark, projectId } = this.state;
    if (newFile === undefined) {
      return;
    }
    if (remark.length === 0) {
      this.setState({message:"Remark Can't Be Empty", messageType:AlertTypes.Error}, () => {
        this.handleSnackbarOpen();
        return;
      });
      return ;
    } 
    const data = new FormData();
    data.append("file", newFile);
    data.append("remark", remark);
    data.append("project", parseInt(projectId));
    axios.post(`${config.API_URL}/api/files/`, data,
      { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        this.getFiles(projectId);
        this.setState({message:"File Uploaded", messageType:AlertTypes.Success, newFile: undefined, showUpload: false}, () => {
          this.handleSnackbarOpen();
        });
      }, (error) => {
        this.setState({message:"Error While Uploading File, Please Try Again", messageType:AlertTypes.Error}, () => {
          this.handleSnackbarOpen();
        });
      })
  }
  downloadFile = (name,id) => {
    axios.get(`${config.API_URL}/api/files/${id}/retrieve_file/`,
      { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        let file = res.data;
        console.log(typeof(file))
          res.data.blob().then(blob => {
            let url = window.URL.createObjectURL(blob);
            let a = document.createElement('a');
            a.href = url;
            a.download = name;
            a.click();
        });
      })
  }
  render() {
    return (
      <Container>
          <UserNavbar
            logout={() => { this.props.history.push(config.Login_Path) }}
            pushProfile={this.goToProfile}
            goHome={() => { this.props.history.push(config.Homepage_Path) }}
            history ={this.props.history}
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
            <Grid item sm={8}>
              <Typography variant="h4" color="primary">{this.state.name /*Project Name*/ }</Typography> 
              <Paper elevation={6} style={{border: "solid 1px blue", padding: "15px", minHeight:"50vh", maxHeight:"75vh", overflowY:"scroll", width: "95%", background: "white", margin: "auto", marginBottom: "10px", marginTop:"40px",whiteSpace:"pre-wrap", textAlign:"left" }} borderColor="primary" border={1} >
              {this.renderFileContent()}
              </Paper>
             
              </Grid>
            <Grid item sm={3}>
              <Typography variant="h6" color="primary">Files</Typography>
              <Box style={{ overflowY: 'scroll' }}>
                <Paper elevation={6} style={{ border: "solid 1px blue", padding: "15px", minHeight: "50vh", width: "90%", background: "white", margin: "auto", marginBottom: "10px", marginTop: "40px", textAlign: "center" }} borderColor="primary" border={1} >
                  {this.renderFiles()}
                </Paper>
                {this.state.showUpload ?
                    <>
                      <Input type="file" onChange={this.handleNewFile}></Input>
                      <TextField
                            type="text"
                            error=""
                            id="standard-error-helper-text"
                            label="Remark"
                            onChange={this.handleRemark}
                            defaultValue=""
                            helperText="20 characters maximum"
                        />
                      {this.state.newFile === undefined ?
                        <></>
                        :
                        <Button color='primary'
                          type='outlined'
                          style={{ width: '40px', fontSize: "8px", border: "solid 1px blue" }}
                          onClick={() => {this.submitFile()}}
                        > Upload File </Button>
                      }
                    </>
                    :
                    <Button variant='contained' color='primary' onClick={() => { this.setState({ showUpload: true }) }} >Upload New File</Button>

                  }
              </Box>
            </Grid>
          </Grid>
          <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
        </Grid>
      </Container>);
  }


}
