import './App.css';
import RegistrationPage from "./Views/RegistrationPage";
import { Switch, Route } from "react-router-dom";

function App() {
  return (
    <div className="App">
      <Switch>
            <Route exact path="/" component={RegistrationPage} />
            <Route exact path="/home" component={RegistrationPage} />
            <Route exact path="/login" component={RegistrationPage} />
            <Route exact path="/registration" component={RegistrationPage} />
            <Route exact path="/paperapi" component={RegistrationPage} />
            <Route path="" component={RegistrationPage}/>
          </Switch>
    </div>
  );
}

export default App;
