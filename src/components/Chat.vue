<template>
  <div class="chat">
    <h2>Chat Room</h2>
    <div id="messages" style="height: 300px; text-align: left; overflow: auto; border: 1px solid #ccc; padding: 10px; margin-bottom: 10px;">
      <p v-for="message in messages" :key="message">
        <strong>{{ message.username }}</strong>: {{ message.text }}
      </p>
    </div>
    <input type="text" v-model="newMessage" @keyup.enter="sendMessage" placeholder="Type a message"/>
    <button @click="sendMessage">Send</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      newMessage: '',
      messages: [],
      ws: null
    };
  },
  mounted() {
    if (!this.$store.getters.isAuthenticated) {
      this.$router.push('/'); // Если не аутентифицирован, вернёмся на логин
      return;
    }

    // const token = localStorage.getItem('token');
    
    this.ws = new WebSocket('ws://localhost:8080/ws');

    this.ws.onopen = () => {
      console.log('Connected to the chat server');
    };

    this.ws.onmessage = (event) => {
      const response = JSON.parse(event.data);
      this.messages.push({
        username: response.username,
        text: response.message
      });
    };

    this.ws.onclose = () => {
      console.log('Disconnected from the chat server');
    };

    this.ws.onerror = (error) => {
      console.error('WebSocket error', error);
    };
  },

  methods: {
    async sendMessage() {
      const token = localStorage.getItem('token');
      const messageData = {
        token: token,
        message: this.newMessage
      };
      
      this.ws.send(JSON.stringify(messageData));
      this.newMessage = '';
    },
    
    logout() {
      this.$store.dispatch('logout'); // Логаут и очистка данных
      this.$router.push('/');
    }
  }
};
</script>

<style scoped>
.chat {
  max-width: 600px;
  margin: auto;
}
.messages-container {
  height: 300px;
  overflow: auto;
  border: 1px solid #ccc;
  padding: 10px;
  margin-bottom: 10px;
}
.message {
  display: flex;
  justify-content: space-between;
  margin-bottom: 5px;
  padding: 5px;
  border-bottom: 1px solid #eee;
}
.username {
  font-weight: bold;
  flex: 1;
  max-width: 30%; /* Контролирует ширину для пользователей */
}
.text {
  flex: 3;
  margin-left: 10px;
  word-break: break-word;
}
.input-container {
  display: flex;
  gap: 5px;
}
input[type="text"] {
  flex: 1;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
button {
  padding: 8px 16px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
button:hover {
  background-color: #0056b3;
}
</style>