var express = require("express");
var router = express.Router();
var userController = require("./../controller/user-controller");

/* GET users listing. */
router.get("/", function (req, res, next) {
  res.send("respond with a resource");
});

router.post("/register", function (req, res, next) {
  const { username, password } = req.body;
  userController.doRegister(username, password).then(
    (result) => {
      res.status(201).json({ message: "User created" });
    },
    (error) => {
      res.status(500).json({ error: "Failed to create user" });
    }
  );
});

router.post("/login", function (req, res, next) {
  const { username, password } = req.body;
  userController.doLogin(username, password).then(
    (result) => {
      res.status(200).json(result);
    },
    (error) => {
      res.status(500).json(error);
    }
  );
});

module.exports = router;
