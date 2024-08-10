-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 10, 2024 at 06:31 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `netvlik`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `film_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `comment`, `film_id`, `user_id`) VALUES
(1, 'Very Good Film Recommended', 12, 1),
(5, 'Good film, I love it!', 12, 1),
(6, 'I love fern', 17, 1),
(7, 'Hehehe', 12, 1),
(8, 'detective good', 15, 2),
(10, 'Lesgooo girl\'s camping!, I love it', 12, 2),
(11, 'erm what the sigma', 13, 2);

-- --------------------------------------------------------

--
-- Table structure for table `films`
--

CREATE TABLE `films` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `rating` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `films`
--

INSERT INTO `films` (`id`, `name`, `description`, `genre`, `image`, `rating`) VALUES
(12, 'Yuru Camp', 'While the perfect getaway for most girls her age might be a fancy vacation with their loved ones, Rin Shima\'s ideal way of spending her days off is camping alone at the base of Mount Fuji.', 'Slice Of Life', '/images/1723171018008-yurucamp.jpg', 10),
(13, 'Stranger Things', 'Stranger Things is a sci-fi horror series set in the 1980s, where kids in Hawkins, Indiana, uncover a secret government experiment that opens a portal to a dark, alternate dimension.', 'Horror', '/images/1723264467713-stranger.jpg', 8.7),
(14, 'Breaking Bad', 'Breaking Bad is a drama series about a high school chemistry teacher who turns to manufacturing methamphetamine after a terminal cancer diagnosis.', 'Drama', '/images/1723264644606-breakingbad.jpg', 9.2),
(15, 'Spy X Family', 'Spy x Family is an anime series about a spy who creates a fake family to complete a mission, only to discover that his new wife is an assassin and his adopted daughter is a telepath.', 'Action', '/images/1723265255780-spyxfamily.jpg', 7.7),
(17, 'Frieren', 'Frieren is an anime series about a high elf mage named Frieren who, after completing a long-awaited quest with her hero companions, embarks on a journey to understand human emotions and the passage of time.', 'Adventure', '/images/1723267983445-Frieren.jpg', 9.8),
(18, 'Kaiju No 8', 'Kaiju No. 8 is a manga series about Kafka Hibino, a man who gains the ability to transform into a kaiju, and joins the defense force to combat monstrous creatures while grappling with his new powers and personal ambitions.', 'Action', '/images/1723268066948-anime-kaiju-no8.jpeg', 8.6),
(19, 'Itaewon Class', '\"Itaewon Class\" is a Korean drama that follows a young man\'s journey to build a successful restaurant and seek justice after facing numerous challenges and injustices.', 'Drama', '/images/1723280152113-itaewonclass.jpg', 9.2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'veka', '$2b$10$56GqL2.xBMM73ng4crb.B.LnHZbwseQ7zgnxcXucXT6kWMWp7JoeO'),
(2, 'emha', '$2b$10$mw3iyw10QMNjVFmTsnWYJOze.NHS5GOQt4CGPYvf30yIGwedsHvtC');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `film_id` (`film_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `films`
--
ALTER TABLE `films`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `films`
--
ALTER TABLE `films`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
