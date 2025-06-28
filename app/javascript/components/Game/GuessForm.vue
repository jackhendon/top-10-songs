<template>
  <div>
    <input
      v-model="inputValue"
      @keyup.enter="onSubmit"
      class="input"
      :disabled="disabled"
      placeholder="Song title"
    />
    <p v-if="error" class="error-msg">{{ error }}</p>
    <div class="button-row">
      <button @click="onSubmit" :disabled="disabled" class="button">
        Guess
      </button>
      <button v-if="!disabled" @click="$emit('give-up')" class="button-alt">
        Give Up
      </button>
    </div>
  </div>
</template>

<script setup>
  import { computed } from "vue";

  const props = defineProps({
    modelValue: {
      type: String,
      default: "",
    },
    error: String,
    disabled: Boolean,
  });
  const emit = defineEmits(["update:modelValue", "submit", "give-up"]);

  // Create a local v-model proxy
  const inputValue = computed({
    get: () => props.modelValue,
    set: (val) => emit("update:modelValue", val),
  });

  function onSubmit() {
    emit("submit");
  }
</script>

<style scoped>
  .input {
    width: 100%;
    box-sizing: border-box;
    padding: 0.5rem 1rem;
    margin-bottom: 1rem;
    border-radius: 0.375rem;
    border: 1px solid #4b5563;
    background-color: #1f2937;
  }

  .button {
    padding: 0.5rem 1.25rem;
    background-color: #16a34a;
    color: #fff;
    border: none;
    border-radius: 0.375rem;
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
    background-color: #dc2626;
    color: #fff;
    padding: 0.5rem 1.25rem;
    border: none;
    border-radius: 0.375rem;

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
