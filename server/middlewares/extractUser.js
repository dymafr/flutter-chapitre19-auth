const jsonwebtoken = require("jsonwebtoken");
const User = require("../models/user.model");
const { JWT_SECRET } = require("../config/jwt");

module.exports = async (req, _, next) => {
  try {
    const token = req.headers.authorization;
    if (token) {
      const jwtToken = token.split(" ")[1];
      const jwtDecodedToken = jsonwebtoken.verify(jwtToken, JWT_SECRET);
      if (jwtDecodedToken) {
        const userId = jwtDecodedToken.sub;
        const user = await User.findOne(
          { _id: userId },
          "-__v -password",
          {}
        ).exec();
        req.user = user;
      }
    }
    next();
  } catch (e) {
    next(e);
  }
};
