<template>
  <nav class="footer">
    <div class="footer__logo">
      <a href="/" style="text-decoration: none; color: white; display: flex">
        <img :src="logoUrl" alt="SongGuesser Logo" class="footer__logo-img" />
        <span class="footer__title">SongGuesser</span>
      </a>
    </div>

    <span>© 2025 SongGuesser</span>
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
  .footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: rgb(31 41 55 / var(--tw-bg-opacity, 1));
    padding: 0.75rem 1.5rem;
    color: #f1f5f9;
    box-shadow: 0 4px 8px 2px rgba(0, 0, 0, 0.5);
  }

  .footer__logo {
    display: flex;
    align-items: center;
  }

  .footer__logo-img {
    height: 1.75rem;
    margin-right: 0.5rem;
  }

  .footer__title {
    font-size: 1.25rem;
    font-weight: 700;
  }

  .footer__signin {
    background-color: #3b82f6; /* blue-500 */
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.2s;
  }

  .footer__signin:hover {
    background-color: #2563eb; /* blue-600 */
  }
</style>
