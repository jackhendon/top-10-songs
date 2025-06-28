<template>
  <tr class="miss-row">
    <td>{{ miss.rank ? `#${miss.rank}` : "—" }}</td>
    <td>{{ miss.title }}</td>
    <td>{{ miss.streams?.toLocaleString() || "—" }}</td>
  </tr>
</template>
<script setup>
  const props = defineProps({ miss: Object });
</script>
<style scoped>
  .miss-row {
    background-color: #1f2937;
    color: #94a3b8;
  }
</style>
