import './App.css';
import RegistrationPage from "./Views/RegistrationPage";
import HomePage from "./Views/HomePage";
import LoginPage from "./Views/LoginPage";
import { Switch, Route } from "react-router-dom";
import config from "./config";
import { AuthenticateBeforeRender, AuthenticatedRoute } from './Components/Auth/Authenticate';
import { createMuiTheme, ThemeProvider } from '@material-ui/core/styles';
import CssBaseline from '@material-ui/core/CssBaseline';
import { theme } from './Common/ColorTheme';
function App() {
  return (
    <ThemeProvider theme={ theme }>
      <div className="App">
        <Switch>
          <Route exact path="/" component={HomePage} />
          <Route path="/home" component={HomePage} />
          <Route path={config.Login_Path} component={LoginPage} />
          <Route path={config.Register_Path} component={RegistrationPage} />
          {/* Left as an example for constructing an authenticated route */}
          <AuthenticatedRoute path="/paperapi" component={LoginPage} />
        </Switch>
      </div>
    </ThemeProvider>
  );
}
export default App;
