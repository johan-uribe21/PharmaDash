<template>
  <q-page class="flex column flex-start">
    <patients-table title="Couriers" :courier="true" />
    <div>
      <q-dialog v-model="addCourier" persistent>
        <add-courier-card />
      </q-dialog>
    </div>
    <q-page-sticky position="bottom-right" :offset="[18, 18]">
      <q-btn fab icon="add" color="red" @click="addCourier = true" />
    </q-page-sticky>
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
  name: "Couriers",
  components: {
    "patients-table": require("components/cardTables/PatientCardTable.vue")
      .default,
    "add-courier-card": require("components/dialogCards/AddCourierCard.vue")
      .default
  },
  data() {
    return {
      addCourier: false
    };
  },
  computed: {
    ...mapGetters("pharmaStore", [
      "getUser",
      "getOrdersToday",
      "getPatientsUpToDate",
      "dataLoading"
    ])
  },
  methods: {
    ...mapActions("pharmaStore", ["loadPatients"]),
    handleAddClick() {
      console.log("Add new order button clicked!");
    }
  },
  created() {
    if (!this.getPatientsUpToDate) this.loadPatients(this.getUser.pharmacy_id);
  }
};
</script>

<style></style>
