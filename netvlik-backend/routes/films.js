var express = require("express");
var router = express.Router();
var filmController = require("./../controller/film-controller");
var multer = require("multer");

var storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./public/images");
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

var upload = multer({
  storage: storage,
});

// Get All Film
router.get("/", function (req, res, next) {
  filmController.getFilms().then(
    (result) => {
      res.status(200).json(result);
    },
    (error) => {
      res.status(500).json({ error: "Failed to retrieve films" });
    }
  );
});

router.get("/top", function (req, res, next) {
  filmController.getTopFilms().then(
    (result) => {
      res.status(200).json(result);
    },
    (error) => {
      res.status(500).json({ error: "Failed to retrieve films" });
    }
  );
});

// Get By ID
router.get("/get/:id", function (req, res, next) {
  const filmId = req.params.id;
  filmController.getFilmsById(filmId).then(
    (result) => {
      if (result.length === 0) {
        res.status(404).json({ message: "Film not found" });
      } else {
        res.status(200).json(result[0]);
      }
    },
    (error) => {
      res.status(500).json({ error });
    }
  );
});

//Create
router.post("/create", upload.single("image"), function (req, res, next) {
  const { name, description, genre, rating } = req.body;
  filmController
    .createFilm(
      name,
      description,
      genre,
      req.file.path.replace("public", ""),
      rating
    )
    .then(
      (result) => {
        res.status(201).json({ message: "Film created" });
      },
      (error) => {
        res.status(500).json({ error });
      }
    );
});

//Update
router.put("/update/:id", function (req, res, next) {
  const { name, description, genre, image, rating } = req.body;
  const filmId = req.params.id;
  filmController
    .updateFilm(name, description, genre, image, rating, filmId)
    .then(
      (result) => {
        res.status(200).json({ message: "Film updated" });
      },
      (error) => {
        res.status(500).json({ error });
      }
    );
});

//Delete
router.delete("/delete/:id", function (req, res, next) {
  const filmId = req.params.id;
  filmController.deleteFilm(filmId).then(
    (result) => {
      res.status(200).json({ message: "Film deleted" });
    },
    (error) => {
      res.status(500).json({ error });
    }
  );
});

module.exports = router;
