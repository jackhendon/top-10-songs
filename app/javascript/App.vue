<template>
  <div id="app" class="app-layout">
    <NavBar />
    <router-view />
    <Footer />
  </div>
</template>

<script setup>
  import NavBar from "./components/NavBar.vue";
  import Footer from "./components/Footer.vue";
</script>

<style>
  .app-layout {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
  }
</style>
