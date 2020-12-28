import React from "react";
import Avatar from '@material-ui/core/Avatar';
import { Button, Typography, Box, styled } from '@material-ui/core';

const Side = styled(Box)({
    backgroundColor: "#183761",
    paddingTop: "60px",
    height: '100%',
    minWidth: "200px",
    width: '200px',
    top: '64px',
    position: "fixed",
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
});
function Profilebar(props) {

    return (
        <Side item>
            <Avatar src={props.photoUrl}
                style={{ marginRight: "10px", width: "100px", height: "100px", cursor: "pointer", marginBottom: "25px" }}
                onClick={props.goToProfile} />
            <Typography variant="h6" style={{textTransform:"capitalize"}}>{props.name} <br /> {props.lastName}</Typography>

            {/*<Button color="secondary" variant="outlined" style={{ margin: "10px" }}>Google Scholar</Button>*/}
            <Button color="secondary" variant="outlined"
                style={{ margin: "10px" }}
                onClick={props.goToProjectCreation}
            >Create a Project</Button><Button color="secondary" variant="outlined"
                style={{ margin: "10px" }}
                onClick={props.goToEventCreation}
            >Create an Event</Button>
        </Side>);
}
export default Profilebar;
