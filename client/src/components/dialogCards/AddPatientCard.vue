<template>
  <q-card style="min-width: 350px">
    <q-card-section>
      <div class="text-h6">New Order Details</div>
    </q-card-section>

    <q-card-section>
      <q-input
        placeholder="Patient Name"
        dense
        v-model="data.patient.name"
        autofocus
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Street Address"
        dense
        v-model="data.patient.street"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="City"
        dense
        v-model="data.patient.city"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="State Abbreviation (OH, GA, etc.)"
        dense
        v-model="data.patient.stateAbr"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Zipcode"
        dense
        v-model="data.patient.zipcode"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
    </q-card-section>

    <q-card-actions align="right" class="text-primary">
      <q-btn flat label="Cancel" v-close-popup />
      <q-btn
        flat
        @click="handleSubmit"
        label="Submit New Patient"
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
        patient: {
          name: "",
          street: "",
          city: "",
          stateAbr: "",
          zipcode: ""
        }
      },
      createdPatientSuccess: false
    };
  },
  computed: {
    ...mapGetters("pharmaStore", ["getUser"])
  },
  methods: {
    ...mapActions("pharmaStore", ["submitNewPatient"]),
    async handleSubmit() {
      const success = await this.submitNewPatient({
        params: this.data,
        pharmacyId: this.getUser.pharmacy_id
      });
      if (success) this.createdPatientSuccess = true;
    }
  }
};
</script>

<style></style>
