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
import CreateEventPage from "./Views/CreateEventPage";
import history from "./history";
import ProfilePage from "./Views/ProfilePage";
import ProjectPage from "./Views/ProjectPage";
import EditProfilePage from './Views/EditProfilePage';

function App() {
  return (
    <div className="App">
      <ThemeProvider theme={theme}>
        <BrowserRouter history={history}>
          <Switch>
            <AuthenticatedRoute exact path={config.Homepage_Path} component={HomePage} />
            <Route exact path={config.Login_Path} component={LoginPage} />
            <Route exact path={config.Register_Path} component={RegistrationPage} />
            <AuthenticatedRoute exact path={config.Create_Project_Path} component={CreateProjectPage} />
            <AuthenticatedRoute exact path={config.Event_Creation_Path} component={CreateEventPage} />
            <AuthenticatedRoute exact path={config.Edit_Profile_Path} component={EditProfilePage} />
            <AuthenticatedRoute path="/project/:projectId" component={ProjectPage} />
            <AuthenticatedRoute path="/profile" component={ProfilePage} />
          </Switch>
        </BrowserRouter>
      </ThemeProvider>
    </div>
  );
}
export default App;
