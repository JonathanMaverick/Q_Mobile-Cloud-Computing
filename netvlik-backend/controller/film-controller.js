var db = require("./../database/db");

var getFilms = () =>
  new Promise((resolve, reject) => {
    db.query("SELECT * FROM films", (err, result) => {
      if (!!err) reject(err);
      resolve(result);
    });
  });

var getFilmsById = (id) =>
  new Promise((resolve, reject) => {
    db.query("SELECT * FROM films WHERE id = ?", [id], (err, result) => {
      if (!!err) reject(err);
      resolve(result);
    });
  });

var createFilm = (title, description, genre, image) =>
  new Promise((resolve, reject) => {
    db.query(
      "INSERT INTO films (title, description, genre, image) VALUES (?, ?, ?, ?)",
      [title, description, genre, image],
      (err, result) => {
        if (!!err) reject(err);
        resolve(result);
      }
    );
  });

var updateFilm = (title, description, genre, image, id) =>
  new Promise((resolve, reject) => {
    db.query(
      "UPDATE films SET title = ?, description = ?, genre = ?, image = ? WHERE id = ?",
      [title, description, genre, image, id],
      (err, result) => {
        if (!!err) reject(err);
        resolve(result);
      }
    );
  });

var deleteFilm = (id) =>
  new Promise((resolve, reject) => {
    db.query("DELETE FROM films WHERE id = ?", [id], (err, result) => {
      if (!!err) reject(err);
      resolve(result);
    });
  });

module.exports = {
  getFilms,
  getFilmsById,
  createFilm,
  updateFilm,
  deleteFilm,
};
