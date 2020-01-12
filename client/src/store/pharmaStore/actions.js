import axios from "../../utilities/apiUtils";
import { seedData } from "./seedData";
import state from "./state";

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

export async function createPharmacyUser({ commit }, params) {
  try {
    const res = await axios.post(
      `api/users/pharmacies/${state.currentPharmacy.pharmacy.id}`,
      params
    );
    commit("setUser", res.data.data);
  } catch (error) {
    console.error(error);
  }
}

export async function createCourierUser({ commit }, params) {
  try {
    const res = await axios.post(
      `api/users/couriers/${state.currentCourier.courier.id}`,
      params
    );
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

export async function createCourier({ commit }, value) {
  try {
    const res = await axios.post(`api/couriers`, value);
    commit("createCourier", res.data.data);
  } catch (error) {
    console.error(error);
  }
}

export async function submitNewOrder({ commit }, newOrder) {
  console.log("New Order Data:", newOrder);
}

export async function createSeedPharmacies({ commit }) {
  const axiosArray = [];
  for (const pharmacy of seedData.seedPharmacies) {
    const newPromise = axios.post(`api/pharmacies`, pharmacy);
    axiosArray.push(newPromise);
  }
  axios
    .all(axiosArray)
    .then(
      axios.spread((...responses) => {
        responses.forEach(res => commit("createSeedPharmacy", res.data.data));
      })
    )
    .catch(e => console.error(e));
}

export async function createSeedCouriers({ commit }) {
  const axiosArray = [];
  for (const courier of seedData.seedCouriers) {
    const newPromise = axios.post(`api/couriers`, courier);
    axiosArray.push(newPromise);
  }
  axios
    .all(axiosArray)
    .then(
      axios.spread((...responses) => {
        responses.forEach(res => commit("createSeedCouriers", res.data.data));
      })
    )
    .catch(e => console.error(e));
}
