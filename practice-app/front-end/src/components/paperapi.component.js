import React, { Component } from "react";
import DropdownButton from 'react-bootstrap/DropdownButton';
import Dropdown from 'react-bootstrap/Dropdown';
import axios from 'axios';
import config from '../config';

export default class PaperAPI extends Component {

    constructor(props) {
        super(props);
        this.state = {
          endpoint : "",
          success : null,
          message: ""
        }
      } 
      handleEndpoint = event => {
        this.setState({
          endpoint: event.target.value
        });
      };

      handleSubmit = event => {
        event.preventDefault()
        {/*
        const arr = this.state.endpoint.split("?");
        console.log(arr);
        const params = arr[1].split("&");
        const param1 = params[0].split("=");
        const param2 = params[1].split("=");
        const str1 = param1[0];
        const request = {
            param1[0]: param1[1],
          };
          */}
        const baseurl = `${config.API_URL}`;
        const arr = this.state.endpoint.split("?");
        var qs = require('qs');

          axios.get(baseurl.concat(arr[0]), qs.parse(arr[1]), {headers: {'Content-Type': 'Application/json'}})
          .then(res => {
            this.setState({ message : JSON.stringify(res.data) });
            console.log(res);
            console.log(res.data);
          }, (error) => {
            this.setState({ message : "Can't GET !"});
            console.log(error);
          })}

          
    render(){
        return (
          <div>
              <form onSubmit={this.handleSubmit}>       
            <div  style={{ display: "flex", flexDirection: "row" }}>
            {/*
            <DropdownButton id="dropdown-basic-button" title="Type">
            <Dropdown.Item href="#/action-1">GET</Dropdown.Item>
            <Dropdown.Item href="#/action-2">POST</Dropdown.Item>
            </DropdownButton>
                */}
        <input class="form-control" type="text" placeholder="Endpoint" onChange={this.handleEndpoint}></input>
        <button type="submit" className="btn btn-primary">Submit</button>
        </div>
        
        </form>

        <p style = {{textAlign: "left",fontWeight: "bold"}}> Example : /api/test </p>

        <div class="pre-scrollable">
          
        {this.state.message}
        
        </div>

        </div>
        );
    }
}
