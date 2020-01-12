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
      <q-btn
        @click="createBetterRx"
        class="q-ma-sm"
        color="secondary"
        label="BetterRX"
      />
      <q-btn
        @click="createBestRx"
        class="q-ma-sm"
        color="secondary"
        label="BestRX"
      />
      <q-btn
        @click="createDrugsRUs"
        class="q-ma-sm"
        color="secondary"
        label="Drugs R Us"
      />
    </div>
    <h6>Create courier admin user</h6>
    <div class="row justify-center">
      <q-btn
        @click="createSameDay"
        class="q-ma-sm"
        color="secondary"
        label="Same Day Delivery"
      />
      <q-btn
        @click="createPreviousDay"
        class="q-ma-sm"
        color="secondary"
        label="Previous Day Delivery"
      />
    </div>
    <h6>If already registered</h6>
    <q-btn @click="handleLogIn" class="q-ma-sm" color="red" label="Log in" />
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "AuthPage",
  components: {
    "create-user-card": require("components/dialogCards/CreateUserCard.vue")
      .default
  },
  data() {
    return {
      createUser: false,
      selectedPharmacy: "",
      selectedCourier: ""
    };
  },
  methods: {
    ...mapActions("pharmaStore", ["createSeedCouriers"]),
    handleCancel(orderId) {
      console.log("Cancel order", orderId);
    },
    async createSelectedPharmacy(pharmacyParams) {
      return await this.createPharmacy(pharmacyParams);
    },
    async createBetterRx() {
      this.selectedPharmacy = "BetterRx";
      this.selectedCourier = "";
      this.createUser = true;
    },
    async createBestRx() {
      this.selectedPharmacy = "BestRx";
      this.selectedCourier = "";
      this.createUser = true;
    },
    async createDrugsRUs() {
      this.selectedPharmacy = "Drugs R Us";
      this.selectedCourier = "";
      this.createUser = true;
    },
    async createSameDay() {
      this.selectedPharmacy = "";
      this.selectedCourier = "Same Day Delivery";
      this.createUser = true;
    },
    async createPreviousDay() {
      this.selectedPharmacy = "";
      this.selectedCourier = "Previous Day Delivery";
      this.createUser = true;
    },
    async handleLogIn() {
      this.createSeedCouriers();
    }
  },
  created() {}
};
</script>

<style></style>
