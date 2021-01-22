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
import EditProfilePage from "./Views/EditProfilePage";
import ProjectPage from "./Views/ProjectPage";
import SearchPage from "./Views/SearchPage";
import EventPage from "./Views/EventPage";
import EditProjectPage from "./Views/EditProjectPage";
import IssueMilestonePage from "./Views/IssueMilestonePage";
import FileViewer from "./Views/FileViewerPage";
import TermsOfServicesPage from './Views/TermsOfServicesPage';

function App() {
  return (
    <div className="App">
      <ThemeProvider theme={theme}>
        <BrowserRouter history={history}>
          <Switch>
            <Route exact path={config.Homepage_Path} component={HomePage} />
            <Route exact path={config.Login_Path} component={LoginPage} />
            <Route exact path={config.Register_Path} component={RegistrationPage} />
            <AuthenticatedRoute exact path={config.Create_Project_Path} component={CreateProjectPage} />
            <AuthenticatedRoute exact path={config.Event_Creation_Path} component={CreateEventPage} />
            <Route path="/search/:query" component={SearchPage} />
            <AuthenticatedRoute path="/edit-project/:projectId" component={EditProjectPage} />
            <AuthenticatedRoute exact path="/project/:projectId" component={ProjectPage} />
            <AuthenticatedRoute exact path="/events/:eventId" component={EventPage} />
            <AuthenticatedRoute exact path="/profile/:profileId" component={ProfilePage} />
            <AuthenticatedRoute exact path="/edit-profile" component={EditProfilePage} />
            <AuthenticatedRoute exact path={config.Issue_Milestone_Path} component={IssueMilestonePage} />
            <AuthenticatedRoute exact path="/project/files/:projectId" component={FileViewer} />
            <Route exact path={config.Terms_Of_Services_Page_Url} component={TermsOfServicesPage} />
          </Switch>
        </BrowserRouter>
      </ThemeProvider>
    </div>
  );
}
export default App;
