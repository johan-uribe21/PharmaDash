<template>
  <div class="q-pa-md card-container">
    <q-table
      grid
      card-class="bg-primary text-white"
      :title="title"
      :data="today ? ordersToday : ordersAll"
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
                  v-if="col.label === 'Active'"
                  @click="handleCancel(props.cols[0].value)"
                  :label="
                    col.value === '\u2713' ? 'Cancel Order' : 'Uncancel Order'
                  "
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
  props: ["title", "today"],
  computed: {
    ...mapGetters("pharmaStore", ["ordersAll", "ordersToday"])
  },
  data() {
    return {
      filter: "",
      selected: [],
      columns: [
        {
          name: "orderId",
          label: "Order Id Num.",
          field: "orderId",
          sortable: true,
          style: "width: 500px"
        },
        {
          name: "patientName",
          label: "Patient Name",
          field: "patientName",
          sortable: true
        },
        {
          name: "patientAddress1",
          label: "Patient Address",
          field: row => row.patientAddress.street,
          sortable: true
        },
        {
          name: "patientAddress2",
          field: row =>
            `${row.patientAddress.city}, ${row.patientAddress.stateAbr} ${row.patientAddress.zipcode}`,
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
          format: val => (val ? "\u2713" : "\u2717")
        }
      ]
    };
  },
  methods: {
    ...mapActions("pharmaStore", ["loadOrdersToday"]),
    handleGetOrdersToday() {
      this.getOrdersToday();
    },
    handleCancel(orderId) {
      console.log("Cancel order", orderId);
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
  min-width: 200px;
}
</style>
