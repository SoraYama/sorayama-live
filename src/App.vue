<template>
  <div id="app">
    <Main />
    <div class="audience">
      观众：{{audience}}
    </div>
  </div>
</template>

<script>
import Main from './components/Main.vue'
import io from './socket'

export default {
  data() {
    return {
      audience: 0,
    }
  },
  mounted() {
    io.on('audience', count => this.audience = count)
  },
  components: {
    Main,
  },
}
</script>

<style lang="less">
body {
  background-image: url('./assets/fleet.jpg');
  background-size: 100vw auto;
  background-repeat: no-repeat;
}

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

.audience {
  font-size: 20px;
  color: #00f56c;
  position: absolute;
  font-weight: 800;
  top: 10px;
  right: 10px;
}
</style>
