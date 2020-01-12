<template>
  <div class="column fit items-center justify-center q-mt-lg">
    <h6>Create pharmacy admin user</h6>
    <div class="row justify-center">
      <q-dialog
        v-model="createUser"
        :pharmacy="selectedPharmacy"
        :courier="selectedCourier"
        persistent
      >
        <create-user-card />
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
    <q-btn @click="logIn" class="q-ma-sm" color="red" label="Log in" />
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
      selectedCourier: "",
      seedPharmacies: {
        betterRx: {
          name: "BetterRx",
          street: "1275 Kinnear Road,",
          city: "Columbus",
          stateAbr: "OH",
          zipcode: "43212"
        },
        bestRx: {
          name: "BestRx",
          street: "123 Austin St,",
          city: "Austin",
          stateAbr: "TX",
          zipcode: "78702"
        },
        drugsRUs: {
          name: "Drugs R Us",
          street: "4925 LA Ave,",
          city: "Los Angeles",
          stateAbr: "CA",
          zipcode: "90056"
        }
      },
      seedCouriers: {
        sameDay: {
          name: "Same Day Delivery",
          street: "900 Trenton Lane,",
          city: "Trenton",
          stateAbr: "NJ",
          zipcode: "08536"
        },
        previousDay: {
          name: "Previous Day Delivery",
          street: "7433 LA Ct,",
          city: "Los Angeles",
          stateAbr: "CA",
          zipcode: "90056"
        }
      }
    };
  },
  methods: {
    ...mapActions("pharmaStore", ["createPharmacy"]),
    handleCancel(orderId) {
      console.log("Cancel order", orderId);
    },
    async createSelectedPharmacy(pharmacyParams) {
      return await this.createPharmacy(pharmacyParams);
    },
    async createBetterRx() {
      this.selectedPharmacy = "BetterRx";
      this.createUser = true;
    }
  }
};
</script>

<style></style>
