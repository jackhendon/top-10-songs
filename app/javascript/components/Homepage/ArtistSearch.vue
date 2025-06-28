<template>
  <div class="search-bar">
    <input
      v-model="artistName"
      type="text"
      placeholder="Enter artist"
      class="search-input"
    />
    <button @click="startGame" class="search-button">Start Game</button>
  </div>
</template>

<script setup>
  import { defineEmits, ref } from "vue";
  const emit = defineEmits(["submit"]);
  const artistName = ref("");

  function startGame() {
    emit("submit", artistName.value);
  }
</script>

<style>
  .search-bar {
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    margin-bottom: 1.5rem;
  }

  .search-input {
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    background-color: #1f2937;
    color: #fff;
    border: 1px solid #4b5563;
  }

  .search-button {
    background-color: #22c55e;
    color: #fff;
    font-weight: 700;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    border: none;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }

  .search-button:hover {
    background-color: #16a34a;
  }
</style>
