export function setUser(state, payload) {
  state.user = payload;
}

export function loadOrderData(state, payload) {
  state.orders = [...state.orders, ...payload];
}

export function createPharmacy(state, payload) {
  state.currentPharmacy = payload;
}
