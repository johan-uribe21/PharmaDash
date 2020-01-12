<template>
  <q-layout view="hHh lpR fFf">
    <q-header reveal elevated class="bg-primary text-white" height-hint="98">
      <q-toolbar>
        <q-toolbar-title>
          <q-icon name="directions_run" />
          PharmaDash - Authentication
        </q-toolbar-title>
      </q-toolbar>
    </q-header>

    <q-page-container>
      <router-view class="fit" />
    </q-page-container>

    <q-footer elevated class="bg-grey-8 text-white">
      <q-toolbar>
        <q-toolbar-title>
          <q-icon name="directions_run" />
          PharmaDash - Authentication
        </q-toolbar-title>
      </q-toolbar>
    </q-footer>
  </q-layout>
</template>

<script>
export default {
  data() {
    return {};
  }
};
</script>
