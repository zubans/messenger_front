<template>
    <div class="register">
      <h2>Register</h2>
      <input type="text" v-model="username" placeholder="Username" />
      <input type="email" v-model="email" placeholder="Email" />
      <input type="password" v-model="password" placeholder="Password" />
      <button @click="handleRegister">Register</button>
      <p v-if="message">{{ message }}</p>
    </div>
  </template>
  
  <script>
  import axios from "axios";
  
  export default {
    data() {
      return {
        username: "",
        email: "",
        password: "",
        message: ""
      };
    },
    methods: {
      async handleRegister() {
        try {
          await axios.post("http://localhost:8080/register", {
            username: this.username,
            email: this.email,
            password: this.password
          });
          this.message = "Registration successful!";
          this.$router.push("/"); // Вернемся на страницу логина
        } catch (error) {
          this.message = "Registration failed!";
        }
      }
    }
  };
  </script>
  
  <style scoped>
  .register {
    max-width: 300px;
    margin: auto;
    text-align: center;
  }
  </style>