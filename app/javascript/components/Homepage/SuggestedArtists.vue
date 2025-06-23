<template>
  <div>
    <p class="text-center text-gray-400 mb-3">Or choose a suggested artist:</p>
    <div class="flex flex-wrap justify-center gap-3">
      <button
        v-for="name in suggestions"
        :key="name"
        @click="$emit('submit', name)"
        class="bg-gray-800 text-white px-4 py-2 rounded hover:bg-gray-700"
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
