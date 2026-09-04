const express = require('express');
const mongoose = require('mongoose');
const index = require('./routes');

mongoose
  .connect(process.env.MONGO_URL)
  .then(() => console.log('DB CONNECTED'))
  .catch(() => console.log('ERROR DB'));

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use(index);

app.use((req, res) => {
  res.status(404).json('not-found');
});

app.use((err, req, res, next) => {
  console.log(err);
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  res.status(err.status || 500);
  res.json('error');
});

module.exports = app;
