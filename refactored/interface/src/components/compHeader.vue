<template>
  <header class="news-header">
    <nav>
      <ul>
        <li :class="{ active: isLinkActive('/users') }">
          <a href="#/users">Users</a>
        </li>
        <li :class="{ active: isLinkActive('/survey-results') }">
          <a href="#/survey-results">Survey Results</a>
        </li>
        <li :class="{ active: isLinkActive('/survey-stats') }">
          <a href="#/survey-stats">Survey Stats</a>
        </li>
      </ul>
    </nav>
  </header>
</template>

<script>
export default {
  name: "PageCompHeader",
  methods: {
    isLinkActive(link) {
      return this.$route.path === link;
    },
  },
};
</script>

<style scoped>
.news-header {
  background-color: #333;
  padding: 20px 0;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
.news-header nav {
  width: 100%;
  max-width: 1200px;
}
.news-header ul {
  list-style: none;
  display: flex;
  justify-content: center;
  margin: 0;
  padding: 0;
}
.news-header ul li {
  margin: 0 15px;
}
.news-header ul li a {
  color: white;
  text-decoration: none;
  font-weight: bold;
  font-size: 16px;
  padding: 10px 15px;
  transition: background-color 0.3s, color 0.3s;
  border-radius: 5px;
}
.news-header ul li a:hover {
  background-color: #0056b3;
  color: #fff;
}
.news-header .active a {
  background-color: #0056b3;
  color: #ffffff;
}
</style>
