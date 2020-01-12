import axios from "../../utilities/apiUtils";
const pharmacy_id = 1;

export function setUser({ commit }, payload) {
  commit("setUser", payload);
}

export async function loadOrderData({ commit }) {
  try {
    const res = await axios.get(`api/orders/pharmacies/${pharmacy_id}`);
    commit("loadOrderData", res.data.data);
  } catch (error) {
    console.error(error);
  }
}

export async function signIn({ commit }, value) {
  try {
    const res = await axios.post(`api/users/sign_in`, value);
    commit("setUser", res.data.data);
  } catch (error) {
    console.error(error);
  }
}

export async function createUser({ commit }, value) {
  try {
    const res = await axios.post(`api/users/pharmacies/${value}`, {
      email: "Kakarot@dbz.com",
      password: "dragonballs"
    });
    commit("setUser", res.data.data);
  } catch (error) {
    console.error(error);
  }
}

export async function createPharmacy({ commit }, value) {
  try {
    const res = await axios.post(`api/pharmacies`, value);
    commit("createPharmacy", res.data.data);
  } catch (error) {
    console.error(error);
  }
}

export async function submitNewOrder({ commit }, newOrder) {
  console.log("New Order Data:", newOrder);
}
