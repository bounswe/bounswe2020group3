import './App.css';
import RegistrationPage from "./Views/RegistrationPage";
import HomePage from "./Views/HomePage";

import { Switch, Route } from "react-router-dom";

function App() {
  return (
    <div className="App">
      <Switch>
            <Route exact path="/" component={HomePage } />
            <Route path="/home" component={HomePage} />
            <Route path="/login" component={RegistrationPage} />
            <Route path="/registration" component={RegistrationPage} />
            <Route path="/paperapi" component={RegistrationPage} />
          </Switch>
    </div>
  );
}
export default App;
