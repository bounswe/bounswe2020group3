import React, { Component } from "react";

export default class Home extends Component {

    render(){
    return(
    <div class="btn-toolbar justify-content-between">
    <div class="btn-group btn-group-lg">
    <a href="/login" class="btn btn-primary" >Login</a>
  
    </div>
    <div class="btn-group btn-group-lg">
    <a href="/registration" class="btn btn-secondary">Registration</a>
    </div>
    </div>
    );
}}