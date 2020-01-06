<template>
  <q-page class="flex flex-start">
    <order-table />
  </q-page>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "OrdersTodays",
  components: {
    "order-table": require("components/cardTables/OrderCardTable.vue").default
  },
  data() {
    return {};
  },
  computed: {
    ...mapGetters("pharmaStore", ["getUser", "getOrdersToday"])
  },
  methods: {
    ...mapActions("pharmaStore", ["setUser", "getOrdersToday"]),
    handleGetOrdersToday() {
      this.getOrdersToday();
    }
  },
  created() {
    this.setUser("Bob Bennet");
  }
};
</script>

<style>
/* .container {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-content: flex-start;
} */
</style>
