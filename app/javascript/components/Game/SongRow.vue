<!-- SongRow.vue -->
<template>
  <tr
    :class="['song-row', { clickable }]"
    @click.prevent="clickable && $emit('reveal')"
  >
    <td class="col-rank">#{{ rank }}</td>

    <td class="col-title">
      <template v-if="song">
        {{ song.title }}
      </template>
      <template v-else>
        <span class="placeholder"> — </span>
      </template>
    </td>

    <td class="col-streams">
    <td>{{ formatStreams(song?.streams ?? streams) }}</td>
    </td>
  </tr>
</template>

<script setup>
  import { formatStreams } from '../../../helpers/format.js';



  const props = defineProps({
    rank: Number,
    song: Object,
    streams: String,
    clickable: Boolean,
  });
</script>

<style>
  .song-row,
  .miss-row {
    transition: background-color 0.2s;
    height: 40px;
  }
  .song-row.clickable {
    cursor: pointer;
  }
  .song-row.clickable:hover {
    background-color: #334155;
  }

  .col-rank {
    width: 10%;
    padding-left: 8px;
    color: #e2e8f0;
  }

  .col-title {
    width: 70%;
    color: #fff;
    font-weight: 500;
  }
  .col-streams {
    width: 20%;
    color: #fff;
  }

  .placeholder {
    display: inline-flex;
    align-items: center;
    opacity: 0.6;
  }
</style>
