import React, {useState} from 'react';
import { fade, makeStyles } from '@material-ui/core/styles';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import IconButton from '@material-ui/core/IconButton';
import Typography from '@material-ui/core/Typography';
import InputBase from '@material-ui/core/InputBase';
import Badge from '@material-ui/core/Badge';
import MenuItem from '@material-ui/core/MenuItem';
import Menu from '@material-ui/core/Menu';
import SearchIcon from '@material-ui/icons/Search';
import AccountCircle from '@material-ui/icons/AccountCircle';
import MailIcon from '@material-ui/icons/Mail';
import NotificationsIcon from '@material-ui/icons/Notifications';
import { Button} from '@material-ui/core';
import {logout, getPhoto, getAccessToken} from "../Auth/Authenticate";
import Avatar from '@material-ui/core/Avatar';
import logo from '../../navbarlogo.png';
import axios from "axios";
import config from "../../config";

const useStyles = makeStyles((theme) => ({
  grow: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  title: {
    display: 'none',
    [theme.breakpoints.up('sm')]: {
      display: 'block',
    },
  },
  search: {
    position: 'relative',
    borderRadius: theme.shape.borderRadius,
    backgroundColor: fade(theme.palette.common.white, 0.15),
    '&:hover': {
      backgroundColor: fade(theme.palette.common.white, 0.25),
    },
    marginRight: theme.spacing(2),
    marginLeft: 0,
    width: '100%',
    [theme.breakpoints.up('sm')]: {
      marginLeft: theme.spacing(3),
      width: 'auto',
    },
  },
  searchIcon: {
    padding: theme.spacing(0, 2),
    height: '100%',
    position: 'absolute',
    pointerEvents: 'none',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  inputRoot: {
    color: 'inherit',
  },
  inputInput: {
    padding: theme.spacing(1, 1, 1, 0),
    // vertical padding + font size from searchIcon
    paddingLeft: `calc(1em + ${theme.spacing(4)}px)`,
    transition: theme.transitions.create('width'),
    width: '100%',
    [theme.breakpoints.up('md')]: {
      width: '20ch',
    },
  },
  sectionDesktop: {
    display: 'none',
    [theme.breakpoints.up('md')]: {
      display: 'flex',
    },
  },
  sectionMobile: {
    display: 'flex',
    [theme.breakpoints.up('md')]: {
      display: 'none',
    },
  },
}));

export default function UserNavbar(props) {
  const photoUrl = getPhoto();
  const classes = useStyles();
  const [anchorEl, setAnchorEl] = React.useState(null);
  const [mobileMoreAnchorEl, setMobileMoreAnchorEl] = React.useState(null);

  const isMenuOpen = Boolean(anchorEl);
  const isMobileMenuOpen = Boolean(mobileMoreAnchorEl);

  const handleProfileMenuOpen = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleMobileMenuClose = () => {
    setMobileMoreAnchorEl(null);
  };

  const handleMenuClose = () => {
    setAnchorEl(null);
    handleMobileMenuClose();
  };

  const handleNotificationClick = (link, id) => {
    console.log(link)
    const notification_object = {
      id: id
    }
    axios.post(`${config.API_URL}/api/notifications/${id}/mark_as_read/`, notification_object,
        { headers: { 'Content-Type': 'Application/json', 'Authorization': `Token ${getAccessToken()}` } })
        .then(resAcc=>{
          console.log(resAcc)
          window.location.reload(false);
        });
    props.history.push(link);
  }

  const [search, setSearch] = useState('')
  const handleSearchEdit = () => {
    if (search.length>1){
      props.history.push("/search/" + search);
    }
  };

  const menuId = 'primary-search-account-menu';

  const renderMenu = () => {
    return (<Menu
        anchorEl={anchorEl}
        anchorOrigin={{vertical: 'top', horizontal: 'right'}}
        id={menuId}
        keepMounted
        transformOrigin={{vertical: 'top', horizontal: 'right'}}
        open={isMenuOpen}
        onClose={handleMenuClose}
    >
        {renderNotifications()}
    </Menu>)

  }

  const mobileMenuId = 'primary-search-account-menu-mobile';
  const renderMobileMenu = (
      <Menu
          anchorEl={mobileMoreAnchorEl}
          anchorOrigin={{ vertical: 'top', horizontal: 'right' }}
          id={mobileMenuId}
          keepMounted
          transformOrigin={{ vertical: 'top', horizontal: 'right' }}
          open={isMobileMenuOpen}
          onClose={handleMobileMenuClose}
      >
        <MenuItem>
          <IconButton aria-label="show 4 new mails" color="inherit">
            <Badge badgeContent={4} color="secondary">
              <MailIcon />
            </Badge>
          </IconButton>
          <p>Messages</p>
        </MenuItem>
        <MenuItem>
          <IconButton aria-label="show 11 new notifications" color="inherit">
            <Badge badgeContent={11} color="secondary">
              <NotificationsIcon />
            </Badge>
          </IconButton>
          <p>Notifications</p>
        </MenuItem>
        <MenuItem onClick={handleProfileMenuOpen}>
          <IconButton
              aria-label="account of current user"
              aria-controls="primary-search-account-menu"
              aria-haspopup="true"
              color="inherit"
          >
            <AccountCircle />
          </IconButton>
          <p>Profile</p>
        </MenuItem>
      </Menu>
  );

  const renderNotifications = () => {
    const notifications = JSON.parse(JSON.stringify(props.notifications));
    if (notifications.length < 1) {
      return (
          <MenuItem onClick={() => handleMenuClose}>You don't have any new notifications.</MenuItem>
      )
    }
    return notifications.map((item) => {
      const type = item.description;
      if (type === "Project") {
        const project = item.project;
        const id = project.id;
        const link = "/project/" + id;
        const str = item.actor.username + " " + item.verb + ".";
        return (
            <MenuItem onClick={() => handleNotificationClick(link, item.id)}>{str}</MenuItem>
        )
      }
      else if (type === "Milestone") {
        const milestone = item.target;
        const id = milestone.project;
        const link = "/project/" + id;
        const str = item.actor.username + " " + item.verb + ".";
        return (
            <MenuItem onClick={() => handleNotificationClick(link, item.id)}>{str}</MenuItem>
        )
      }
      else if (type === "Follow Request") {
        const link = "/profile/" + item.actor.id;
        const str = item.actor.username + " " + item.verb;
        return (
            <MenuItem onClick={() => handleNotificationClick(link, item.id)}>{str}</MenuItem>
        )
      }
      else if (type === "Rating") {
        const link = "/profile/" + item.actor.id;
        const str = item.actor.username + " " + item.verb+ ".";
        return (
            <MenuItem onClick={() => handleNotificationClick(link, item.id)}>{str}</MenuItem>
        )
      }
      else if (type === "Follow") {
        const link = "/profile/" + item.actor.id;
        const str = item.actor.username + " " + item.verb;
        return (
            <MenuItem onClick={() => handleNotificationClick(link, item.id)}>{str}</MenuItem>
        )
      }
      else {
        return (
            <MenuItem onClick={() => handleMenuClose}>Notification</MenuItem>
        )
      }
    }
    )
  };

  return (
      <div className={classes.grow}>
        <AppBar position="static">
          <Toolbar>
            <Typography className={classes.title} style={{cursor:"pointer"}} variant="h6" noWrap onClick={() => {props.goHome()}}>
              PaperLayer
            </Typography>
            <img src={logo} style={{height:"50px", cursor:"pointer"}} alt="logo" onClick={() => {props.goHome()}} />
            <div className={classes.search}>
              <div className={classes.searchIcon}>
                <SearchIcon />
              </div>
              <InputBase
                  type="search"
                  placeholder="Search…"
                  classes={{
                    root: classes.inputRoot,
                    input: classes.inputInput,
                  }}
                  onChange={event => setSearch(event.target.value)}
                  onClick = {()=>{if(search.length>1){
                    handleSearchEdit()
                    window.location.reload(false);
                  }}}
                  inputProps={{ 'aria-label': 'search' }}
              />
              <IconButton type="submit" className={classes.iconButton} aria-label="search"  >
                <SearchIcon onClick = {() =>{
                  if(search.length>1){
                    handleSearchEdit();
                    setSearch('');
                    window.location.reload(false);}}}/>

              </IconButton>

            </div>
            <div className={classes.grow} />
            <Avatar src={photoUrl} style={{marginRight:"10px", cursor:"pointer"}} onClick={() => {
              props.pushProfile()
            }} />

            <div className={classes.sectionDesktop}>
              {
            <IconButton aria-label="show 17 new notifications" color="inherit" onClick={handleProfileMenuOpen}>
              <Badge badgeContent={props.notifications.length} color="secondary">
                <NotificationsIcon />
              </Badge>
            </IconButton> }
              <Button variant="contained" color="primary" className="" onClick={() => {
                logout();
                props.logout();
              }}>Logout</Button>

            </div>
          </Toolbar>
        </AppBar>
        {renderMenu()}
        {renderMobileMenu}
      </div>
  );
}
