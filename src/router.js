import Vue from 'vue';
import Router from 'vue-router';
import Login from './components/Login.vue';
import Register from './components/Register.vue';
import Chat from './components/Chat.vue';

Vue.use(Router);

export default new Router({
  mode: 'history', // позаботьтесь о правильной настройке на сервере, если понадобиться
  routes: [
    {
      path: '/',
      name: 'login',
      component: Login
    },
    {
      path: '/register',
      name: 'register',
      component: Register
    },
    {
      path: '/chat',
      name: 'chat',
      component: Chat
    }
  ]
});