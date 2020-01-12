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

    <q-banner v-if="errorMessage" inline-actions class="text-white bg-red">
      {{ errorMessage }}
      <template v-slot:action>
        <q-btn @click="errorMessage = ''" flat color="white" label="x" />
      </template>
    </q-banner>
  </q-card>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "CreateUserCard",
  props: ["pharmacy", "courier"],
  data() {
    return {
      user: {
        name: "",
        email: "",
        password: ""
      },
      errorMessage: ""
    };
  },
  computed: {
    ...mapGetters("pharmaStore", ["getPharmacies", "getCouriers"]),
    selectedPharmacyId() {
      if (this.pharmacy) {
        const pharmacy = this.getPharmacies.filter(
          e => e.name === this.pharmacy
        );
        return pharmacy.id;
      }
      return null;
    },
    selectedCourierId() {
      if (this.courier) {
        const courier = this.getCouriers.filter(e => e.name === this.courier);
        return pharmacy.id;
      }
      return null;
    }
  },
  methods: {
    ...mapActions("pharmaStore", [
      "createPharmacyUser",
      "createCourierUser",
      "signIn"
    ]),
    async handleSubmit() {
      let success = false;
      if (this.pharmacy) {
        await this.createPharmacyUser({ user: this.user });
        success = await this.signIn({ user: this.user });
      } else if (this.courier) {
        await createCourierUser({ user: this.user });
        success = await this.signIn({ user: this.user });
      }
      if (success && this.pharmacy) this.$router.push({ name: "pharmaToday" });
      else if (success && this.courier)
        this.$router.push({ name: "courierToday" });
      else if (!success) this.errorMessage = "Error signing in";
    }
  }
};
</script>

<style></style>
