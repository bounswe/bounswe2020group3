import './App.css';
import RegistrationPage from "./Views/RegistrationPage";
import { BrowserRouter, Switch, Route, Link } from "react-router-dom";

function App() {
  return (
    <div className="App">
      <Switch>
            <Route exact path="/" component={RegistrationPage} />
            <Route path="/home" component={RegistrationPage} />
            <Route path="/login" component={RegistrationPage} />
            <Route path="/registration" component={RegistrationPage} />
            <Route path="/paperapi" component={RegistrationPage} />
          </Switch>
    </div>
  );
}

export default App;
