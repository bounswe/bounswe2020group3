import React, { Component } from "react";
import axios from 'axios';
import config from '../config';

export default class Registration extends Component {

  constructor(props) {
    super(props);
    this.state = {
      name : "",
      surname : "",
      email : "",
      password : "",
      success : null,
      message: ""
    }
  } 

  handleFirstname = event => {
    this.setState({
      name: event.target.value
    });
  };

  handleSurname = event => {
    this.setState({
      surname: event.target.value
    });
  };

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
        name: this.state.name.concat(" ",this.state.surname),
        email: this.state.email,
        password: this.state.password
      };

      axios.post(`${config.API_URL}/api/register`, user, {headers: {'Content-Type': 'Application/json'}})
      .then(res => {
        this.setState({ success : true });
        console.log(res);
        console.log(res.data);
      }, (error) => {
        this.setState({ success : false });
        const temp = JSON.stringify(error.response.data);
        const temp2 = JSON.parse(temp);
        this.setState({ message : temp2["message"] });
        console.log(error);
      })}
    
      render() {
      if(!this.state.success){
        return (
            <form onSubmit={this.handleSubmit}>
                <h3>Registration</h3>
                
                <div className="form-group">
                    <label>First name</label>
                    <input type="text" name="firstname" onChange={this.handleFirstname} className="form-control"  placeholder="First name" />
                </div>

                <div className="form-group">
                    <label>Last name</label>
                    <input type="text" name ="surname" onChange={this.handleSurname} className="form-control" placeholder="Last name" />
                </div>

                <div className="form-group">
                    <label>Email address</label>
                    <input type="email" name="email" onChange={this.handleEmail} className="form-control" placeholder="Enter email" />
                </div>

                <div className="form-group">
                    <label>Password</label>
                    <input type="password" name="password" onChange={this.handlePassword} className="form-control" placeholder="Enter password" />
                </div>

                <p style = {{color:"red",textAlign: "center",fontWeight: "bold",fontFamily: 'Fira Sans'}}>{this.state.message}</p>

                <button type="submit" className="btn btn-primary btn-block">Register</button>
                
                <p className="forgot-password text-right">
                    Already registered <a href="/login">login?</a>
                </p>
            </form>);
      }
        else
          return(<p style = {{color:"green",textAlign: "center",fontWeight: "bold",fontSize: 25,fontFamily: 'Fira Sans'}}>Registration is completed !</p>);
        
    }

}    