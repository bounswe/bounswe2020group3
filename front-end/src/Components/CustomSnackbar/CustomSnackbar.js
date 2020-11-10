import React, { Component } from 'react';
import Snackbar from '@material-ui/core/Snackbar';
import MuiAlert from '@material-ui/lab/Alert';
import { styled } from '@material-ui/core/styles';
import Box from "@material-ui/core/Box";
import Slide from '@material-ui/core/Slide';

class TransitionDown extends Component {
    constructor(props){
        super(props);
    }
    render(){
        return <Slide {...this.props} direction="down" />;

    }
  }
  

function Alert(props) {
    return <MuiAlert elevation={6} variant="filled" {...props} />;
}

const StyledAlert = styled(Box)({
    width: '100%',
        '& > * + *': {
            marginTop: "2px"
        }
  });


export default class CustomSnackbar extends Component {

    constructor(props){
        super(props);
        this.state = {
            open: false
        };
    }

    turnOnSnackbar = () => {
        this.setState({open: true});
    };

    handleClose = (event, reason) => {
        if (reason === 'clickaway') {
            return;
        }
        this.setState({open:false})
    };
    render(){
        const { open } = this.state;
        const {message , type } = this.props; 
        return (
            <div className=''>
    
                <Snackbar
                    open={open}
                    autoHideDuration={6000}
                    onClose={this.handleClose}
/* For future use and reminder TransitionComponent={TransitionDown} transitionDuration={{enter: 1000, exit:1000}} */
                    anchorOrigin={{ vertical: "top", horizontal: "center" }}>
                    <Alert severity={type} onClose={this.handleClose}>{message}</Alert>
                </Snackbar>
            </div>
        );
    }
    
}
