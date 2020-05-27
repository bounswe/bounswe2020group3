import React, { Component } from "react";
import 'bootstrap-social/bootstrap-social.css';
import 'font-awesome/css/font-awesome.min.css';
import axios from 'axios';
import config from '../config';

export default class Login extends Component {

    constructor(props) {
        super(props);
        this.state = {
          email : "",
          password : "",
          success : null,
          message: ""
        }
      } 
    
    handleEmail = event => {
        this.setState({
          email: event.target.value
        });
      };

    handlePassword = event => {
        this.setState({
          password: event.target.value
        });
    };

    handleSubmit = event => {
        event.preventDefault()
        const user = {
            email: this.state.email,
            password: this.state.password
          };
    
          axios.post(`${config.API_URL}/api/login`, user, {headers: {'Content-Type': 'Application/json'}})
          .then(res => {
            this.setState({ success : true });
            console.log(res);
            console.log(res.data);
          }, (error) => {
            this.setState({ success : false });
            this.setState({ message : error.response.data });
            console.log(error);
          })}

    render() {

        if(!this.state.success){

        return (
            <form onSubmit={this.handleSubmit}>
                <h3>Login</h3>

                <div className="form-group">
                    <label>Email address</label>
                    <input type="email" name="email" onChange={this.handleEmail} className="form-control" placeholder="Enter email" />
                </div>

                <div className="form-group">
                    <label>Password</label>
                    <input type="password" name="password" onChange={this.handlePassword} className="form-control" placeholder="Enter password" />
                </div>

                <div className="form-group">
                    <div className="custom-control custom-checkbox">
                        <input type="checkbox" className="custom-control-input" id="customCheck1" />
                        <label className="custom-control-label" htmlFor="customCheck1">Remember me</label>
                    </div>
                </div>
                <p style = {{color:"red",textAlign: "center",fontWeight: "bold",fontFamily: 'Fira Sans'}}>{this.state.message}</p>
                <button type="submit" className="btn btn-primary btn-block" >Submit</button>
                {/* 
                <a href="https://www.facebook.com/" id="facebook-button"  className="btn btn-block btn-social btn-facebook" style={{fontFamily: 'Fira Sans'}}>
                <i className="fa fa-facebook"></i> Login with Facebook
                </a>

                <a href="https://www.google.com/" id="google-button"  className="btn btn-block btn-social btn-google" style={{fontFamily: 'Fira Sans'}}>
                <i className="fa fa-google"></i> Login with Google
                </a>

                <a href="https://www.linkedin.com/" id="linkedin-button"  className="btn btn-block btn-social btn-linkedin" style={{fontFamily: 'Fira Sans'}}>
                <i className="fa fa-linkedin"></i> Login with linkedin
                </a>
                  */}
                <p className="forgot-password text-right">
                    No account? <a href="/registration">Register</a>
                </p>

                {/* 
                <p className="forgot-password text-right">
                    Forgot <a href="!#">password?</a>
                </p>
                */}
            </form>
        );
    }
        else
            return(<p style = {{color:"green",textAlign: "center",fontWeight: "bold",fontSize: 25,fontFamily: 'Fira Sans'}}>Login is completed !</p>);
    }
}