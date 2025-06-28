<template>
  <div class="game-container">
    <div class="game-card">
      <GameHeader :artist="artist" />

      <GuessForm
        v-model="guess"
        :error="errorMessage"
        :disabled="revealed"
        @submit="submitGuess"
        @give-up="giveUp"
      />

      <SongTable>
        <template #body>
          <SongRow
            v-for="n in 10"
            :key="n"
            :rank="n"
            :song="topTen[n - 1]"
            :streams="streamsByRank[n]"
            :clickable="!topTen[n - 1] && !revealed"
            @reveal="revealSlot(n - 1)"
          />
          <MissRow
            v-for="miss in sortedMisses"
            :key="miss.title"
            :miss="miss"
          />
        </template>
      </SongTable>

      <WinMessage v-if="revealed" />
    </div>
  </div>
</template>

<script setup>
  import { ref, onMounted, computed } from "vue";
  import { useRoute } from "vue-router";
  import Fuse from "fuse.js";

  import GameHeader from "./GameHeader.vue";
  import GuessForm from "./GuessForm.vue";
  import SongTable from "./SongTable.vue";
  import SongRow from "./SongRow.vue";
  import MissRow from "./MissRow.vue";
  import WinMessage from "./WinMessage.vue";

  const route = useRoute();
  const artist = ref(decodeURIComponent(route.params.artist));

  const guess = ref("");
  const songs = ref([]);
  const started = ref(false);
  const revealed = ref(false);

  const topTen = ref(Array(10).fill(null));
  const misses = ref([]);
  const streamsByRank = ref({});
  const errorMessage = ref("");

  // declare fuse and its options
  let fuse;
  const fuseOptions = {
    keys: ["title"],
    threshold: 0.1,
    distance: 100,
    ignoreLocation: true,
    minMatchCharLength: 3,
    includeScore: true,
  };

  async function startGame() {
    const res = await fetch(
      `/api/songs?artist=${encodeURIComponent(artist.value)}`,
      { headers: { Accept: "application/json" } }
    );
    const data = await res.json();

    if (!Array.isArray(data)) {
      alert(data.error || "Something went wrong.");
      return;
    }

    // keep only the top 150 by rank
    const limited = data.filter((s) => s.rank <= 150);

    songs.value = limited;
    topTen.value = Array(10).fill(null);
    misses.value = [];
    streamsByRank.value = {};

    // build streams lookup
    limited.forEach((s) => {
      if (s.rank <= 150) {
        streamsByRank.value[s.rank] = s.streams.toLocaleString();
      }
    });

    // initialize Fuse on the truncated list
    fuse = new Fuse(limited, fuseOptions);

    guess.value = "";
    started.value = true;
    revealed.value = false;
  }

  function normalize(str) {
    return str
      .toLowerCase()
      .replace(/\(.*?\)/g, "")
      .replace(/[-–—].*$/, "")
      .replace(/[^a-z0-9]/g, "")
      .trim();
  }

  function submitGuess() {
    const raw = guess.value.trim();
    if (raw.length < 3) {
      errorMessage.value = "Please enter at least 3 characters.";
      setTimeout(() => (errorMessage.value = ""), 2000);
      return;
    }

    if (!fuse) {
      console.warn("Fuse not ready yet");
      return;
    }

    // get all matches and filter by score
    const results = fuse.search(raw);
    const goodMatches = results
      .filter((r) => r.score <= 0.15)
      .map((r) => r.item);

    if (goodMatches.length === 0) {
      errorMessage.value = `No close match for “${raw}”.`;
      setTimeout(() => (errorMessage.value = ""), 3000);
    } else {
      goodMatches.forEach((match) => {
        if (match.rank <= 10) {
          const idx = match.rank - 1;
          if (!topTen.value[idx]) {
            topTen.value[idx] = {
              title: match.title,
              streams: match.streams,
            };
          }
        } else {
          if (!misses.value.find((m) => m.title === match.title)) {
            misses.value.push({
              title: match.title,
              streams: match.streams,
              rank: match.rank,
            });
          }
        }
      });
    }

    guess.value = "";
    if (topTen.value.filter(Boolean).length === 10) {
      revealed.value = true;
    }
  }

  function giveUp() {
    for (let i = 0; i < 10; i++) {
      if (!topTen.value[i]) {
        const song = songs.value.find((s) => s.rank === i + 1);
        if (song) {
          topTen.value[i] = {
            title: song.title,
            streams: song.streams,
          };
        }
      }
    }
    revealed.value = true;
  }

  function revealSlot(index) {
    if (topTen.value[index] || revealed.value) return;
    const song = songs.value.find((s) => s.rank === index + 1);
    if (song) {
      topTen.value[index] = {
        title: song.title,
        streams: song.streams,
      };
    }
    if (topTen.value.filter(Boolean).length === 10) {
      revealed.value = true;
    }
  }

  const sortedMisses = computed(() => {
    return [...misses.value].sort((a, b) => {
      if (a.rank && b.rank) return a.rank - b.rank;
      if (a.rank) return -1;
      if (b.rank) return 1;
      return 0;
    });
  });

  onMounted(() => {
    startGame();
  });
</script>

<style scoped>
  .game-container {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    box-sizing: border-box;
    overflow: auto;
  }

  .game-card {
    background-color: #1e293b;
    border-radius: 0.75rem;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    max-width: 600px;
    width: 100%;
    text-align: left;
  }

  .game-card .song-table th {
    background-color: transparent;
    color: #e2e8f0;
  }
</style>
