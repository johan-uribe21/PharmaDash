<template>
  <div class="column fit items-center justify-center q-mt-lg">
    <h6>Create pharmacy admin user</h6>
    <div class="row justify-center">
      <q-dialog v-model="createUser" persistent>
        <create-user-card
          :pharmacy="selectedPharmacy"
          :courier="selectedCourier"
        />
      </q-dialog>
      <q-dialog v-model="loginUser" persistent>
        <login-card />
      </q-dialog>
      <q-btn
        @click="handleCreatePharmacy('BetterRx')"
        class="q-ma-sm"
        color="secondary"
        label="BetterRX"
      />
      <q-btn
        @click="handleCreatePharmacy('BestRx')"
        class="q-ma-sm"
        color="secondary"
        label="BestRX"
      />
      <q-btn
        @click="handleCreatePharmacy('Drugs R Us')"
        class="q-ma-sm"
        color="secondary"
        label="Drugs R Us"
      />
    </div>
    <h6>Create courier admin user</h6>
    <div class="row justify-center">
      <q-btn
        @click="handleCreateCourier('Same Day Delivery')"
        class="q-ma-sm"
        color="secondary"
        label="Same Day Delivery"
      />
      <q-btn
        @click="handleCreateCourier('Previous Day Delivery')"
        class="q-ma-sm"
        color="secondary"
        label="Previous Day Delivery"
      />
    </div>
    <h6>If already registered</h6>
    <q-btn @click="loginUser = true" color="red" label="Log in" />
    <q-spinner
      color="primary"
      size="3em"
      :thickness="10"
      class="q-mt-md"
      v-if="dataLoading"
    />
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "AuthPage",
  components: {
    "create-user-card": require("components/dialogCards/CreateUserCard.vue")
      .default,
    "login-card": require("components/dialogCards/LoginCard.vue").default
  },
  data() {
    return {
      createUser: false,
      loginUser: false,
      selectedPharmacy: "",
      selectedCourier: ""
    };
  },
  computed: {
    ...mapGetters("pharmaStore", [
      "dataLoading",
      "getPharmacies",
      "getCouriers"
    ])
  },
  methods: {
    ...mapActions("pharmaStore", [
      "getOrCreatePharmacies",
      "getOrCreateCouriers",
      "setSelectedOrg"
    ]),
    getPharmacyId(name) {
      const pharmacy = this.getPharmacies.filter(e => e.name === name)[0];
      return pharmacy ? pharmacy.id : null;
    },
    getCourierId(name) {
      const courier = this.getCouriers.filter(e => e.name === name)[0];
      return courier ? courier.id : null;
    },
    handleCreatePharmacy(name) {
      this.selectedPharmacy = name;
      this.selectedCourier = "";
      this.createUser = true;
      this.setSelectedOrg({
        pharmacy: true,
        name,
        id: this.getPharmacyId(name)
      });
    },
    handleCreateCourier(name) {
      this.selectedCourier = name;
      this.selectedPharmacy = "";
      this.createUser = true;
      this.setSelectedOrg({
        pharmacy: false,
        name,
        id: this.getCourierId(name)
      });
    }
  },
  created() {
    this.getOrCreatePharmacies();
    this.getOrCreateCouriers();
  }
};
</script>

<style></style>
