import React, { Component } from 'react';
import Snackbar from '@material-ui/core/Snackbar';
import MuiAlert from '@material-ui/lab/Alert';

function Alert(props) {
    return <MuiAlert elevation={6} variant="filled" {...props} />;
}

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
