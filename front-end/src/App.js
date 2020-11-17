import React from 'react'
import ReactDOM from 'react-dom'
import './App.css';
import RegistrationPage from "./Views/RegistrationPage";
import HomePage from "./Views/HomePage";
import LoginPage from "./Views/LoginPage";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import config from "./config";
import SideBar from './Components/SideBar/SideBar';
import { AuthenticateBeforeRender, AuthenticatedRoute } from './Components/Auth/Authenticate';

const items = [
  { name: 'home', label: 'HOME' },
  { name: 'exit', label: 'EXIT' }]

function App() {
  return (
    <div className="App">
      <Switch>
      
            <Route exact path="/" component={HomePage } />
            <Route path="/home" component={HomePage} />
            <Route path={config.Login_Path} component={LoginPage} />
            <Route path={config.Register_Path} component={RegistrationPage} />
          {/* Left as an example for constructing an authenticated route */}
            <AuthenticatedRoute path="/paperapi" component={LoginPage} />
      </Switch>
      <div class="sidebar">
        <SideBar items={items}/>
      </div>
    </div>
  );
}
export default App;
