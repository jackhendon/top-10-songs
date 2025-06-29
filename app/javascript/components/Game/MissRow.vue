<template>
  <tr class="miss-row">
    <td class="col-rank">
      {{ miss.rank ? `#${miss.rank}` : "—" }}
    </td>
    <td class="col-title">
      {{ miss.title }}
    </td>
    <td class="col-streams">
    <td>{{ formatStreams(miss.streams ?? streams) }}</td>
    </td>
  </tr>
</template>

<script setup>
  import { formatStreams } from "../../../helpers/format.js";

  const props = defineProps({ miss: Object });
</script>
<style scoped>
  .miss-row td {
    color: #94a3b8;
    background: transparent;
  }
</style>
