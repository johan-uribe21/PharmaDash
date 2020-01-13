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

export function loadCouriers(state, payload) {
  state.couriers = payload;
  state.couriersUpToDate = true;
}

export function loadPharmacies(state, payload) {
  state.pharmacies = payload;
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

export function setSelectedOrg(state, payload) {
  state.selectedOrg = payload;
}

export function submitNewPatient(state, payload) {
  state.patients = [...state.patients, payload];
}

export function submitNewCourier(state, payload) {
  state.couriers = [...state.couriers, payload];
}

export function submitNewOrder(state, payload) {
  state.orders = [...state.orders, payload];
}

export function resetState(state) {
  state = {
    user: {},
    orders: [],
    isPharmacyUser: false,
    currentPharmacy: {},
    currentCourier: {},
    dataLoading: false,
    pharmacies: [],
    couriers: [],
    selectedOrg: {},
    ordersUpToDate: false,
    patients: [],
    patientsUpToDate: false,
    couriersUpToDate: false
  };
}

export function updateOrder(state, payload) {
  state.orders = state.orders.map(e => {
    if (e.id === payload.id) {
      return payload;
    }
    return e;
  });
}
