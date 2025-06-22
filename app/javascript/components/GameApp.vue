<template>
  <div class="p-4 max-w-xl mx-auto">
    <div v-if="!started">
      <input v-model="artist" placeholder="Enter artist" class="input" />
      <button @click="startGame" class="button">Start Game</button>
    </div>
    <div v-else>
      <h2>Guess Top 10 Songs for {{ artist }}</h2>
      <input
        v-model="guess"
        @keyup.enter="submitGuess"
        placeholder="Song title"
      />
      <button @click="submitGuess">Guess</button>
      <ul>
        <li v-for="res in results" :key="res.guess">
          {{ res.guess }} — {{ res.rank ? `#${res.rank}` : "Not in Top 100" }}
        </li>
      </ul>
      <p v-if="correctGuesses.length === 10" class="win">
        🎉 All top 10 songs guessed!
      </p>
    </div>
  </div>
</template>

<script setup>
  import { ref } from "vue";

  const artist = ref("");
  const guess = ref("");
  const results = ref([]);
  const correctGuesses = ref([]);
  const songs = ref([]);
  const started = ref(false);

  async function startGame() {
    const res = await fetch(
      `/api/songs?artist=${encodeURIComponent(artist.value)}`
    );
    songs.value = await res.json();
    results.value = [];
    correctGuesses.value = [];
    started.value = true;
  }

  function submitGuess() {
    const match = songs.value.find(
      (song) => song.title.toLowerCase() === guess.value.toLowerCase()
    );
    if (match) {
      results.value.push({ guess: guess.value, rank: match.rank });
      if (
        match.rank <= 10 &&
        !correctGuesses.value.includes(guess.value.toLowerCase())
      ) {
        correctGuesses.value.push(guess.value.toLowerCase());
      }
    } else {
      results.value.push({ guess: guess.value, rank: null });
    }
    guess.value = "";
  }
</script>
