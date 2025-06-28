<template>
  <h2 class="heading">Guess Top 10 Songs for {{ artist }}</h2>
</template>
<script setup>
  const props = defineProps({ artist: String });
</script>
<style scoped>
  .heading {
    font-size: 1.25rem;
    font-weight: bold;
    margin-bottom: 1rem;
  }
</style>
