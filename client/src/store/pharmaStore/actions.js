import axios from "../../utilities/apiUtils";
import { seedData } from "./seedData";
import state from "./state";

export function setUser({ commit }, payload) {
  commit("setUser", payload);
}

export async function loadOrderData({ commit }, pharmacy_id) {
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

export async function createPharmacyUser({ commit }, v) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(`api/users/pharmacies/${v.id}`, v.userParams);
    commit("setUser", res.data.data);
    commit("setDataLoading", false);
    return true;
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
    return false;
  }
}

export async function createCourierUser({ commit }, v) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(`api/users/couriers/${v.id}`, v.userParams);
    commit("setUser", res.data.data);
    commit("setDataLoading", false);
    return true;
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
    return false;
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

export async function loadPharmacies({ commit }) {
  commit("setDataLoading", true);
  try {
    const res = await axios.get(`api/pharmacies`);
    commit("loadPharmacies", res.data.data);
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
  const done = await loadPharmacies({ commit });
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
  const done = await loadCouriers({ commit });
  if (done && state.couriers.length < 3) {
    createSeedCouriers({ commit });
  }
}

export async function submitNewOrder({ commit }, v) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(
      `api/orders/pharmacies/${v.pharmacyId}/couriers/${v.courierId}/patients/${v.patientId}`,
      v.data
    );
    commit("submitNewOrder", res.data.data);
    commit("setDataLoading", false);
    return true;
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export async function submitNewPatient({ commit }, v) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(
      `api/patients/pharmacies/${v.pharmacyId}`,
      v.params
    );
    commit("submitNewPatient", res.data.data);
    commit("setDataLoading", false);
    return true;
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export async function submitNewCourier({ commit }, v) {
  commit("setDataLoading", true);
  try {
    const res = await axios.post(
      `api/couriers/pharmacies/${v.pharmacyId}`,
      v.params
    );
    commit("submitNewCourier", res.data.data);
    commit("setDataLoading", false);
    return true;
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export function setSelectedOrg({ commit }, value) {
  commit("setSelectedOrg", value);
}

export async function loadPatients({ commit }, pharmacy_id) {
  commit("setDataLoading", true);
  try {
    const res = await axios.get(`api/patients/pharmacies/${pharmacy_id}`);
    commit("loadPatients", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export async function loadCouriers({ commit }) {
  commit("setDataLoading", true);
  try {
    const res = await axios.get(`api/couriers`);
    commit("loadCouriers", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export async function cancelOrder({ commit }, orderId) {
  commit("setDataLoading", true);
  try {
    const res = await axios.patch(`api/orders/${orderId}/cancel`);
    commit("cancelOrder", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}

export async function uncancelOrder({ commit }, orderId) {
  commit("setDataLoading", true);
  try {
    const res = await axios.patch(`api/orders/${orderId}/uncancel`);
    commit("uncancelOrder", res.data.data);
    commit("setDataLoading", false);
  } catch (error) {
    console.error(error);
    commit("setDataLoading", false);
  }
}
