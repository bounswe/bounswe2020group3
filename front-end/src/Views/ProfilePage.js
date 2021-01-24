import React, { Component } from "react";
import { Button, Input, styled, Avatar, Box, Grid, Paper, Typography,Accordion,AccordionSummary,AccordionDetails } from '@material-ui/core';
import { Rating } from '@material-ui/lab';
import AlertTypes from "../Common/AlertTypes.json";
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import { getUserId, getPhoto, getRequestHeader, isLoggedIn, getAccessToken } from '../Components/Auth/Authenticate';
import axios from 'axios';
import config from '../config';
import UserNavbar from '../Components/TopBar/UserNavbar';
import Profilebar from '../Components/ProfileBar/Profilebar';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';

const privateGender = "do not want to share";
const titleStyle = {
  textAlign: "left",
  marginTop: "10px"
}
const titleStyleCenter = {
  textAlign: "center",
  marginTop: "10px"
}
const textStyle = {
  border: "solid 1px blue",
  textAlign: "left",
  minHeight: "100px",
  padding: "2px 12px"
}
const SelfContainer = styled(Box)({
  backgroundColor: '#f7f7f5',
  background: "#f9f9eb",
  border: 0,
  borderRadius: 3,
  boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
  color: 'white',
  height: "calc(100vh - 60px)",
  paddingBottom: "60px",
  top: "0",
  bottom: "0",
  left: "0",
  right: "0",
  margin: "auto",
  overflow: "scroll",
  '& .MuiTextField-root': {
    margin: "10px",
    width: "30%",
    minWidth: "250px"
  }
});
const Container = styled(Box)({
  backgroundColor: '#f7f7f5',
  border: 0,
  borderRadius: 3,
  boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
  color: 'white',
  paddingBottom: "60px",
  top: "0",
  bottom: "0",
  left: "0",
  right: "0",
  height: "calc(98vh - 60px)",
  margin: "auto",
  '& .MuiTextField-root': {
    margin: "10px",
    width: "30%",
    minWidth: "250px"
  }
});

export default class ProfilePage extends Component {
  constructor(props) {
    super(props);
    this.SnackbarRef = React.createRef();
    this.state = {
      message: "",
      messageType: "",
      profileId: "",
      name: "",
      middle_name: "",
      projNames: [],
      inviteNames: [],
      invites: [],
      last_name: "",
      email: "",
      img: "",
      bio: "",
      birthday: "",
      expertise: "",
      gender: "",
      interests: "",
      affiliations: "",
      shareBio: false,
      shareGender: false,
      shareAffiliations: false,
      shareBirthday: false,
      self: false,
      selfName: "",
      selfLastName: "",
      projname: "",
      profname: "",
      follow_reqs: [],
      followers: [],
      following: [],
      loop: 0,
      milestones: [],
      allColabInvites: [],
      projects: [],
      notifications: [],
      file: undefined,
      showUpload: false,
      loading: true, // For eradicating glitches due to request delays
      rating: 0,
      currentRating: 0,
      currentUserId: -1,
      comments: [],
      newComment: "",
      showAddNewComment: false,
      ratedBefore : false, 
      myRatingId : -1,
      isCommentable: false,
      isFollowing: false, // ben onu followluyor muyum
      isFollower: false, // o beni mi followluyor
      isFollowReqSent: false,
      isFollowReqReceived: false
    }
  };

  componentDidMount() {
    this.getProfile();
    this.getColabInvites();
    axios.get(`${config.API_URL}${config.User_Path}${getUserId()}/`, getRequestHeader())
      .then(res => {
        this.setState({
          selfName: res.data.profile[0].name + " " + res.data.profile[0].middle_name,
          selfLastName: res.data.profile[0].last_name
        });
      });
    axios.get(`${config.API_URL}/api/notifications/unread/`,
        getRequestHeader())
        .then(res => {
          console.log((res.data))
          this.setState({notifications: res.data})
        });
  };

  distinct(value, index, self) {
    return self.indexOf(value) === index;
  }

  handleLoop = () => {
    var i = this.state.loop;
    i = i + 1;
    this.setState({loop: i}); 
  }

  getProfile = () => {
    var userId = this.props.location.pathname.split('/')[2];
    axios.get(`${config.API_URL}${config.User_Path}${userId}/`, getRequestHeader())
      .then(res => {
        this.setState({ email: res.data.email, self: res.data.id === parseInt(getUserId()), });
        const prof = res.data.profile[0];
        let windowUserId = res.data.id;
        if (windowUserId === parseInt(getUserId()) || res.data.profile[0].is_public || res.data.is_following) {
          this.setState({
            isPublic: prof.is_public || res.data.is_following,
            profileId: prof.id,
            name: prof.name,
            middle_name: prof.middle_name,
            last_name: prof.last_name,
            bio: prof.bio,
            img: prof.photo_url,
            birthday: prof.birthday,
            expertise: prof.expertise,
            gender: prof.gender,
            interests: prof.interests,
            affiliations: prof.affiliations,
            shareBio: prof.share_bio,
            shareGender: prof.share_gender,
            shareAffiliations: prof.share_affiliations,
            shareBirthday: prof.share_birthday,
            self: windowUserId === parseInt(getUserId()),
            loading: false,
            rating: (prof.rating ? parseFloat(prof.rating) : 0),
            currentRating: (prof.my_rating && typeof(prof.my_rating) !== 'string' ? parseFloat(prof.my_rating) : 0),
            currentUserId: windowUserId,
            ratedBefore: (prof.my_rating && typeof(prof.my_rating) !== 'string'),
            myRatingId : (prof.my_rating_id && typeof(prof.my_rating_id) !== 'string' ? prof.my_rating_id : -1),
            isCommentable: prof.is_commentable,
            isFollowing: res.data.is_following, // ben onu followluyor muyum
            isFollower: res.data.is_follower, // o beni mi followluyor
            isFollowReqSent: res.data.is_follow_request_sent,
            isFollowReqReceived: res.data.is_follow_request_received
          }, () => {
            this.getComments();
            axios.get(`${config.API_URL}${config.Follow_url}?from_user__id=${userId}`, getRequestHeader())
              .then(res => {
                const temp_followings = res.data.map(f => f.to_user.profile[0]);
                this.setState({ following: temp_followings });
              });
            axios.get(`${config.API_URL}${config.Follow_url}?to_user__id=${userId}`, getRequestHeader())
              .then(res => {
                const temp_followers = res.data.map(f => f.from_user.profile[0]);
                this.setState({ followers: temp_followers });
              });
            axios.get(`${config.API_URL}${config.Follow_request_url}?req_to_user=${userId}`, getRequestHeader())
              .then(res => {
                const temp_follow_reqs = res.data.map(f => f.req_from_user.profile[0]);
                this.setState({ follow_reqs: temp_follow_reqs });
              });
          });
          if (windowUserId === parseInt(getUserId())) {
            axios.get(`${config.API_URL}${config.OwnMilestoneUrl}`, getRequestHeader())
              .then(res => {
                this.setState({ milestones: res.data.result });
              });
            axios.get(`${config.API_URL}${config.Projectpage_url}?owner__id=${getUserId()}`, getRequestHeader())
              .then(res => {
                this.setState({ projects: res.data });
              });
          }
        }
        else if (prof.is_public === false) {
          this.setState({
            self: false,
            isPublic: prof.is_public || res.data.is_following,
            profileId: prof.id,
            name: prof.name,
            middle_name: prof.middle_name,
            last_name: prof.last_name,
            img: prof.photo_url,
            loading: false,
            rating: (prof.rating ? parseFloat(prof.rating) : 0),
            isCommentable: prof.is_commentable,
            currentUserId: windowUserId,
            isFollowing: res.data.is_following, // ben onu followluyor muyum
            isFollower: res.data.is_follower, // o beni mi followluyor
            isFollowReqSent: res.data.is_follow_request_sent,
            isFollowReqReceived: res.data.is_follow_request_received
          }, () => {
            // this.getComments();
          })
        }

      }, (error) => {
        this.props.history.push("/"); // Forwards from unexisting profiles to homepage
      }

      );
  }
  getComments = () => {
    const { currentUserId } = this.state;
    axios.get(`${config.API_URL}/api/comments/?to_user=${currentUserId}`,
      getRequestHeader())
      .then(res => {
        this.setState({ comments: (res.data ? res.data : []) });
      });
  }
  renderComments = () => {
    const { comments } = this.state;
    return (
      <>
        {comments.length !== 0 ?
          comments.map((item) => {
            let fullName = item.name + " " + (item.middle_name ? item.middle_name + " " : "") + item.last_name + ":";
            return (
              <>
                <Typography variant="caption" color="primary"
                  style={{ textAlign: "left", width: "100%", textTransform: "capitalize", cursor:"pointer"}}
                  onClick={() => {
                    this.props.history.push(`${config.Profille_Page_Path}/${item.from_user}`);
                    window.location.reload(false);
                }}
                >{fullName}</Typography>

                <Paper elevation={6} style={{ textAlign: "center" }}>
                  <Typography
                    variant="caption"
                    color="primary"
                    style={{ textAlign: "left", display: "inline-block", width: "85%" }}
                  >{item.comment}</Typography>
                  {item.from_user === parseInt(getUserId()) ?
                    <Typography variant="caption" color="error"
                      style={{ textAlign: "right", display: "inline-block", width: "10%", cursor: "pointer", fontSize: "10px" }}
                      onClick={() => { this.deleteComment(item.id) }}
                    >delete</Typography>
                    : <></>}

                </Paper>
                <hr />
              </>
            )
          })
          :
          <>
            <Typography variant='h6' color='textPrimary' style={{ textAlign: 'center' }}>No comments found</Typography>
          </>
        }
      </>
    )
  }

  postComment = () => {
    const { currentUserId, newComment } = this.state;

    if (newComment.trim() === "") {
      this.setState({ message: "Comment Can't Be Empty", messageType: AlertTypes.Warning }, () => {
        this.handleSnackbarOpen();
      });
      return;
    }

    let data = { from_user: parseInt(getUserId()), to_user: currentUserId, comment: newComment };
    axios.post(`${config.API_URL}/api/comments/`, data,
      getRequestHeader())
      .then(res => {
        this.setState({ message: "Comment Posted", messageType: AlertTypes.Success, newComment: "", showAddNewComment: false }, () => {
          this.handleSnackbarOpen();
          this.getComments();
        })
      }, (error) => {
        this.setState({ message: "Error while posting comment, please try again.", messageType: AlertTypes.Error }, () => {
          this.handleSnackbarOpen();
        })
      })
  }
  deleteComment = (id) => {
    axios.delete(`${config.API_URL}/api/comments/`, { id: id },
      getRequestHeader())
      .then(res => {
        this.setState({ message: "Comment Deleted", messageType: AlertTypes.Success }, () => {
          this.handleSnackbarOpen();
          this.getComments();
        })
      }, (error) => {
        this.setState({ message: "Error while deleting comment, please try again.", messageType: AlertTypes.Error }, () => {
          this.handleSnackbarOpen();
        })
      })
  }



  postRating = () => {
    const { currentUserId, currentRating, ratedBefore, myRatingId, rating } = this.state;
    let ratingm = { rating: currentRating, from_user: getUserId(), to_user: currentUserId };

    console.log(currentRating , ratedBefore, myRatingId, rating)
    if (!ratedBefore) {
      axios.post(`${config.API_URL}/api/ratings/`, ratingm,
        getRequestHeader())
        .then(res => {
          this.getProfile();
        }, (error) => {
          this.setState({ messageType: AlertTypes.Error, message: "Error while rating please try again later." }, () => {
            this.handleSnackbarOpen();
          })
        });
    } else {
      axios.patch(`${config.API_URL}/api/ratings/${myRatingId}/`, {rating: currentRating},
        getRequestHeader())
        .then(res => {
          this.setState({ messageType: AlertTypes.Success, message: "Rating Updated." }, () => {
            this.handleSnackbarOpen();
          })
          this.getProfile();
        }, (error) => {
          this.setState({ messageType: AlertTypes.Error, message: "Rating update failed. Please try again." }, () => {
            this.handleSnackbarOpen();
          });
        });
    }
  }

  handleRatingChange = (e) => {
    this.setState({ currentRating: e.target.value * 2 }, () => {
      this.postRating();
    });
  }
  handleCommentChange = (e) => {
    this.setState({ newComment: e.target.value });
  }

  handleSnackbarOpen = () => {
    this.SnackbarRef.current.turnOnSnackbar();
  };
  goToLogin = () => {
    this.props.history.push("/login");
  };
  goToEditProfilePage = () => {
    this.props.history.push("/edit-profile");
  };
  goToProjectCreation = () => {
    this.props.history.push(config.Create_Project_Path);
  };
  renderProjects() {
    const { projects } = this.state;
    return (
      <Box style={{ overflowY: "scroll", maxHeight: "500px", paddingTop: "10px", paddingBottom: "10px" }}>

        {projects.length !== 0
          ?
          projects.map((item) => {
            return (
              <Paper elevation={6}
                style={{
                  padding: "15px", maxHeight: "160px", width: "80%",
                  background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
                }}
                borderColor="primary" border={1}>
                <Typography variant="h6" color="primary"
                  style={{ cursor: "pointer", width: "50%", textAlign: "left" }}
                  onClick={() => { this.props.history.push("/project/" + item.id); }}
                >{item.name}</Typography>
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
            <Typography variant="h6" color="textPrimary" style={{ "textAlign": 'center' }}>No Projects Found</Typography>
          </Paper>
        }
      </Box>)
  };
  renderMilestones() {
    const { milestones } = this.state;
    return (
      <Box style={{ overflowY: "scroll", maxHeight: "500px", paddingTop: "10px", paddingBottom: "10px" }}>

        {milestones.length !== 0
          ?
          milestones.map((item) => {
            return (
              <Paper elevation={6}
                style={{
                  padding: "15px", maxHeight: "160px", width: "80%",
                  background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"
                }}
                borderColor="primary" border={1}>
                <Typography variant="h6" color="primary"
                  style={{ cursor: "pointer", width: "50%", textAlign: "left", display: "inline-block" }}
                  onClick={() => { this.props.history.push(`${config.Projectpage_Path}/${item.project}`) }}
                >{item.project_name}</Typography>
                <Typography variant="h6" color="primary"
                  style={{ cursor: "pointer", width: "50%", textAlign: "right", display: "inline-block" }}
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
      </Box>)

  };
  renderMidRightColumn() {
    return (
      <Grid item sm={6} >
        <Typography variant="h5" color="primary" style={titleStyle}>Expertise</Typography>
        <Paper elevation={6} style={textStyle}>
          <p>{this.state.expertise}</p>
        </Paper>
        <Typography variant="h5" color="primary" style={titleStyle}>Interests</Typography>
        <Paper elevation={6} style={textStyle}>
          <p>{this.state.interests}</p>
        </Paper>
        {(this.showAffiliations() ?
          <>
            <Typography variant="h5" color="primary" style={titleStyle}>Affiliations</Typography>
            <Paper elevation={6} style={textStyle}>
              <p>{this.state.affiliations === "" ? "None" : this.state.affiliations}</p>
            </Paper>
          </>
          :
          <></>
        )}
      </Grid>
    );
  }
  renderMidLeftColumn() {
    return (<Grid item sm={6} >

      {this.showBio()
        ? <>
          <Typography variant="h5" color="primary" style={titleStyle}>Biography</Typography>
          <Paper elevation={6} style={textStyle}>
            <p>{this.state.bio}</p>
          </Paper>
        </>
        :
        <><Typography variant="h5" color="primary" style={titleStyle}>Biography</Typography>
          <Paper elevation={6} style={textStyle}>
            <p>{this.state.bio}</p>
          </Paper></>
      }

      <Typography variant="h5" color="primary" style={titleStyle}>Contact Info</Typography>
      <Paper elevation={6} style={textStyle}>
        <p>{"Email : " + this.state.email}</p>
      </Paper>
      {(this.showPersonalInfo() ?
        <>
          <Typography variant="h5" color="primary" style={titleStyle}>Personal Information</Typography>
          <Paper elevation={6} style={textStyle}>
            <p>{"Birthday : " + this.state.birthday} <br />
              {(this.state.gender !== privateGender ? "Gender : " + this.state.gender : "")}</p>
          </Paper>
        </>
        :
        <></>
      )}
    </Grid>
    );
  }
  renderAddComment() {
    if(!this.state.isPublic || !this.state.isCommentable) return (<></>);

    return (
      <>
        {this.state.showAddNewComment ?
          <>
            <Input
              multiline={true}
              value={this.state.newComment}
              placeholder="Your Comment"
              style={{ width: "80%", marginBottom: "10px" }}
              onChange={(e) => { this.handleCommentChange(e) }}
            />
            <br />
            <Button variant="outlined" color="primary" onClick={() => { this.postComment() }}>Post</Button>
          </>
          :
          <>
            {isLoggedIn() && this.state.isCommentable ?
              <Button variant="outlined" color="primary" onClick={() => { this.setState({ showAddNewComment: true }) }}>Comment</Button>
              :
              <></>
            }
          </>
        }
      </>
    )
  }

  renderGraph() {
    return (
      <>{this.state.self ?

        <>
          <Button variant="outlined" color="primary" style={{ width:"50", fontSize:"10px", marginBottom:"20px" }} onClick={this.goToEditProfilePage}>Edit Profile</Button>
<br/>
          <Button variant="outlined" color="primary" style={{ width: "50", fontSize: '10px', marginBottom: "20px" }} onClick={() => {
            this.deletePhoto(this.getUserPhoto(this.state.profileId))
            window.location.reload(false);
          }}> Delete Profile Picture </Button>
        </>
        :
        <></>
      }
        {!this.state.self && this.state.isPublic ?
          <div style={{ textAlign: 'left', width: "90%", paddingLeft: "10%" }}>
            {isLoggedIn() && (this.state.isCommentable || this.state.isFollowing) ?
              <>
                <Typography component="span" style={{ textAlign: "left", width: '50%', marginBottom: "5px" }} color="primary">{"Your Rating :     "}</Typography>
                <Rating
                  defaultValue={0}
                  precision={0.5}
                  name="pristine"
                  size="small"
                  style={{ top: "3px", paddingLeft: "13px" }}
                  value={this.state.currentRating / 2.0}
                  onChange={(e) => { this.handleRatingChange(e) }}
                />
              </>
              :
              <></>
            }
          
          </div>
          :
          <></>
        }
        {this.state.isPublic || this.state.self || this.state.isFollowing || true ? 
        <div style={{ textAlign: 'left', width: "90%", paddingLeft: "10%" }}>
          <Typography component="span" style={{ textAlign: "left", width: '50%', marginBottom: "5px" }} color="primary">Overall Rating :</Typography>
          <Rating
            defaultValue={0}
            precision={0.5}
            name="pristine"
            size="small"
            style={{ top: "3px", paddingRight: "5px" }}
            value={this.state.rating / 2.0}
            disabled
          />
          <Typography component="span" style={{ textAlign: "left", width: '50%', marginBottom: "5px" }} color="primary">{this.state.rating.toPrecision(2)}</Typography>

        </div>
        :
        <></>
        }
        {this.state.self ? 
        <>
         <Accordion>
                    <AccordionSummary disabled={!this.state.follow_reqs.length>0} expandIcon={<ExpandMoreIcon />}>
                        <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}>
                            <b>{this.state.follow_reqs?this.state.follow_reqs.length:0}</b> following request
                        </Typography>
                    </AccordionSummary>
                    <AccordionDetails>
                        <Box style={{ overflowY: "scroll", minWidth: "100%",maxHeight: "200px", paddingTop: "10px", paddingBottom: "10px" }}>
                            {this.state.follow_reqs.map(req =>{
                                return (<Paper style={{
                                    padding: "15px", maxHeight: "160px", width: "80%", cursor:"pointer",
                                    background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"}} borderColor="primary" border={1} alignItems="flex-start">
                                    <Typography onClick={()=>{  this.props.history.push("/profile/"+(req.owner_id)); window.location.reload(false);}}>{req.name+" "+req.last_name}</Typography>
                                    <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={() => this.acceptFollowRequest(req.owner_id)}>Approve</Button>
                                    <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={() => this.rejectFollowRequest(req.owner_id)}>Reject</Button>
                                </Paper>)
                            })}
                        </Box>
                    </AccordionDetails>
                </Accordion>
                <Accordion>
                    <AccordionSummary disabled={!this.state.following.length>0} expandIcon={<ExpandMoreIcon />}>
                        <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}>
                            <b>{this.state.following?this.state.following.length:0}</b> following
                        </Typography>
                    </AccordionSummary>
                    <AccordionDetails>
                        <Box style={{ overflowY: "scroll", minWidth: "100%",maxHeight: "200px", paddingTop: "10px", paddingBottom: "10px" }}>
                            {this.state.following.map(req =>{
                                return (<Paper style={{
                                    padding: "15px", maxHeight: "160px", width: "80%", cursor:"pointer",
                                    background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"}} borderColor="primary" border={1} alignItems="flex-start">
                                    <Typography onClick={()=>{  this.props.history.push("/profile/"+(req.owner_id)); window.location.reload(false);}}>{req.name+" "+req.last_name}</Typography>
                                </Paper>)
                            })}
                        </Box>
                    </AccordionDetails>
                </Accordion>
                <Accordion>
                    <AccordionSummary disabled={!this.state.followers.length>0} expandIcon={<ExpandMoreIcon />}>
                        <Typography variant="h6" color="primary" style={{cursor:"pointer", width:"100%", textAlign:"left"}}>
                            <b>{this.state.followers?this.state.followers.length:0}</b> follower
                        </Typography>
                    </AccordionSummary>
                    <AccordionDetails>
                        <Box style={{ overflowY: "scroll", minWidth: "100%",maxHeight: "200px", paddingTop: "10px", paddingBottom: "10px" }}>
                            {this.state.followers.map(req =>{
                                return (<Paper style={{
                                    padding: "15px", maxHeight: "160px", width: "80%", cursor:"pointer",
                                    background: "white", margin: "auto", marginBottom: "10px", textAlign: "left", overflow: "clip"}} borderColor="primary" border={1} alignItems="flex-start">
                                    <Typography onClick={()=>{this.props.history.push("/profile/"+(req.owner_id)); window.location.reload(false);}}>{req.name+" "+req.last_name}</Typography>
                                </Paper>)
                            })}
                        </Box>
                    </AccordionDetails>
                </Accordion>
            </>
                
              :
              <></>
          }
        {/* {this.state.isPublic || this.state.self ? 
          <> */}
        <Typography variant='h6' color='primary' style={{ margin: "10px 0" }}>Comments</Typography>
        <Paper elevation={6}
          style={{
            padding: "15px",
            width: "80%",
            background: "white",
            margin: "auto",
            marginBottom: "10px",
            textAlign: 'left',
            maxHeight: "500px",
            overflowY: "scroll"
          }}
          borderColor="primary" border={1}>
          {this.renderComments()}
        </Paper>
        {/* </>
         :
         <></>
         } */}
      </>);
  };
  handleProfilePictureChange = (e) => {
    this.setState({ file: e.target.files[0] });
  }
  handleShowUpload = (e) => {
    this.setState({ showUpload: true });
  }
  submitPhoto = () => {
    const { file } = this.state;
    console.log(file);
    if (file === undefined) {
      return;
    }
    const data = new FormData();
    data.append("profile_picture", file);
    axios.put(`${config.API_URL}/api/profile_picture/${this.state.profileId}/`, data,
      getRequestHeader())
      .then(res => {
        window.location.reload(false);
      })
  }

  getColabInvites(){
    axios.get(`${config.API_URL}/api/collaboration_invites/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        let colabInvites = res.data;
        let invites = [];
        var len = colabInvites.length;
        console.log(colabInvites);
        for(var i=0; i<len; i++){
          var id = colabInvites[i].to_user;
          var myId = getUserId();
          console.log(myId);
          // eslint-disable-next-line
          if(id == myId){
            invites.push(colabInvites[i]);
          }
        }
        var uniInvs = invites.filter(this.distinct);
        console.log(uniInvs);
        this.setState({ allColabInvites: uniInvs });

        // ___________________________________________

      const{ allColabInvites } = this.state;
      var ids = [];
      for(var k=0; k<allColabInvites.length; k++){
        var idTriple = [allColabInvites[k].id, allColabInvites[k].from_user, allColabInvites[k].to_project];
        ids.push(idTriple);
      }

      // ___________________________________________

      var projnames = [];
      var promises2 = [];
      for(var m=0; m<ids.length; m++){
        promises2.push(
          axios.get(`${config.API_URL}/api/projects/${ids[m][2]}/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
          .then(res => {
            let name = res.data.name;
            projnames.push(name);
        }));
      }
      Promise.all(promises2).then(() => {
        console.log(projnames);
        this.setState({projNames: projnames});
      });

      // ___________________________________________

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
          this.setState({inviteNames: usernames});
        });
        var invDatas = [];
        for(var n=0; n<ids.length; n++){
          var reqData = [this.state.inviteNames[n], this.state.projNames[n], ids[n][0]];
          invDatas.push(reqData);
        }
        this.setState({invites: invDatas});
      });
  };

  deleteColabInvite = (myId) => {
    axios.delete(`${config.API_URL}/api/collaboration_invites/${myId}/`, { id: myId }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
            this.getProfile(this.state.profileId);
        }); 
  }

  acceptColabInvite = (myId) => {
    axios.post(`${config.API_URL}/api/collaboration_invites/${myId}/accept_collaboration_invite/`, { id: myId }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          this.deleteColabInvite(myId);
          window.location.reload(true);
        }); 
  };

  rejectColabInvite = (myId) => {
    axios.post(`${config.API_URL}/api/collaboration_invites/${myId}/reject_collaboration/`, { id: myId }, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(res => {
          this.deleteColabInvite(myId);
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

  getProjectNameById(id){
    axios.get(`${config.API_URL}/api/projects/${id}/`, { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
      .then(res => {
        let name = res.data.name;
        
        this.setState({projname : name});
      });
  }

  renderColabInvites = () => {
    const {invites} = this.state;
    if(this.state.loop < 3){
      this.getColabInvites();
      this.handleLoop();
    }

    if (invites.length === 0) return (  <Typography variant='h6' color="textPrimary">No Collaboration Invites</Typography>)
    else return invites.map((item) => {
      return (<>
        <Typography variant="h5" color="primary" style={{ width: "100%", textAlign: "left" }}>{item[0]}</Typography>
        <Typography variant="h6" color="primary" style={{ width: "100%", textAlign: "left" }}>{item[1]}</Typography>
        <Button variant="contained" color="primary" style={{ marginLeft:"12px" }} onClick={() => this.acceptColabInvite(item[2])} > Accept </Button>
        <Button variant="contained" color="primary" style={{ marginLeft:"12px" }} onClick={() => this.rejectColabInvite(item[2])} > Reject </Button>
      </>)
    });
  };

  renderInvites(){
    return (
      <Grid item sm={12} style={{ maxHeight: "30vh", minHeight: "10vh", overflowY: "scroll", margin: "5px 0" }}>
        
        <Paper elevation={6} style={{border: "solid 1px blue", padding: "15px", width: "90%", background: "white", margin: "auto", marginBottom: "10px" }} borderColor="primary" border={1}>
          {this.renderColabInvites()}
        </Paper>
      </Grid>
    )
  };

  renderSelfProfile() {
    return (<SelfContainer>
      <UserNavbar
        logout={() => { this.props.history.push(config.Login_Path) }}
        pushProfile={() => { this.props.history.push("/profile/" + getUserId()) }}
        goHome={() => { this.props.history.push(config.Homepage_Path) }}
        history ={this.props.history}
        notifications = {this.state.notifications}
      />

      <Grid container direction="row" justify="center" alignItems="center" >
        <Grid container spacing={2} direction="row" justify="space-evenly" alignItems="baseline">

          <Grid item sm={3}>
            {this.state.self ?
              <>
                <Typography variant="h5" color="primary" style={titleStyleCenter}>Upcoming Milestones</Typography>
                {this.renderMilestones()}
                <Typography variant="h5" color="primary" style={titleStyleCenter}>Projects</Typography>
                {this.renderProjects()}
                <Typography variant="h5" color="primary" style={titleStyleCenter}>Collaboration Invites</Typography>
                {this.renderInvites()}
              </>
              :
              <></>
            }
          </Grid>

          <Grid container spacing={2} item sm={6}>
            <Grid item sm={12} >
              <Avatar src={this.getUserPhoto(this.state.profileId)} style={{ width: "150px", height: '150px', margin: 'auto', marginTop: '10px' }} />
              {this.state.showUpload ?
                <><Input type="file" onChange={this.handleProfilePictureChange}></Input>
                  {this.state.file !== undefined ?
                    <Button color='primary'
                      type='outlined'
                      style={{ width: '40px', fontSize: "8px" }}
                      onClick={this.submitPhoto}
                    > Save Picture </Button>
                    :
                    <></>
                  }
                </>
                :
                <Button color='primary'
                  type='outlined'
                  style={{ width: '40px', fontSize: "8px" }}
                  onClick={this.handleShowUpload}
                >Change Picture</Button>
              }
              <Paper elevation={6} style={{ border: "solid 1px blue", padding: "10px", minHeight: '30px', maxWidth: "300px", margin: '15px auto 20px auto' }}>
                <Typography style={{ textTransform: "capitalize " }}>{this.state.name + " " + this.state.middle_name} <br />
                  {this.state.last_name.toUpperCase()}</Typography>
              </Paper>
            </Grid>

            {(this.state.self || this.state.isPublic) ? this.renderMidLeftColumn() : <></>}
            {(this.state.self || this.state.isPublic) ? this.renderMidRightColumn() : <></>}

          </Grid>
          <Grid item sm={3}>
            {/*  SAĞDAKİ RELEVANT ŞEYLER BURAYA GELECEK  */}
            {this.renderGraph()}

          </Grid>
          
        </Grid>
      </Grid>
      <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpen} type={this.state.messageType} message={this.state.message} />
    </SelfContainer>);
  }
  renderOtherProfile() {
    return (<Container style={{backgroundColor: '#f7f7f5'}}>
      <UserNavbar
        logout={() => { this.props.history.push(config.Login_Path) }}
        pushProfile={() => {
          this.props.history.push("/profile/" + getUserId());
          window.location.reload(false);
        }}
        goHome={() => { this.props.history.push(config.Homepage_Path) }}
        history ={this.props.history}
        notifications = {this.state.notifications}
      />
      <Box>
        {!this.state.self && !this.state.loading ?  // So that re-render doesn't cause any glitch-like graphics.
          <Profilebar
            name={this.state.selfName}
            lastName={this.state.selfLastName}
            photoUrl={getPhoto()}
            goToProjectCreation={this.goToProjectCreation}
            goToEventCreation={() => {this.props.history.push(config.Event_Creation_Path);}}
            goToProfile={() => {
              this.props.history.push("/profile/" + getUserId());
              window.location.reload(false);
            }}
          />
          :
          <></>
        }
        <Grid container direction="row" justify="center" alignItems="center" >
          <Grid container spacing={2} direction="row" justify="space-evenly" alignItems="baseline">

            <Grid item sm={2}>
              {/* Burasi bos kalacak */}
            </Grid>

            <Grid container spacing={2} item sm={7}>
              <Grid item sm={12} >
                <Avatar src={this.getUserPhoto(this.state.profileId)} style={{ width: "150px", height: '150px', margin: 'auto', marginTop: '10px' }} />
                <Paper elevation={6} style={{ border: "solid 1px blue", padding: "10px", minHeight: '30px', maxWidth: "300px", margin: '15px auto 20px auto' }}>
                  <Typography style={{ textTransform: "capitalize" }}>{this.state.name + " " + this.state.middle_name} <br />
                    {this.state.last_name.toUpperCase()}</Typography>
                </Paper>
                {
                  this.state.isPublic ?
                    <></>
                    :
                    <Typography variant="h5" color="error"> ( Private ) </Typography>
                }
                {isLoggedIn() ?
                  <Grid>
                    {!this.state.isFollowing ?
                      <>

                        {!this.state.isPublic ?

                          <>
                            {!this.state.isFollowReqSent ?

                              <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={() => this.renderSentFollowRequest()}>Send Follow Request</Button>

                              :

                              <Button variant="contained" color="primary" style={{ marginTop: "10px" }} >Waiting for Answer</Button>

                            }

                          </>

                          :
                          <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={() => this.renderFollow()}>Follow</Button>
                        }
                      </>
                      :
                      <Button variant="contained" color="primary" style={{ marginTop: "10px" }} onClick={() => this.renderUnfollow()}>Unfollow</Button>
                    }


                  </Grid>
                  :
                  <></>
                }
              </Grid>

              {(this.state.self || this.state.isPublic) ? this.renderMidLeftColumn() : <></>}
              {(this.state.self || this.state.isPublic) ? this.renderMidRightColumn() : <></>}

            </Grid>
            
            <Grid item sm={3}>
              {this.renderGraph()}
              {this.renderAddComment()}
            </Grid>
          </Grid>
        </Grid>
        <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpen} type={this.state.messageType} message={this.state.message} />
      </Box>
    </Container>);
  }
  render() {
    if (this.state.self)
      return (<>{this.renderSelfProfile()}</>);
    else {
      return (<>{this.renderOtherProfile()}</>)
    }

  }

  getUserPhoto = (profileId) => {
    return `${config.API_URL}/api/profile_picture/${profileId}/`;
  }

  deletePhoto = (url) => {
    axios.delete(url, getRequestHeader());
  }

  showPersonalInfo = () => {
    return this.showGender() && this.showAge();
  }

  showGender = () => {
    const { shareGender } = this.state;
    if (shareGender)
      return true;
    else
      return false;
  }
  showAge = () => {
    const { shareBirthday } = this.state;
    if (shareBirthday)
      return true;
    else
      return false;
  }
  showBio = () => {
    const { shareBio } = this.state;
    if (shareBio)
      return true;
    else
      return false;
  }
  showAffiliations = () => {
    const { shareAffiliations } = this.state;
    if (shareAffiliations)
      return true;
    else
      return false;
  }
  acceptFollowRequest = (req_id) => {

    var userId = this.props.location.pathname.split('/')[2];
    axios.get(`${config.API_URL}${config.Follow_request_url}`, getRequestHeader())
    .then(resId=>{
      var unfId = 0
      resId.data.forEach((item) => {

        if(item.req_from_user.id === req_id && "" + item.req_to_user.id === "" +   userId){
          unfId = item.id
        }
        
      })

      axios.get(`${config.API_URL}${config.Follow_request_url}${unfId}/`, getRequestHeader())
      .then(resp=>{

        //console.log(resp.data)
        //console.log(resp.data.id)

        const fromUser = resp.data.req_from_user
        const toUser = resp.data.req_to_user

        var newId = unfId + ""

        //console.log(newId + "              newId")

        const action = {
          req_from_user: {
            username: fromUser.username
          },
          req_to_user: {
            username: toUser.username
          }
        }

        axios.post(`${config.API_URL}${config.Follow_request_url}${newId}${config.Accept_Path}`, action , getRequestHeader())
        .then(resAcc=>{ 
          window.location.reload(false);
        });
        
      });
    });
}

rejectFollowRequest = (req_id) => {

    var userId = this.props.location.pathname.split('/')[2];
    axios.get(`${config.API_URL}${config.Follow_request_url}`, getRequestHeader())
    .then(resId=>{

      //console.log(resId.data)
      //console.log(userId)
      //console.log(req_id)

      
      var unfId = 0
      resId.data.forEach((item) => {

        if(item.req_from_user.id === req_id && "" + item.req_to_user.id === "" +   userId){
          unfId = item.id
        }
        
      })

      axios.get(`${config.API_URL}${config.Follow_request_url}${unfId}/`, getRequestHeader())
      .then(resp=>{

        //console.log(resp.data)
        //console.log(resp.data.id)

        const fromUser = resp.data.req_from_user
        const toUser = resp.data.req_to_user

        var newId = unfId + ""

        //console.log(newId + "              newId")

        const action = {
          req_from_user: {
            username: fromUser.username
          },
          req_to_user: {
            username: toUser.username
          }
        }

        axios.post(`${config.API_URL}${config.Follow_request_url}${newId}${config.Reject_Path}`, action , getRequestHeader())
        .then(resAcc=>{ 
            window.location.reload(false);
        });
      
      });
  });   
}

  renderFollow() {

  axios.get(`${config.API_URL}${config.User_Path}${getUserId()}/`, getRequestHeader())
    .then(resUser => {
      var userId = this.props.location.pathname.split('/')[2];
      axios.get(`${config.API_URL}${config.User_Path}${userId}/`, getRequestHeader())
        .then(res => {
          const profileState = res.data;
          const follow_create = {
            to_user: profileState.id,
            created: "datatime-local"
          }
          axios.post(`${config.API_URL}${config.Follow_url}`, follow_create, getRequestHeader())
            .then(resCreate => {
              window.location.reload(false);
            });
        });
    });
}

  renderUnfollow() {
    var userId = this.props.location.pathname.split('/')[2];
    axios.get(`${config.API_URL}${config.Follow_url}?to_user__id=${userId}`, getRequestHeader())
      .then(resId => {

        let unfId = 0
        resId.data.forEach((item) => {

          if ("" + item.from_user.id === getUserId()) {
            unfId = item.id
          }

        })

        axios.delete(`${config.API_URL}${config.Follow_url}${unfId}/`, getRequestHeader())
          .then(resDelete => {
            window.location.reload(false);
          });
      });

  }

  renderSentFollowRequest() {

    axios.get(`${config.API_URL}${config.User_Path}${getUserId()}/`, getRequestHeader())
      .then(resUser => {

        // eslint-disable-next-line
        const userState = resUser.data;
        //console.log(userState)
        //console.log(userState.profile[0])

        var userId = this.props.location.pathname.split('/')[2];
        axios.get(`${config.API_URL}${config.User_Path}${userId}/`, getRequestHeader())
          .then(res => {

            const profileState = res.data;

            //console.log(profileState.id)
            //console.log("reqId")
            const followReq_create = {
              req_to_user: profileState.id,
              created: "datatime-local"
            }

            //console.log(followReq_create)

            axios.post(`${config.API_URL}${config.Follow_request_url}`, followReq_create, getRequestHeader())
              .then(resCreate => {
                window.location.reload(false);
              });

          });
      });
  }

  renderWithdrawFollowRequest() {
    var userId = this.props.location.pathname.split('/')[2];
    axios.get(`${config.API_URL}${config.Follow_request_url}`, getRequestHeader())
      .then(resId => {

        console.log(resId.data)

        var unfId = 0

        resId.data.forEach((item) => {

          if ("" + item.req_from_user.id === getUserId() && "" + item.req_to_user.id === userId) {
            unfId = item.id

          }
            
    })

    var newId = parseInt(unfId + "")

    axios.delete(`${config.API_URL}${config.Follow_request_url}${newId}/`, getRequestHeader())
    .then(resDelete => {

    });            
  });
}
}
