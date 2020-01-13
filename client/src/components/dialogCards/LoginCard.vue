<template>
  <q-card style="min-width: 350px">
    <q-card-section>
      <div class="text-h6">
        Sign In
      </div>
    </q-card-section>
    <q-card-section>
      <q-input
        autofocus
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
        label="Log In"
        v-close-popup="signInSuccess"
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
  data() {
    return {
      user: {
        email: "",
        password: ""
      },
      errorMessage: "",
      signInSuccess: false
    };
  },
  computed: {
    ...mapGetters("pharmaStore", ["getUser"])
  },
  methods: {
    ...mapActions("pharmaStore", ["signIn"]),
    async handleSubmit() {
      const success = await this.signIn({ user: this.user });
      if (success && this.getUser.is_pharmacy) {
        this.$router.push({ name: "pharmaToday" });
        this.signInSuccess = true;
      } else if (success && this.getUser.is_courier) {
        this.$router.push({ name: "courierToday" });
        this.signInSuccess = true;
      } else if (!success) {
        this.errorMessage = "Error with the sign in process. Please try again.";
      }
    }
  }
};
</script>

<style></style>
