function getTodaysDate() {
  var today = new Date();
  var dd = String(today.getDate()).padStart(2, "0");
  var mm = String(today.getMonth() + 1).padStart(2, "0");
  var yyyy = today.getFullYear();

  return yyyy + "-" + mm + "-" + dd;
}

export function getUser(state) {
  return state.user;
}

export function getOrdersToday(state) {
  // add filter logic
  return state.orders.filter(e => e.pickupDate === getTodaysDate());
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

export function getPatients(state) {
  return state.patients;
}

export function getSelectedOrg(state) {
  return state.selectedOrg;
}

export function getOrdersUpToDate(state) {
  return state.ordersUpToDate;
}

export function getPatientsUpToDate(state) {
  return state.patientsUpToDate;
}

export function getCouriersUpToDate(state) {
  return state.couriersUpToDate;
}
