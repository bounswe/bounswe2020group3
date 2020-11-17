import './App.css';
import RegistrationPage from "./Views/RegistrationPage";
import HomePage from "./Views/HomePage";
import LoginPage from "./Views/LoginPage";
import { Switch, Route, BrowserRouter } from "react-router-dom";
import config from "./config";
import { AuthenticatedRoute } from './Components/Auth/Authenticate';
import history from "./history";

function App() {
  return (
    <div className="App">
      <BrowserRouter history={history}>
        <Switch>
          <Route exact path="/" component={HomePage} />
          <Route path="/home" component={HomePage} />
          <Route path={config.Login_Path} component={LoginPage} />
          <Route path={config.Register_Path} component={RegistrationPage} />
          {/* Left as an example for constructing an authenticated route */}
          <AuthenticatedRoute path="/paperapi" component={LoginPage} />
        </Switch>
      </BrowserRouter>

    </div>
  );
}
export default App;
