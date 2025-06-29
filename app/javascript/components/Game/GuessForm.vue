<template>
  <div class="guess-form">
    <div class="input-group">
      <input
        v-model="inputValue"
        @keyup.enter="onSubmit"
        class="input"
        :disabled="disabled"
        placeholder="Enter song name..."
      />
      <button @click="onSubmit" :disabled="disabled" class="button">
        Guess
      </button>
    </div>
    <p v-if="error" class="error-msg">{{ error }}</p>
  </div>
</template>

<script setup>
  import { computed } from "vue";

  const props = defineProps({
    modelValue: { type: String, default: "" },
    error: String,
    disabled: Boolean,
  });

  const emit = defineEmits(["update:modelValue", "submit"]);

  const inputValue = computed({
    get: () => props.modelValue,
    set: (val) => emit("update:modelValue", val),
  });

  function onSubmit() {
    emit("submit");
  }
</script>

<style scoped>
  .guess-form {
    width: 100%;
  }

  .input-group {
    display: flex;
    align-items: center;
    width: 100%;
    gap: 0.5rem;
    margin-bottom: 0.5rem;
  }

  .input {
    flex: 1;
    padding: 0.75rem 1rem;
    border-radius: 0.5rem;
    border: 1px solid #334155;
    background-color: #1e293b;
    color: #f1f5f9;
    font-size: 1rem;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
  }

  .input:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3);
  }

  .input::placeholder {
    color: #64748b;
  }

  .button {
    padding: 0.75rem 1.25rem;
    font-weight: 600;
    font-size: 0.95rem;
    border-radius: 0.5rem;
    border: none;
    background-color: #16a34a;
    color: #fff;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }

  .button:hover {
    background-color: #16a34ada;
  }

  .error-msg {
    color: #f87171;
    font-size: 0.875rem;
    text-align: center;
  }
</style>
