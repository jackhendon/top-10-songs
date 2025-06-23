<template>
  <div class="p-4 max-w-xl mx-auto">
    <div v-if="!started">
      <input v-model="artist" placeholder="Enter artist name" />
      <button @click="startGame">Start Game</button>
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
  import { ref, onMounted } from "vue";

  const props = defineProps({
    artist: String,
  });

  const artist = ref(props.artist || "");
  const guess = ref("");
  const results = ref([]);
  const correctGuesses = ref([]);
  const songs = ref([]);
  const started = ref(false);

  onMounted(() => {
    if (artist.value) {
      startGame();
    }
  });

  async function startGame() {
    const res = await fetch(
      `/api/songs?artist=${encodeURIComponent(artist.value)}`,
      {
        headers: { Accept: "application/json" },
      }
    );

    const data = await res.json();
    if (Array.isArray(data)) {
      songs.value = data;
      results.value = [];
      correctGuesses.value = [];
      started.value = true;
    } else {
      alert(data.error || "Something went wrong.");
    }
  }

  function normalize(str) {
    return str
      .toLowerCase()
      .replace(/[^a-z0-9]/g, "")
      .trim();
  }

  function submitGuess() {
    if (!Array.isArray(songs.value)) return;

    const normalizedGuess = normalize(guess.value);
    const match = songs.value.find(
      (song) => normalize(song.title) === normalizedGuess
    );

    if (match) {
      results.value.push({ guess: guess.value, rank: match.rank });
      if (match.rank <= 10 && !correctGuesses.value.includes(normalizedGuess)) {
        correctGuesses.value.push(normalizedGuess);
      }
    } else {
      results.value.push({ guess: guess.value, rank: null });
    }

    guess.value = "";
  }
</script>
