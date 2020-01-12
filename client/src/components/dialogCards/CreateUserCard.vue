<template>
  <q-card style="min-width: 350px">
    <q-card-section>
      <div class="text-h6">
        Create new <b>{{ pharmacy || courier }}</b> user
      </div>
    </q-card-section>
    <q-card-section>
      <q-input
        placeholder="Name"
        dense
        v-model="userDetails.name"
        autofocus
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Email"
        dense
        v-model="userDetails.email"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Password"
        dense
        v-model="userDetails.password"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
    </q-card-section>

    <q-card-actions align="right" class="text-primary">
      <q-btn flat label="Cancel" v-close-popup />
      <q-btn flat @click="handleSubmit" label="Submit New User" v-close-popup />
    </q-card-actions>
  </q-card>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import { seedData } from "../../store/pharmaStore/seedData";
export default {
  name: "CreateUserCard",
  props: ["pharmacy", "courier"],
  data() {
    return {
      userDetails: {
        name: "",
        email: "",
        password: ""
      }
    };
  },
  computed: {
    selectedPharmacyParams() {
      if (pharmacy) {
        return seedData.seedPharmacies.filter(
          e => e.pharmacy.name === pharmacy
        )[0];
      }
      return null;
    },
    selectedCourierParams() {
      if (courier) {
        return seedData.seedCouriers.filter(
          e => e.courier.name === pharmacy
        )[0];
      }
      return null;
    }
  },
  methods: {
    ...mapActions("pharmaStore", [
      "createPharmacy",
      "createCourier",
      "createPharmacyUser",
      "createCourierUser",
      "signIn"
    ]),
    async handleSubmit() {
      if (pharmacy) {
        await this.createPharmacy(this.selectedPharmacyParams);
        await this.createPharmacyUser(userDetails);
      } else if (courier) {
        await this.createCourier(this.selectedCourierParams);
        await this.createCourierUser(userDetails);
      }
      await this.signIn({ email: user.email });
    }
  }
};
</script>

<style></style>
