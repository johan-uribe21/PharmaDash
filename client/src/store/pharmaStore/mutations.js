export function setUser(state, payload) {
  state.user = payload;
}

export function loadOrderData(state, payload) {
  state.orders = [...payload];
  state.ordersUpToDate = true;
}

export function loadPatients(state, payload) {
  state.patients = [...payload];
  state.patientsUpToDate = true;
}

export function createPharmacy(state, payload) {
  state.currentPharmacy = payload;
  state.isPharmacyUser = true;
}

export function createCourier(state, payload) {
  state.currentCourier = payload;
  state.isPharmacyUser = false;
}

export function createSeedPharmacy(state, payload) {
  state.seedPharmacies = payload;
}

export function createSeedCourier(state, payload) {
  state.seedCouriers = payload;
}

export function setDataLoading(state, payload) {
  state.dataLoading = payload;
}

export function getPharmacies(state, payload) {
  state.pharmacies = payload;
}

export function getCouriers(state, payload) {
  state.couriers = payload;
}

export function setSelectedOrg(state, payload) {
  state.selectedOrg = payload;
}

export function submitNewPatient(state, payload) {
  state.patients = [...state.patients, payload];
}
