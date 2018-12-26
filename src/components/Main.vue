<template>
  <main>
    <video ref="videoLive" id="videoElement" autoplay controls />
  </main>
</template>

<style lang="less" scoped>
main {
  video {
    display: block;
    width: 80vw;
    height: 80vh;
    margin: auto;
  }
}
</style>


<script lang="ts">
import Vue from 'vue';
import flvjs from 'flv.js';

interface MainData {
  url: string;
  player?: flvjs.Player;
}

export default Vue.extend({
  data(): MainData {
    return {
      url: `http://play.sorayamah.org/live/${location.search.slice(1) || 'sorayama'}.flv`,
      player: undefined,
    };
  },

  created() {
    if (flvjs.isSupported()) {
      this.player = flvjs.createPlayer({
        type: 'flv',
        url: this.url,
        hasAudio: true,
        hasVideo: true,
        isLive: true,
        cors: true,
      }, {
        lazyLoadMaxDuration: 60,
      });
    }
  },

  mounted() {
    if (this.player) {
      this.player.attachMediaElement(this.$refs.videoLive as HTMLMediaElement);
      this.player.load();
    }
  },

  methods: {
    handleLoadClick() {
      this.player && this.player.unload();
      this.player && this.player.load();
    },
  },
});
</script>
