<template>
  <nav class="navbar">
    <div class="navbar__logo">
      <!-- Replace with your actual logo SVG or image -->
      <img :src="logoUrl" alt="SongGuesser Logo" class="navbar__logo-img" />

      <span class="navbar__title">SongGuesser</span>
    </div>

    <button class="navbar__signin" @click="onSignIn">Sign In</button>
  </nav>
</template>

<script setup>
  import logoUrl from "../images/logo.png";

  function onSignIn() {
    // TODO: wire up real auth flow
    alert("Sign in clicked!");
  }
</script>

<style scoped>
  .navbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: rgb(31 41 55 / var(--tw-bg-opacity, 1));
    padding: 0.75rem 1.5rem;
    color: #f1f5f9;
    box-shadow: 0 4px 8px 2px rgba(0, 0, 0, 0.5);
  }

  .navbar__logo {
    display: flex;
    align-items: center;
  }

  .navbar__logo-img {
    height: 1.75rem;
    margin-right: 0.5rem;
  }

  .navbar__title {
    font-size: 1.25rem;
    font-weight: 700;
  }

  .navbar__signin {
    background-color: #3b82f6; /* blue-500 */
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.2s;
  }

  .navbar__signin:hover {
    background-color: #2563eb; /* blue-600 */
  }
</style>
