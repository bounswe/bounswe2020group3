import './App.css';
import RegistrationPage from "./Views/RegistrationPage";
import HomePage from "./Views/HomePage";
import LoginPage from "./Views/LoginPage";
import { Switch, Route, BrowserRouter } from "react-router-dom";
import config from "./config";
import CreateProjectPage from "./Views/CreateProjectPage";
import { AuthenticatedRoute } from './Components/Auth/Authenticate';
import { ThemeProvider } from '@material-ui/core/styles';
import { theme } from "./Common/ColorTheme";
import history from "./history";

function App() {
  return (
    <div className="App">
      <ThemeProvider theme={theme}>
        <BrowserRouter history={history}>
          <Switch>
            <Route exact path="/" component={HomePage} />
            <Route path={config.Homepage_Path} component={HomePage} />
            <Route path={config.Login_Path} component={LoginPage} />
            <Route path={config.Register_Path} component={RegistrationPage} />
            <Route path={config.Create_Project_Path} component={CreateProjectPage} />
            {/* Left as an example for constructing an authenticated route */}
            <AuthenticatedRoute path="/paperapi" component={LoginPage} />
          </Switch>
        </BrowserRouter>
      </ThemeProvider>
    </div>
  );
}
export default App;
