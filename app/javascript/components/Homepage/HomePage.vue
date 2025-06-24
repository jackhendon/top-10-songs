<template>
  <div class="homepage">
    <TitleHeader />
    <ArtistSearch @submit="handleArtistSelect" />
    <SuggestedArtistCards @submit="handleArtistSelect" />
  </div>
</template>

<script setup>
  import { useRouter } from "vue-router";
  import TitleHeader from "./Title.vue";
  import ArtistSearch from "./ArtistSearch.vue";
  import SuggestedArtistCards from "./SuggestedArtists.vue";

  const router = useRouter();

  function handleArtistSelect(name) {
    router.push(`/game/${encodeURIComponent(name)}`);
  }
</script>

<style>
  .homepage {
    min-height: 100vh;
    background-color: #0f172a;
    color: #f1f5f9;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 2rem;
  }
</style>
