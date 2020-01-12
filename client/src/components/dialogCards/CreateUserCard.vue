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
        filled
        v-model="user.name"
        autofocus
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Email"
        type="email"
        filled
        dense
        v-model="user.email"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Password"
        type="password"
        filled
        dense
        v-model="user.password"
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
      user: {
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
    ...mapActions("pharmaStore", ["createUser", "signIn"]),
    async handleSubmit() {
      await this.createUser({ user: this.user });
      await this.signIn({ user: this.user });
      if (pharmacy) {
        console.log(this.selectedPharmacyParams);
        // await this.createPharmacy(this.selectedPharmacyParams);
      } else if (courier) {
        // await this.createCourier(this.selectedCourierParams);
      }
    }
  }
};
</script>

<style></style>
