import './App.css';
import RegistrationPage from "./Views/RegistrationPage";
import LoginPage from "./Views/LoginPage";
import { Switch, Route } from "react-router-dom";
import config from "./config";
import { AuthenticateBeforeRender, AuthenticatedRoute } from './Components/Auth/Authenticate';

function App() {
  return (
    <div className="App">
      <Switch>
            <Route exact path="/" component={RegistrationPage} />
            <Route path="/home" component={RegistrationPage} />
            <Route path={config.Login_Path} component={LoginPage} />
            <Route path={config.Register_Path} component={RegistrationPage} />
            {/* Left as an example for constructing an authenticated route */}
            <AuthenticatedRoute path="/paperapi" component={RegistrationPage} />
          </Switch>
    </div>
  );
}

export default App;
