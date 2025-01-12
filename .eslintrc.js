module.exports = {
    root: true,
    env: {
      node: true,
    },
    extends: [
      'plugin:vue/recommended',
      'eslint:recommended',
    ],
    rules: {
      'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
      'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    },
    parserOptions: {
      parser: 'babel-eslint',
    },
  };