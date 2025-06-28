<template>
  <div class="game-container">
    <div class="game-box">
      <GameHeader :artist="artist" />

      <GuessForm
        v-model:guess="guess"
        :disabled="revealed"
        :error="errorMessage"
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
  import { ref, onMounted } from "vue";
  import { useRoute } from "vue-router";

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
      topTen.value = Array(10).fill(null);
      misses.value = [];
      streamsByRank.value = {};

      data.slice(0, 100).forEach((s) => {
        streamsByRank.value[s.rank] = s.streams?.toLocaleString() || "—";
      });

      guess.value = "";
      started.value = true;
      revealed.value = false;
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
    const normalizedGuess = normalize(guess.value);
    const match = songs.value.find(
      (song) => normalize(song.title) === normalizedGuess
    );

    if (match && match.rank <= 10) {
      const index = match.rank - 1;
      if (!topTen.value[index]) {
        topTen.value[index] = {
          title: match.title,
          streams: match.streams,
        };
      }
    } else if (match) {
      if (!misses.value.some((m) => normalize(m.title) === normalizedGuess)) {
        misses.value.push({
          title: match.title,
          streams: match.streams,
          rank: match.rank,
        });
      }
    } else {
      errorMessage.value = `No match found for "${guess.value}". Please try again.`;
      setTimeout(() => {
        errorMessage.value = "";
      }, 3000);
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

  onMounted(() => {
    startGame();
  });

  import { computed } from "vue";

  const sortedMisses = computed(() => {
    return [...misses.value].sort((a, b) => {
      if (a.rank && b.rank) return a.rank - b.rank;
      if (a.rank) return -1;
      if (b.rank) return 1;
      return 0;
    });
  });
</script>

<style scoped>
  .game-container {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
    background-color: #0f172a;
    color: #f1f5f9;
    padding: 2rem;
  }

  .game-box {
    max-width: 480px;
    width: 100%;
    text-align: center;
  }

  .input {
    width: 100%;
    padding: 0.5rem 1rem;
    margin-bottom: 1rem;
    border-radius: 0.375rem;
    border: 1px solid #4b5563;
    background-color: #1f2937;
    color: #fff;
  }

  .button {
    padding: 0.5rem 1.25rem;
    background-color: #22c55e;
    border: none;
    border-radius: 0.375rem;
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    margin-bottom: 1rem;
  }

  .button-row {
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
  }

  .button-alt {
    background-color: #64748b;
    padding: 0.5rem 1.25rem;
    border: none;
    border-radius: 0.375rem;
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    margin-bottom: 1rem;
  }

  .button-alt:hover {
    background-color: #475569;
  }

  .song-table {
    width: 100%;
    margin-top: 1.5rem;
    border-collapse: collapse;
    color: #f1f5f9;
  }

  .song-table th,
  .song-table td {
    padding: 0.75rem;
    border-bottom: 1px solid #334155;
    text-align: left;
  }

  .song-table th {
    background-color: #1e293b;
    font-weight: 600;
  }

  .top-row.clickable {
    cursor: pointer;
  }

  .top-row.clickable:hover {
    background-color: #334155;
  }

  .miss-row {
    background-color: #1f2937;
    color: #94a3b8;
  }

  .win {
    margin-top: 1rem;
    font-size: 1.1rem;
    font-weight: bold;
    color: #4ade80;
  }

  .error-msg {
    color: #f87171;
    margin-top: 0.5rem;
    text-align: center;
  }
</style>
