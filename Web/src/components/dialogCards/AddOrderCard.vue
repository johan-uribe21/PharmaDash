<template>
  <q-card style="min-width: 350px">
    <q-card-section>
      <div class="text-h6">New Order Details</div>
    </q-card-section>

    <q-card-section>
      <q-input
        placeholder="Patient Name"
        dense
        v-model="orderDetails.patientName"
        autofocus
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Patient Address Line One"
        dense
        v-model="orderDetails.patientAddressLineOne"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Patient Address Line Two"
        dense
        v-model="orderDetails.patientAddressLineTwo"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Prescription Ids"
        dense
        v-model="orderDetails.rxIds"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Pickup Date"
        v-model="orderDetails.pickupDate"
        mask="date"
        :rules="['date']"
      >
        <template v-slot:append>
          <q-icon name="event" class="cursor-pointer">
            <q-popup-proxy
              ref="qDateProxy"
              transition-show="scale"
              transition-hide="scale"
            >
              <q-date
                v-model="orderDetails.pickupDate"
                @input="() => $refs.qDateProxy.hide()"
              />
            </q-popup-proxy>
          </q-icon>
        </template>
      </q-input>
      <q-input
        placeholder="Pickup Time"
        v-model="orderDetails.pickupTime"
        mask="time"
        :rules="['time']"
      >
        <template v-slot:append>
          <q-icon name="access_time" class="cursor-pointer">
            <q-popup-proxy transition-show="scale" transition-hide="scale">
              <q-time v-model="orderDetails.pickupTime" />
            </q-popup-proxy>
          </q-icon>
        </template>
      </q-input>
    </q-card-section>

    <q-card-actions align="right" class="text-primary">
      <q-btn flat label="Cancel" v-close-popup />
      <q-btn
        flat
        @click="handleSubmit"
        label="Submit New Order"
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
      orderDetails: {
        patientName: "",
        patientAddressLineOne: "",
        patientAddressLineTwo: "",
        rxIds: "",
        pickupDate: "",
        pickupTime: ""
      }
    };
  },
  computed: {
    ...mapGetters("pharmaStore", [""])
  },
  methods: {
    ...mapActions("pharmaStore", ["submitNewOrder"]),
    handleSubmit() {
      this.submitNewOrder(this.orderDetails);
    }
  }
};
</script>

<style></style>
