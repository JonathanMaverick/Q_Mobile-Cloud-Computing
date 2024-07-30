var db = require("./../database/db");

var getCommentByFilmId = (filmId) =>
  new Promise((resolve, reject) => {
    db.query(
      "SELECT * FROM comments WHERE film_id = ?",
      [filmId],
      (err, result) => {
        if (!!err) reject(err);
        resolve(result);
      }
    );
  });

var getCommentById = (id) =>
  new Promise((resolve, reject) => {
    db.query("SELECT * FROM comments WHERE id = ?", [id], (err, result) => {
      if (!!err) reject(err);
      resolve(result);
    });
  });

var createComment = (comment, film_id, user_id) =>
  new Promise((resolve, reject) => {
    db.query(
      "INSERT INTO comments (comment, film_id, user_id) VALUES (?, ?, ?)",
      [comment, film_id, user_id],
      (err, result) => {
        if (!!err) reject(err);
        resolve(result);
      }
    );
  });

var updateComment = (comment, film_id, user_id, id) =>
  new Promise((resolve, reject) => {
    db.query(
      "UPDATE comments SET comment = ?, film_id = ?, user_id = ? WHERE id = ?",
      [comment, film_id, user_id, id],
      (err, result) => {
        if (!!err) reject(err);
        resolve(result);
      }
    );
  });

var deleteComment = (id) =>
  new Promise((resolve, reject) => {
    db.query("DELETE FROM comments WHERE id = ?", [id], (err, result) => {
      if (!!err) reject(err);
      resolve(result);
    });
  });
