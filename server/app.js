var express = require("express");
const mongoose = require("mongoose");
const index = require("./routes");

mongoose.connect(
  "mongodb+srv://jean:123@cluster0-urpjt.gcp.mongodb.net/auth-flutter?retryWrites=true&w=majority",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  },
  (err) => {
    if (err) {
      console.log("ERROR DB");
    } else {
      console.log("CONNEXION DB OK !");
    }
  }
);

var app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use(index);

app.all("*", (req, res) => {
  res.status(404).json("not-found");
});

// error handler
app.use(function (err, req, res, next) {
  console.log(err);
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.json("error");
});

module.exports = app;
