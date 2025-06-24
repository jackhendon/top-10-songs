<template>
  <div>
    <p class="suggestion-label">Or choose a suggested artist:</p>
    <div class="suggestion-list">
      <button
        v-for="name in suggestions"
        :key="name"
        @click="$emit('submit', name)"
        class="suggestion-button"
      >
        {{ name }}
      </button>
    </div>
  </div>
</template>

<script setup>
  defineProps({
    suggestions: {
      type: Array,
      default: () => ["Taylor Swift", "The Weeknd", "Drake", "Ariana Grande"],
    },
  });
</script>

<style>
  .suggestion-label {
    text-align: center;
    color: #94a3b8;
    margin-bottom: 1rem;
  }

  .suggestion-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 0.75rem;
  }

  .suggestion-button {
    background-color: #1f2937;
    color: #ffffff;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    border: none;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }

  .suggestion-button:hover {
    background-color: #374151;
  }
</style>
