<template>
  <q-page class="flex flex-center">
    Orders Today
  </q-page>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "OrdersTodays",
  data() {
    return {};
  },
  computed: {
    ...mapGetters("pharmaStore", ["getUser"]),
    user() {
      return this.getUser;
    }
  },
  methods: {
    ...mapActions("pharmaStore", ["setUser"])
  },
  created() {
    this.setUser("Bob Bennet");
  }
};
</script>

<style></style>
