export function getUser(state) {
  return state.user;
}

export function getOrdersToday(state) {
  // add filter logic
  return state.orders;
}

export function getOrdersAll(state) {
  return state.orders;
}

export function dataLoading(state) {
  return state.dataLoading;
}

export function getPharmacies(state) {
  return state.pharmacies;
}

export function getCouriers(state) {
  return state.couriers;
}

export function getSelectedOrg(state) {
  return state.selectedOrg;
}

export function getOrdersUpToDate(state) {
  return state.ordersUpToDate;
}
