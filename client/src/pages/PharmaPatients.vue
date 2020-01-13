<template>
  <q-page class="flex flex-start">
    <patient-table title="Patients" />
    <div>
      <q-dialog v-model="addPatient" persistent>
        <add-patient-card />
      </q-dialog>
    </div>
    <q-page-sticky position="bottom-right" :offset="[18, 18]">
      <q-btn fab icon="add" color="red" @click="addPatient = true" />
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
  name: "Patients",
  components: {
    "patient-table": require("components/cardTables/PatientCardTable.vue")
      .default,
    "add-patient-card": require("components/dialogCards/AddPatientCard.vue")
      .default
  },
  data() {
    return {
      addPatient: false
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
