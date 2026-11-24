-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-samirja.alwaysdata.net
-- Generation Time: Nov 24, 2026 at 08:36 AM
-- Server version: 10.11.18-MariaDB
-- PHP Version: 8.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `samirja_cinema`
--

-- --------------------------------------------------------

--
-- Table structure for table `afficheur`
--

CREATE TABLE `afficheur` (
  `id_afficheur` int(10) UNSIGNED NOT NULL,
  `modele` varchar(100) NOT NULL,
  `res_pixel` varchar(30) NOT NULL,
  `couleur` varchar(50) NOT NULL,
  `defilant` tinyint(1) NOT NULL,
  `id_salle` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `capteur`
--

CREATE TABLE `capteur` (
  `id_capteur` int(11) NOT NULL,
  `id_salle` int(11) NOT NULL,
  `capteur_samir` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `film`
--

CREATE TABLE `film` (
  `id_film` int(10) UNSIGNED NOT NULL,
  `nom_film` varchar(100) NOT NULL,
  `duree` smallint(5) UNSIGNED NOT NULL,
  `interdit_16` tinyint(1) NOT NULL,
  `langue` enum('Français','Anglais','Espagnol','Occitan') NOT NULL,
  `resume` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mesure`
--

CREATE TABLE `mesure` (
  `id_mesure` int(11) NOT NULL,
  `temperature` decimal(4,2) NOT NULL,
  `humidite` decimal(4,2) NOT NULL,
  `co2` int(11) NOT NULL,
  `date_mesure` datetime NOT NULL DEFAULT current_timestamp(),
  `id_capteur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salle`
--

CREATE TABLE `salle` (
  `id_salle` int(11) NOT NULL,
  `nom_salle` varchar(50) NOT NULL,
  `numero_salle` int(11) DEFAULT NULL,
  `nb_fauteuil` int(11) NOT NULL,
  `taille_ecran` varchar(50) NOT NULL,
  `amenagement` varchar(50) DEFAULT NULL,
  `technologie` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seance`
--

CREATE TABLE `seance` (
  `id_seance` int(10) UNSIGNED NOT NULL,
  `date_heure` datetime NOT NULL,
  `version_langue` varchar(30) NOT NULL,
  `id_salle` int(11) NOT NULL,
  `id_film` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `afficheur`
--
ALTER TABLE `afficheur`
  ADD PRIMARY KEY (`id_afficheur`),
  ADD KEY `id_salle` (`id_salle`);

--
-- Indexes for table `capteur`
--
ALTER TABLE `capteur`
  ADD PRIMARY KEY (`id_capteur`),
  ADD KEY `fk_capteur_salle` (`id_salle`);

--
-- Indexes for table `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`id_film`);

--
-- Indexes for table `mesure`
--
ALTER TABLE `mesure`
  ADD PRIMARY KEY (`id_mesure`),
  ADD KEY `fk_mesure_capteur` (`id_capteur`);

--
-- Indexes for table `salle`
--
ALTER TABLE `salle`
  ADD PRIMARY KEY (`id_salle`);

--
-- Indexes for table `seance`
--
ALTER TABLE `seance`
  ADD PRIMARY KEY (`id_seance`),
  ADD KEY `id_salle` (`id_salle`),
  ADD KEY `id_film` (`id_film`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `afficheur`
--
ALTER TABLE `afficheur`
  MODIFY `id_afficheur` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `film`
--
ALTER TABLE `film`
  MODIFY `id_film` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mesure`
--
ALTER TABLE `mesure`
  MODIFY `id_mesure` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seance`
--
ALTER TABLE `seance`
  MODIFY `id_seance` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `afficheur`
--
ALTER TABLE `afficheur`
  ADD CONSTRAINT `fk_afficheur_salle` FOREIGN KEY (`id_salle`) REFERENCES `salle` (`id_salle`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `capteur`
--
ALTER TABLE `capteur`
  ADD CONSTRAINT `fk_capteur_salle` FOREIGN KEY (`id_salle`) REFERENCES `salle` (`id_salle`) ON UPDATE CASCADE;

--
-- Constraints for table `mesure`
--
ALTER TABLE `mesure`
  ADD CONSTRAINT `fk_mesure_capteur` FOREIGN KEY (`id_capteur`) REFERENCES `capteur` (`id_capteur`) ON UPDATE CASCADE;

--
-- Constraints for table `seance`
--
ALTER TABLE `seance`
  ADD CONSTRAINT `fk_seance_film` FOREIGN KEY (`id_film`) REFERENCES `film` (`id_film`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_seance_salle` FOREIGN KEY (`id_salle`) REFERENCES `salle` (`id_salle`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
