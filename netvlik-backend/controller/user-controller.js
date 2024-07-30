var db = require("./../database/db");
var bcrypt = require("bcrypt");
var jwt = require("jsonwebtoken");

var doRegister = (username, password) => {
  return new Promise((resolve, reject) => {
    var hashPassword = bcrypt.hashSync(password, 10);
    db.query(
      "INSERT INTO users (username, password) VALUES (?, ?)",
      [username, hashPassword],
      (err, result) => {
        if (!!err) reject(err);
        resolve(result);
      }
    );
  });
};

var doLogin = (username, password) => {
  return new Promise((resolve, reject) => {
    db.query(
      "SELECT * FROM users WHERE username = ?",
      [username],
      (err, result) => {
        if (!!err) reject(err);
        if (result.length === 0) {
          reject("User not found");
        } else {
          var isPasswordMatch = bcrypt.compareSync(
            password,
            result[0].password
          );
          if (isPasswordMatch) {
            var token = jwt.sign(
              {
                id: result[0].id,
                username: result[0].username,
              },
              process.env.API_SECRET,
              {
                expiresIn: "1d",
              }
            );
            resolve({
              id: result[0].id,
              username: username,
              token: token,
            });
          } else {
            reject("Wrong password");
          }
        }
      }
    );
  });
};

module.exports = {
  doRegister,
  doLogin,
};
