<template>
  <div class="flex justify-center gap-2 mb-6">
    <input
      v-model="artistName"
      type="text"
      placeholder="Enter artist"
      class="px-4 py-2 rounded bg-gray-800 text-white border border-gray-600"
    />
    <button
      @click="startGame"
      class="bg-green-500 hover:bg-green-600 text-white font-bold px-4 py-2 rounded"
    >
      Start Game
    </button>
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
