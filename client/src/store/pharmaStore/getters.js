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
