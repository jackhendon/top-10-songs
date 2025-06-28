<template>
  <tr
    :class="[{ clickable }, 'top-row']"
    @click.prevent="clickable && $emit('reveal')"
  >
    <td>#{{ rank }}</td>
    <td>{{ song?.title || "—" }}</td>
    <td>{{ song?.streams?.toLocaleString() || streams }}</td>
  </tr>
</template>
<script setup>
  const props = defineProps({
    rank: Number,
    song: Object,
    streams: String,
    clickable: Boolean,
  });
</script>
<style scoped>
  .top-row.clickable {
    cursor: pointer;
  }

  .top-row.clickable:hover {
    background-color: #334155;
  }
</style>
