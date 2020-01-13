<template>
  <div class="q-pa-md card-container">
    <q-table
      grid
      card-class="bg-primary text-white"
      :title="title"
      :data="courier ? getCouriers : getPatients"
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
    ...mapGetters("pharmaStore", ["getPatients", "getCouriers"])
  },
  data() {
    return {
      filter: "",
      selected: [],
      columns: [
        {
          name: "patientId",
          label: this.courier ? "Courier ID" : "Patient ID",
          field: "id",
          sortable: true
        },
        {
          name: "patientName",
          label: this.courier ? "Courier Name" : "Patient Name",
          field: "name",
          sortable: true
        },
        {
          name: "addressLineOne",
          label: "Address Line One",
          field: row => row.street
        },
        {
          name: "addressLineTwo",
          label: "Address Line Two",
          field: row => row.city + ", " + row.stateAbr + " " + row.zipcode
        }
      ]
    };
  },
  methods: {
    ...mapActions("pharmaStore", [])
  }
};
</script>

<style scoped>
.card-container {
  min-width: 450px;
  flex-grow: 1;
}
.card-class {
  min-width: 230px;
}
</style>
