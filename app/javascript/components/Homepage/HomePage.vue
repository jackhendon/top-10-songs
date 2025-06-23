<template>
  <div
    class="bg-dark flex flex-col text-main align-center justify-center items-center"
  >
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
