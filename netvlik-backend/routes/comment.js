var express = require("express");
var router = express.Router();
var commentController = require("./../controller/comment-controller");

// Get All Comment By FilmID
router.get("/film/:film_id", function (req, res, next) {
  const filmId = req.params.film_id;
  commentController.getCommentByFilmId(filmId).then(
    (result) => {
      res.status(200).json(result);
    },
    (error) => {
      res.status(500).json({ error: "Failed to retrieve comments" });
    }
  );
});

// Get By ID
router.get("/get/:id", function (req, res, next) {
  const commentId = req.params.id;
  commentController.getCommentById(commentId).then(
    (result) => {
      if (result.length === 0) {
        res.status(404).json({ message: "Comment not found" });
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
router.post("/create", function (req, res, next) {
  const { comment, film_id, user_id } = req.body;
  commentController.createComment(comment, film_id, user_id).then(
    (result) => {
      res.status(201).json({ message: "Comment created" });
    },
    (error) => {
      res.status(500).json({ error });
    }
  );
});

//Update
router.put("/update/:id", function (req, res, next) {
  const { comment, film_id, user_id } = req.body;
  const commentId = req.params.id;
  commentController.updateComment(comment, film_id, user_id, commentId).then(
    (result) => {
      res.status(200).json({ message: "Comment updated" });
    },
    (error) => {
      res.status(500).json({ error });
    }
  );
});

//Delete
router.delete("/delete/:id", function (req, res, next) {
  const commentId = req.params.id;
  commentController.deleteComment(commentId).then(
    (result) => {
      res.status(200).json({ message: "Comment deleted" });
    },
    (error) => {
      res.status(500).json({ error });
    }
  );
});
