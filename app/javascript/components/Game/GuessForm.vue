<template>
  <div>
    <input
      v-model="modelValue"
      @keyup.enter="$emit('submit')"
      class="input"
      :disabled="disabled"
      placeholder="Song title"
    />
    <p v-if="error" class="error-msg">{{ error }}</p>
    <div class="button-row">
      <button @click="$emit('submit')" :disabled="disabled" class="button">
        Guess
      </button>
      <button v-if="!disabled" @click="$emit('give-up')" class="button-alt">
        Give Up
      </button>
    </div>
  </div>
</template>
<script setup>
  import { toRefs } from "vue";
  const props = defineProps({
    modelValue: String,
    error: String,
    disabled: Boolean,
  });
  const emit = defineEmits(["submit", "give-up", "update:modelValue"]);
  watch(
    () => props.modelValue,
    (val) => emit("update:modelValue", val)
  );
</script>
<style scoped>
  .input {
    width: 100%;
    padding: 0.5rem 1rem;
    margin-bottom: 1rem;
    border-radius: 0.375rem;
    border: 1px solid #4b5563;
    background-color: #1f2937;
    color: #fff;
  }

  .button {
    padding: 0.5rem 1.25rem;
    background-color: #22c55e;
    border: none;
    border-radius: 0.375rem;
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    margin-bottom: 1rem;
  }

  .button-row {
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
  }

  .button-alt {
    background-color: #64748b;
    padding: 0.5rem 1.25rem;
    border: none;
    border-radius: 0.375rem;
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    margin-bottom: 1rem;
  }

  .button-alt:hover {
    background-color: #475569;
  }

  .error-msg {
    color: #f87171;
    margin-top: 0.5rem;
    text-align: center;
  }
</style>
