<template>
  <tr class="miss-row">
    <td class="col-rank">
      {{ miss.rank ? `#${miss.rank}` : "—" }}
    </td>
    <td class="col-title">
      {{ miss.title }}
    </td>
    <td class="col-streams">
      {{ miss.streams?.toLocaleString() || "—" }}
    </td>
  </tr>
</template>

<script setup>
  const props = defineProps({ miss: Object });
</script>
<style scoped>
  .miss-row td {
    color: #94a3b8;
    background: transparent;
  }
</style>
