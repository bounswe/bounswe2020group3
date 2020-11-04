import React, { Component } from 'react';
import Snackbar from '@material-ui/core/Snackbar';
import MuiAlert from '@material-ui/lab/Alert';
import { styled } from '@material-ui/core/styles';
import Box from "@material-ui/core/Box";
import Slide from '@material-ui/core/Slide';
import IconButton from "@material-ui/core/IconButton";

function TransitionDown(props) {
    return <Slide {...props} direction="down" />;
  }
  

function Alert(props) {
    return <MuiAlert elevation={6} variant="filled" {...props} />;
}

// const useStyles = makeStyles((theme) => ({
//     root: {
//         width: '100%',
//         '& > * + *': {
//             marginTop: theme.spacing(2),
//         },
//     },
// }));
const StyledAlert = styled(Box)({
    // background: 'linear-gradient(45deg, #FE6B8B 30%, #FF8E53 90%)',
    // border: 0,
    // borderRadius: 3,
    // boxShadow: '0 3px 5px 2px rgba(255, 105, 135, .3)',
    // color: 'white',
    // height: "50%",
    // width: "50%",
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
    //props :  Type (From AlertTypes in Common), Message, OpenSnackbar 
    // const classes = useStyles();
    // const [open, setOpen] = React.useState(false);

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
    
                <Snackbar  open={open} autoHideDuration={6000} onClose={this.handleClose}>
                {/* TransitionComponent={TransitionDown} transitionDuration={{enter: 1000, exit:1000}} */}
                    <Alert severity={type} onClose={this.handleClose}>{message}</Alert>
                </Snackbar>
            </div>
        );
    }
    
}
