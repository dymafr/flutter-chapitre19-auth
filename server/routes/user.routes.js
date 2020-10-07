const router = require("express").Router();
const User = require("../models/user.model");
const bcrypt = require("bcrypt");
const jsonwebtoken = require("jsonwebtoken");
const { JWT_SECRET } = require("../config/jwt");
const extractUser = require("../middlewares/extractUser");

router.post("/", async (req, res, next) => {
  const body = req.body;
  try {
    await new User({
      username: body.username,
      email: body.email,
      password: bcrypt.hashSync(body.password, 10),
    }).save();
    res.status(200).end();
  } catch (e) {
    next(e);
  }
});

router.get("/current", extractUser, (req, res, next) => {
  res.json(req.user);
});

module.exports = router;
