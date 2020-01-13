<template>
  <q-card style="min-width: 350px">
    <q-card-section>
      <div class="text-h6">New Courier Details</div>
    </q-card-section>

    <q-card-section>
      <q-input
        placeholder="Courier Name"
        dense
        v-model="data.courier.name"
        autofocus
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Street Address"
        dense
        v-model="data.courier.street"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="City"
        dense
        v-model="data.courier.city"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="State Abbreviation (OH, GA, etc.)"
        dense
        v-model="data.courier.stateAbr"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Zipcode"
        dense
        v-model="data.courier.zipcode"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
    </q-card-section>

    <q-card-actions align="right" class="text-primary">
      <q-btn flat label="Cancel" v-close-popup />
      <q-btn
        flat
        @click="handleSubmit"
        label="Submit New Courier"
        v-close-popup
      />
    </q-card-actions>
  </q-card>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  data() {
    return {
      data: {
        courier: {
          name: "",
          street: "",
          city: "",
          stateAbr: "",
          zipcode: ""
        }
      },
      createdCourierSuccess: false
    };
  },
  computed: {
    ...mapGetters("pharmaStore", ["getUser"])
  },
  methods: {
    ...mapActions("pharmaStore", ["submitNewCourier"]),
    async handleSubmit() {
      const success = await this.submitNewCourier({
        params: this.data,
        pharmacyId: this.getUser.pharmacy_id
      });
      if (success) this.createdCourierSuccess = true;
    }
  }
};
</script>

<style></style>
