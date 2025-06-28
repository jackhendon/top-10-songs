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
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    box-sizing: border-box;
    overflow: auto;
  }
</style>
