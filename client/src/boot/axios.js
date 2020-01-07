import Vue from "vue";
import axios from "axios";

// axios.defaults.baseURL = "https://dog.ceo/api";
// axios.defaults.headers.common["Authorization"] = "Fake Auth Token";
// axios.defaults.headers.post["Content-Type"] =
//   "application/x-www-form-urlencoded";

Vue.prototype.$axios = axios;
