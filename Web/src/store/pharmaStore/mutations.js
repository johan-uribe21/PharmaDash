export function setUser(state, payload) {
  state.user = payload;
}

export function getOrdersToday(state, payload) {
  state.ordersToday = [...state.ordersToday, payload];
}
