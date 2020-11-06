import './App.css';
import RegistrationPage from "./Views/RegistrationPage";
import LoginPage from "./Views/LoginPage";
import { Switch, Route } from "react-router-dom";

function App() {
  return (
    <div className="App">
      <Switch>
            <Route exact path="/" component={RegistrationPage} />
            <Route path="/home" component={RegistrationPage} />
            <Route path="/login" component={LoginPage} />
            <Route path="/register" component={RegistrationPage} />
            <Route path="/paperapi" component={RegistrationPage} />
          </Switch>
    </div>
  );
}

export default App;
