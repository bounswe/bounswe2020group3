import React, { Component } from "react";

export default class Home extends Component {

    render(){
    return(
    <div className="btn-toolbar justify-content-between">

    <div className="btn-group btn-group-lg">
    <a href="/login" className="btn btn-primary" >Login</a>
    </div>
    
    <div className="btn-group btn-group-lg">
    <a href="/paperapi" className="btn btn-success">PaperApi</a>
    </div>

    <div className="btn-group btn-group-lg">
    <a href="/registration" className="btn btn-secondary">Registration</a>
    </div>

    </div>
    );
}}