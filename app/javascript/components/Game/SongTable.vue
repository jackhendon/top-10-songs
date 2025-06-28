<template>
  <table class="song-table">
    <thead>
      <tr>
        <th>#</th>
        <th>Song Title</th>
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
    margin-top: 1.5rem;
    border-collapse: collapse;
    color: #f1f5f9;
  }

  .song-table th,
  .song-table td {
    padding: 0.75rem;
    border-bottom: 1px solid #334155;
    text-align: left;
  }

  .song-table th {
    background-color: #1e293b;
    font-weight: 600;
  }
</style>
