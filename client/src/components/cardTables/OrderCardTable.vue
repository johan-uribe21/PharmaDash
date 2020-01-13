<template>
  <div class="q-pa-md card-container">
    <q-table
      grid
      card-class="bg-primary text-white"
      :title="title"
      :data="today ? getOrdersToday : getOrdersAll"
      :columns="columns"
      row-key="name"
      :filter="filter"
      hide-header
      card-container-class="card-container"
    >
      <template v-slot:top-right>
        <q-input
          borderless
          dense
          debounce="300"
          v-model="filter"
          placeholder="Search by Any Field"
        >
          <template v-slot:append>
            <q-icon name="search" />
          </template>
        </q-input>
      </template>

      <template v-slot:item="props">
        <div class="q-pa-xs card-class">
          <q-card>
            <q-list dense>
              <q-item
                v-for="col in props.cols.filter(col => col.name !== 'desc')"
                :key="col.name"
              >
                <q-item-section>
                  <q-item-label caption>{{ col.label }}</q-item-label>
                  <q-item-label>{{ col.value }}</q-item-label>
                </q-item-section>
                <q-btn
                  v-if="
                    !courier && col.label === 'Active' && col.value === '\u2713'
                  "
                  @click="handleCancel(props.cols[0].value)"
                  :label="'Cancel Order'"
                  size="sm"
                  color="primary"
                  outline
                  rounded
                />
                <q-btn
                  v-if="
                    !courier && col.label === 'Active' && col.value === '\u2717'
                  "
                  @click="handleUncancel(props.cols[0].value)"
                  :label="'Uncancel Order'"
                  size="sm"
                  color="primary"
                  outline
                  rounded
                />
                <q-btn
                  v-if="
                    courier &&
                      col.label === 'Delivered' &&
                      col.value === '\u2717'
                  "
                  @click="handleDelivered(props.cols[0].value)"
                  :label="'Set Delivered'"
                  size="sm"
                  color="primary"
                  outline
                  rounded
                />
                <q-btn
                  v-if="
                    courier &&
                      col.label === 'Delivered' &&
                      col.value === '\u2713'
                  "
                  @click="handleNotDelivered(props.cols[0].value)"
                  :label="'Set Not Delivered'"
                  size="sm"
                  color="primary"
                  outline
                  rounded
                />
                <q-btn
                  v-if="
                    courier &&
                      col.label === 'Deliverable' &&
                      col.value === '\u2717'
                  "
                  @click="handleDeliverable(props.cols[0].value)"
                  :label="'Set Deliverable'"
                  size="sm"
                  color="primary"
                  outline
                  rounded
                />
                <q-btn
                  v-if="
                    courier &&
                      col.label === 'Deliverable' &&
                      col.value === '\u2713'
                  "
                  @click="handleNotDeliverable(props.cols[0].value)"
                  :label="'Set Not Deliverable'"
                  size="sm"
                  color="primary"
                  outline
                  rounded
                />
              </q-item>
            </q-list>
          </q-card>
        </div>
      </template>
    </q-table>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "OrderCardTable",
  props: ["title", "today", "courier"],
  computed: {
    ...mapGetters("pharmaStore", ["getOrdersAll", "getOrdersToday"])
  },
  data() {
    return {
      filter: "",
      selected: [],
      columns: [
        {
          name: "orderId",
          label: "Order Id",
          field: "id",
          sortable: true,
          style: "width: 500px"
        },
        {
          name: "patientId",
          label: "Patient ID",
          field: "patient_id",
          sortable: true
        },
        {
          name: "courierId",
          label: "Courier ID",
          field: "courier_id",
          sortable: true
        },
        {
          name: "rxIds",
          label: "Prescription Ids",
          field: "rxIds",
          format: (val, row) => `${val}`
        },
        {
          name: "pickupDateTime",
          label: "Pickup Date/Time",
          field: row => row.pickupDate + " @  " + row.pickupTime
        },
        {
          name: "active",
          label: "Active",
          field: "active",
          format: val => (val === true ? "\u2713" : "\u2717")
        },
        {
          name: "delivered",
          label: "Delivered",
          field: "delivered",
          format: val => (val === true ? "\u2713" : "\u2717")
        },
        {
          name: "deliverable",
          label: "Deliverable",
          field: "deliverable",
          format: val => (val === true ? "\u2713" : "\u2717")
        }
      ]
    };
  },
  methods: {
    ...mapActions("pharmaStore", [
      "loadOrderData",
      "cancelOrder",
      "uncancelOrder",
      "deliveredOrder",
      "undeliveredOrder",
      "deliverableOrder",
      "undeliverableOrder"
    ]),
    handleCancel(orderId) {
      this.cancelOrder(orderId);
    },
    handleUncancel(orderId) {
      this.uncancelOrder(orderId);
    },
    handleDelivered(orderId) {
      this.deliveredOrder(orderId);
    },
    handleNotDelivered(orderId) {
      this.undeliveredOrder(orderId);
    },
    handleDeliverable(orderId) {
      this.deliverableOrder(orderId);
    },
    handleNotDeliverable(orderId) {
      this.undeliverableOrder(orderId);
    }
  }
};
</script>

<style scoped>
.card-container {
  min-width: 450px;
  flex-grow: 1;
}
.card-class {
  min-width: 250px;
}
</style>
