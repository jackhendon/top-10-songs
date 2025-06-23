<template>
  <div
    class="min-h-screen bg-black text-white p-6 flex flex-col items-center justify-center"
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
