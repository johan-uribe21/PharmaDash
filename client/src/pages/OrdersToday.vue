<template>
  <q-page class="flex flex-start">
    <order-table title="Today's Orders" :today="true" />
    <div>
      <q-dialog v-model="addOrder" persistent>
        <add-order-card />
      </q-dialog>
    </div>
    <q-page-sticky position="bottom-right" :offset="[18, 18]">
      <q-btn fab icon="add" color="red" @click="addOrder = true" />
    </q-page-sticky>
  </q-page>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "OrdersTodays",
  components: {
    "order-table": require("components/cardTables/OrderCardTable.vue").default,
    "add-order-card": require("components/dialogCards/AddOrderCard.vue").default
  },
  data() {
    return {
      addOrder: false
    };
  },
  computed: {
    ...mapGetters("pharmaStore", ["getUser", "getOrdersToday"])
  },
  methods: {
    ...mapActions("pharmaStore", ["loadOrderData"]),
    handleAddClick() {
      console.log("Add new order button clicked!");
    }
  },
  created() {
    this.loadOrderData();
  }
};
</script>

<style></style>
