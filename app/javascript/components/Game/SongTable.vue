<template>
  <h3>Top 10 Songs</h3>
  <table class="song-table">
    <thead>
      <tr>
        <th class="rank-column">#</th>
        <th>Song</th>
        <th>Streams</th>
      </tr>
    </thead>
    <tbody>
      <slot name="body" />
    </tbody>
  </table>
</template>
<script setup></script>
<style scoped>
  .song-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 8px;
  }

  .song-table th {
    background-color: #374151;
    font-weight: 600;
    height: 40px;
  }

  .rank-column {
    padding-left: 8px;
  }
</style>
