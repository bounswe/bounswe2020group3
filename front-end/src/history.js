import { createBrowserHistory } from 'history';
let history = createBrowserHistory();
export default history;

export const goToHomepage = () => {
    history.push("/")
}