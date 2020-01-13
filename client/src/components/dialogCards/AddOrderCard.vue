<template>
  <q-card style="min-width: 350px">
    <q-card-section>
      <div class="text-h6">New Order Details</div>
    </q-card-section>

    <q-card-section>
      <q-select
        dense
        autofocus
        filled
        v-model="data.order.patientName"
        :options="patients"
        label="Select Patient"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-select
        dense
        autofocus
        filled
        v-model="data.order.courierName"
        :options="couriers"
        label="Select Courier"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        placeholder="Prescription Ids"
        filled
        dense
        v-model="data.order.rxIds"
        :rules="[val => !!val || 'Field is required']"
        lazy-rules
      />
      <q-input
        filled
        dense
        placeholder="Pickup Date"
        v-model="data.order.pickupDate"
        :rules="['data.order.pickupDate']"
      >
        <template v-slot:append>
          <q-icon name="event" class="cursor-pointer">
            <q-popup-proxy
              ref="qDateProxy"
              transition-show="scale"
              transition-hide="scale"
            >
              <q-date
                v-model="data.order.pickupDate"
                @input="() => $refs.qDateProxy.hide()"
                mask="YYYY-MM-DD"
              />
            </q-popup-proxy>
          </q-icon>
        </template>
      </q-input>
      <q-input
        dense
        filled
        placeholder="Pickup Time"
        v-model="data.order.pickupTime"
        mask="time"
        :rules="['data.order.pickupTime']"
      >
        <template v-slot:append>
          <q-icon name="access_time" class="cursor-pointer">
            <q-popup-proxy transition-show="scale" transition-hide="scale">
              <q-time v-model="data.order.pickupTime" />
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
      data: {
        order: {
          rxIds: "",
          pickupDate: "",
          pickupTime: "",
          courierName: "",
          patientName: ""
        }
      }
    };
  },
  computed: {
    ...mapGetters("pharmaStore", ["getPatients", "getCouriers", "getUser"]),
    patients() {
      return this.getPatients.map(e => e.name);
    },
    couriers() {
      return this.getCouriers.map(e => e.name);
    },
    orderParams() {
      const courierId = this.getCouriers.filter(
        e => e.name === this.data.order.courierName
      )[0].id;
      const patientId = this.getPatients.filter(
        e => e.name === this.data.order.patientName
      )[0].id;
      return {
        data: {
          order: { ...this.data.order, rxIds: this.data.order.rxIds.split(" ") }
        },
        patientId: patientId,
        courierId: courierId,
        pharmacyId: this.getUser.pharmacy_id
      };
    }
  },
  methods: {
    ...mapActions("pharmaStore", ["submitNewOrder"]),
    handleSubmit() {
      this.submitNewOrder(this.orderParams);
    }
  }
};
</script>

<style></style>
