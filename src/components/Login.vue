<template>
  <div class="login">
    <router-link to="/register">Register</router-link>
    <h2>Login</h2>
    <input type="text" v-model="username" placeholder="Username" />
    <input type="password" v-model="password" placeholder="Password" />
    <button @click="handleLogin">Login</button>
    <p v-if="message">{{ message }}</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      username: '',
      password: '',
      message: ''
    };
  },
  methods: {
  async handleLogin() {
    try {
      const response = await axios.post('http://localhost:8080/login', {
        username: this.username,
        password: this.password
      });
      this.$store.commit('setToken', response.data.token);
      this.$router.push('/chat');
    } catch (error) {
        console.log(error);
      this.message = 'Login failed!';
    }
  }
}
};
</script>

<style scoped>
.login {
  max-width: 300px;
  margin: auto;
  text-align: center;
}
</style>