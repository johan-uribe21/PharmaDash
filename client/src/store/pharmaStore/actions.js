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
  commit("setDataLoading", true);
  try {
    const res = await axios.post(`api/users/sign_in`, value);
    commit("setUser", res.data.data);
    commit("setDataLoading", false);
    return true;
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
    return false;
  }
}

export async function createUser({ commit }, params) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(`api/users`, params);
    commit("setUser", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    commit("setDataLoading", false);
    console.error(error);
  }
}

export async function createPharmacyUser({ commit }, params) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(
      `api/users/pharmacies/${state.selectedOrg.id}`,
      params
    );
    commit("setUser", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export async function createCourierUser({ commit }, params) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(
      `api/users/couriers/${state.selectedOrg.id}`,
      params
    );
    commit("setUser", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export async function createPharmacy({ commit }, value) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(`api/pharmacies`, value);
    commit("createPharmacy", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export async function getPharmacies({ commit }) {
  commit("setDataLoading", true);
  try {
    const res = await axios.get(`api/pharmacies`);
    commit("getPharmacies", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
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
    .catch(e => {
      console.error(e);
    });
}

export async function getOrCreatePharmacies({ commit }) {
  const done = await getPharmacies({ commit });
  if (done && state.pharmacies.length < 3) {
    createSeedPharmacies({ commit });
  }
}

export async function createCourier({ commit }, value) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(`api/couriers`, value);
    commit("createCourier", res.data.data);
    commit("setDataLoading", false);
    return true;
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export async function getCouriers({ commit }) {
  commit("setDataLoading", true);
  try {
    const res = await axios.get(`api/couriers`);
    commit("getCouriers", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
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
    .catch(e => {
      console.error(e);
    });
}

export async function getOrCreateCouriers({ commit }) {
  const done = await getCouriers({ commit });
  if (done && state.couriers.length < 3) {
    createSeedCouriers({ commit });
  }
}

export async function submitNewOrder({ commit }, newOrder) {
  commit("setDataLoading", true);
  console.log("New Order Data:", newOrder);
  commit("setDataLoading", false);
}

export function setSelectedOrg({ commit }, value) {
  commit("setSelectedOrg", value);
}
