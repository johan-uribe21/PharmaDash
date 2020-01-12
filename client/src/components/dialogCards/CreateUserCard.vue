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
      <q-btn
        flat
        @click="handleSubmit"
        label="Submit New User"
        v-close-popup="createSuccess"
      />
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
      errorMessage: "",
      createSuccess: false
    };
  },
  computed: {
    ...mapGetters("pharmaStore", [
      "getPharmacies",
      "getCouriers",
      "getSelectedOrg"
    ]),
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
      let created = false;
      if (this.pharmacy) {
        created = await this.createPharmacyUser({
          userParams: { user: this.user },
          id: this.getSelectedOrg.id
        });
        success = await this.signIn({ user: this.user });
        this.createSuccess = true;
      } else if (this.courier) {
        created = await createCourierUser({
          userParams: { user: this.user },
          id: this.getSelectedOrg.id
        });
        success = await this.signIn({ user: this.user });
        this.createSuccess = true;
      }

      if (success && created && this.pharmacy) {
        this.$router.push({ name: "pharmaToday" });
        this.createSuccess = true;
      } else if (success && created && this.courier) {
        this.$router.push({ name: "courierToday" });
        this.createSuccess = true;
      } else if (!success || !created)
        this.errorMessage =
          "Error creating user or signing in. User emails must be unique";
    }
  }
};
</script>

<style></style>
