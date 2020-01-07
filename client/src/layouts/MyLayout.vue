<template>
  <q-layout view="hHh lpR fFf">
    <q-header reveal elevated class="bg-primary text-white" height-hint="98">
      <q-toolbar>
        <q-btn dense flat round icon="menu" @click="left = !left" />

        <q-toolbar-title>
          <q-icon name="directions_run" />
          PharmaDash
        </q-toolbar-title>
      </q-toolbar>

      <q-tabs align="left">
        <q-route-tab to="/pharmacy" label="Pharmacy Page" />
        <q-route-tab to="/courier" label="Courier Page" />
      </q-tabs>
    </q-header>

    <q-drawer
      show-if-above
      v-model="left"
      side="left"
      bordered
      content-class="bg-grey-3"
    >
      <q-scroll-area class="fit">
        <q-list v-for="(menuItem, index) in menuList" :key="index">
          <q-item
            :to="menuItem.route"
            clickable
            :active="menuItem.label === 'Outbox'"
            v-ripple
          >
            <q-item-section avatar>
              <q-icon :name="menuItem.icon" />
            </q-item-section>
            <q-item-section>
              {{ menuItem.label }}
            </q-item-section>
          </q-item>

          <q-separator v-if="menuItem.separator" />
        </q-list>
      </q-scroll-area>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>

    <q-footer elevated class="bg-grey-8 text-white">
      <q-toolbar>
        <q-toolbar-title>
          <q-icon name="directions_run" />
          PharmaDash
        </q-toolbar-title>
      </q-toolbar>
    </q-footer>
  </q-layout>
</template>

<script>
export default {
  data() {
    return {
      left: false,
      menuList: [
        {
          icon: "inbox",
          label: "Todays Orders",
          route: "pharmacy/orders_today",
          separator: true
        },
        {
          icon: "send",
          label: "All Orders",
          route: "pharmacy/orders_all",
          separator: false
        }
      ]
    };
  }
};
</script>
