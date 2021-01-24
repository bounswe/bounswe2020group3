import React, { Component } from "react";
import "../App.css"
import { styled } from '@material-ui/core';
import CustomSnackbar from '../Components/CustomSnackbar/CustomSnackbar';
import PrimarySearchAppBar from '../Components/TopBar/PrimarySearchAppBar';
import config from "../config";
import Box from '@material-ui/core/Box';
import { theme } from "../Common/ColorTheme";
import Typography from '@material-ui/core/Typography';

const Container = styled(Box)({
    // background: theme.palette.secondary.light,
    background: "white",
    border: 0,
    borderRadius: 3,
    height: "100vh",
    width: "100%",
    margin: "auto",
    '& .MuiTextField-root': {
        margin: "10px",
        width: "30%",
        minWidth: "250px"
    }
});

export default class RegistrationPage extends Component {

    constructor(props) {
        super(props);
        this.SnackbarRef = React.createRef();
        this.state = {
            check: false
        }
    }
    handleSnackbarOpen = () => {
        this.SnackbarRef.current.turnOnSnackbar();
    }

    goToLogin = () => {
        this.props.history.push(config.Login_Path);
    }
    goToRegister = () => {
        this.props.history.push(config.Register_Path);
    }
    checkBoxTest(){
        this.setState({check: !this.state.check})
    }

    render() {
        console.log(theme.palette)
        console.log("baby")
        return (
            <Container color="secondary">
                <PrimarySearchAppBar loginNav={this.goToLogin} registerNav={this.goToRegister} history={this.props.history} />
                <form className="" onSubmit={this.handleSubmit}>
                    <Typography variant="h5" color="primary"></Typography>
                    <div className="">
                        <h1>Terms and Conditions</h1>
                        <h2>1   Who can use PaperLayer?</h2>
                        <p>A)   We define our “Authorized Users” as:</p>
                        <p>People with access through an institution licensing PaperLayer on their behalf, namely a college, university, secondary school, public library, museum, foundation, government agency, research center, corporate/for-profit organization or scholarly society (“Institutional Licensee”).  This includes individuals i)  permitted to be on the premises of an Institutional Licensee and access PaperLayer while on site and ii) who may also access PaperLayer remotely, specifically:</p>
                        <p>* current students</p>
                        <p>* affiliated researchers and lecturers</p>
                        <p>* staff</p>
                        <p>* patrons of a public library which has licensed remote access</p>
                        <p>* members of a scholarly society</p>
                        <p>* individuals who have a degree from an Institutional Licensee that has licensed access for alumni)</p>
                        <p>Please note that if you access PaperLayer through an Institutional Licensee, your use of PaperLayer may be subject to a separate agreement between PaperLayer and such Institutional Licensee. If that agreement has different terms, those terms will have precedence over these Terms and Conditions of Use.  If you have questions about your Institutional Licensee’s license agreement (“Institutional Participation Agreement”), please contact your librarian.</p>
                        <p>B)   People who come to PaperLayer directly for access.  This includes individuals who:</p>
                        <p>* register for a free individual account that enables access to a limited number of available read-only Content items for fixed periods of time (“Read Only Users”);</p>
                        <p>* access openly available content on PaperLayer, including but not limited to Early Journal Content, the Open PaperLayer Collection or relevant portions of the Community Collection (defined in Section 3 below). (“Open Content Users”).</p>
                        <h2>2   What’s in PaperLayer?</h2>
                        <p>PaperLayer offers many types of scholarly content and materials (collectively referred to as “Content”), including the following:</p>
                        <p>A)   PaperLayer Collection: Content in the “JSTOR Collection” is selected by JSTOR’s editors to be included in PaperLayer digital library. Access to the PaperLayer Collection typically is limited to Authorized Users who have a license to view this Content (either directly or through an Institutional Licensee), although from time to time portions of the PaperLayer Collection may be made openly available by PaperLayer.  The portions of the PaperLayer Collection that you have permission to access are referred to as “Licensed Content”.
The PaperLayer Collection includes:</p>
                        <h2>3   What can I do with Content?</h2>
                        <p>PaperLayer encourages Authorized Users to engage in research activities, including downloading or printing Content for non-commercial, scholarly purposes, as well as use the Content on its platform in the following ways (as long as you abide by the prohibited uses in Section 4 below and noting that Artstor Collection will be subject to the separate terms indicated above):</p>
                        <p>* classroom or organizational instruction and activities (for example, a discreet handout or projection of a Content item within a classroom setting);</p>
                        <p>* in student assignments, educational presentations or in research papers or dissertations, including reproductions of the dissertations (provided such reproductions do not include Books and are only for personal use, library deposit, and/or use solely within your Institutional Licensee);</p>
                        <p>* sharing of portions of Content with other individuals for the purposes of collaboration and discussion (for example, sending an individual Content item to a fellow scholar for the purpose of collaboration on a research project);</p>
                        <p>* if you are an author or other creator of a journal article, incorporating your article into other databases or websites as long as you have any needed prior permission from the publisher and/or other rights holders;</p>
                        <p>* linking, specifically, incorporating stable URLs PaperLayer provides for each Content item into other online spaces to facilitate or direct access (for example, incorporating a link to an assigned Content item into an online syllabi);</p>
                        <p>.</p>
                        <p>.</p>
                        <p>.</p>
                        <p></p>
                        <p></p>
                        
                    </div>


                    
                    <p className="">
                        <Typography variant="inherit" color="primary">
                            Already registered? <a href="/login">Login.</a>
                        </Typography>
                    </p>

                    
                    <p> . </p>
                    <p> . </p>
                    <p> . </p>
                    

                    
                </form>
                <CustomSnackbar ref={this.SnackbarRef} OpenSnackbar={this.handleSnackbarOpening} type={this.state.messageType} message={this.state.message} />
            </Container>);
    }
}    