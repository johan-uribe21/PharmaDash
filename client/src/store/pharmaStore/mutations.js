export function setUser(state, payload) {
  state.user = payload;
}

export function loadOrderData(state, payload) {
  state.orders = [...state.orders, ...payload];
}

export function createPharmacy(state, payload) {
  state.currentPharmacy = payload;
}

export function createCourier(state, payload) {
  state.currentCourier = payload;
}

export function createSeedPharmacy(state, payload) {
  state.seedPharmacies = payload;
}

export function createSeedCourier(state, payload) {
  state.seedCouriers = payload;
}
