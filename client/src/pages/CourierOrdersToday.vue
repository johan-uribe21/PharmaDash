<template>
  <q-page class="flex column flex-start">
    <order-table title="Today's Orders" :today="true" :courier="true" />
    <q-spinner
      color="primary"
      size="3em"
      :thickness="10"
      class="q-mt-md"
      v-if="dataLoading"
    />
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
    ...mapGetters("pharmaStore", [
      "getUser",
      "dataLoading",
      "getOrdersUpToDate"
    ]),
    courierId() {
      return this.getUser.courier_id;
    }
  },
  methods: {
    ...mapActions("pharmaStore", ["loadOrderDataCourier"])
  },
  created() {
    if (!this.getOrdersUpToDate) this.loadOrderDataCourier(this.courierId);
  }
};
</script>

<style></style>
