var db = require("./../database/db");

var getFilms = () =>
  new Promise((resolve, reject) => {
    db.query("SELECT * FROM films", (err, result) => {
      if (!!err) reject(err);
      resolve(result);
    });
  });

var getTopFilms = () =>
  new Promise((resolve, reject) => {
    db.query(
      "SELECT * FROM films ORDER BY rating DESC LIMIT 5",
      (err, result) => {
        if (!!err) reject(err);
        resolve(result);
      }
    );
  });

var getFilmsById = (id) =>
  new Promise((resolve, reject) => {
    db.query("SELECT * FROM films WHERE id = ?", [id], (err, result) => {
      if (!!err) reject(err);
      resolve(result);
    });
  });

var createFilm = (name, description, genre, image, rating) =>
  new Promise((resolve, reject) => {
    db.query(
      "INSERT INTO films (name, description, genre, image, rating) VALUES (?, ?, ?, ?, ?)",
      [name, description, genre, image, rating],
      (err, result) => {
        if (!!err) reject(err);
        resolve(result);
      }
    );
  });

var updateFilm = (title, description, genre, image, rating, id) =>
  new Promise((resolve, reject) => {
    db.query(
      "UPDATE films SET name = ?, description = ?, genre = ?, image = ?, rating = ? WHERE id = ?",
      [title, description, genre, image, rating, id],
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
  getTopFilms,
  createFilm,
  updateFilm,
  deleteFilm,
};
