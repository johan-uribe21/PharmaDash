import axios from "axios";

axios.defaults.baseURL = "https://dog.ceo";
axios.defaults.withCredentials = true;
// axios.defaults.headers.common["Authorization"] = "Fake Auth Token";
// axios.defaults.headers.post["Content-Type"] =
//   "application/x-www-form-urlencoded";

export default axios;
