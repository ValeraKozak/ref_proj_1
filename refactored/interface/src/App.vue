<template>
  <compHeader />
  <router-view></router-view>
</template>

<script>
import compHeader from './components/compHeader.vue';

export default {
  name: 'App',
  components: {
    compHeader,
  }
}
</script>

<style>

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
