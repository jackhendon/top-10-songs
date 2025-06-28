<template>
  <footer class="footer">
    <div class="footer__content">
      <span>© 2025 SongGuesser</span>
      <nav class="footer__nav">
        <a href="#" @click.prevent="onAbout">About</a>
        <a href="#" @click.prevent="onHelp">Help</a>
      </nav>
    </div>
  </footer>
</template>

<script setup>
  function onAbout() {
    // TODO: route to /about or open modal
    alert("About SongGuesser");
  }
  function onHelp() {
    // TODO: route to /help or open modal
    alert("Help center");
  }
</script>

<style scoped>
  .footer {
    background-color: #111827;
    color: #94a3b8;
    padding: 1rem 0;
    margin-top: auto;
  }
  .footer__content {
    max-width: 960px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    font-size: 0.875rem;
  }
  .footer__nav a {
    color: #94a3b8;
    margin-left: 1rem;
    text-decoration: none;
    transition: color 0.2s;
  }
  .footer__nav a:hover {
    color: #f1f5f9;
  }
</style>
