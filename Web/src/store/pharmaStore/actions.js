import axios from "../../utilities/apiUtils";

// axios.defaults.baseURL = "https://dog.ceo";
// axios.defaults.headers.common["Authorization"] = "Fake Auth Token";
// axios.defaults.headers.post["Content-Type"] =
//   "application/x-www-form-urlencoded";

export function setUser({ commit }, payload) {
  commit("setUser", payload);
}

export async function loadOrdersToday({ commit }) {
  try {
    const res = await axios.get("api/breeds/list/all");
    commit("getOrdersToday", res.data.message);
  } catch (error) {
    console.error(error);
  }
}

export async function submitNewOrder({ commit }, newOrder) {
  console.log("New Order Data:", newOrder);
}
