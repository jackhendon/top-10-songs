<template>
  <h2 class="heading">{{ artist }}</h2>
  <p class="copy">Guess their top 10 songs</p>
</template>
<script setup>
  const props = defineProps({ artist: String });
</script>
<style scoped>
  .heading {
    font-size: 1.5rem;
    font-weight: bold;
  }

  .copy {
    color: #9ca3af;
    margin: 0px 0px 16px 0px;
  }
</style>
