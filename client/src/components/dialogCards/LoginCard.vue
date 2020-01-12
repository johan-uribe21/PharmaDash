<template>
  <q-card style="min-width: 350px">
    <q-card-section>
      <div class="text-h6">
        Log in
      </div>
    </q-card-section>
    <q-card-section>
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
      <q-btn flat @click="handleSubmit" label="Log In" v-close-popup />
    </q-card-actions>
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
      }
    };
  },
  methods: {
    ...mapActions("pharmaStore", ["signIn"]),
    async handleSubmit() {
      await this.signIn({ user: this.user });
    }
  }
};
</script>

<style></style>
