-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql-samirja.alwaysdata.net
-- Generation Time: Nov 24, 2026 at 08:43 AM
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

--
-- Dumping data for table `afficheur`
--
SET FOREIGN_KEY_CHECKS=0;

INSERT INTO `afficheur` (`id_afficheur`, `modele`, `res_pixel`, `couleur`, `defilant`, `id_salle`) VALUES
(1, 'LED-P10', '64x32', 'Rouge', 1, 1),
(2, 'LED-P10', '64x32', 'Rouge', 1, 2),
(3, 'LED-P10', '64x32', 'Vert', 0, 3);

--
-- Dumping data for table `capteur`
--

INSERT INTO `capteur` (`id_capteur`, `id_salle`, `capteur_samir`) VALUES
(102, 2, 0),
(107, 7, 0),
(203, 3, 0),
(212, 2, 19);

--
-- Dumping data for table `film`
--

INSERT INTO `film` (`id_film`, `nom_film`, `duree`, `interdit_16`, `langue`, `resume`) VALUES
(1, 'Lee Miller', 116, 0, 'Anglais', 'L’incroyable vie de LEE MILLER, ex-modèle pour Vogue et muse de Man Ray devenue l’une des premières femmes photographes de guerre. Partie sur le front et prête à tout pour témoigner des horreurs de la Seconde Guerre, elle a, par son courage et son refus des conventions, changé la façon de voir le monde.'),
(2, 'Croquette', 88, 0, 'Français', 'C’est bien connu, les chats ont plusieurs vies ! Croquette vient de gâcher celle de trop et il ferait tout pour retrouver Rose, sa maîtresse adorée. On lui accorde une dernière chance, cependant une règle a changé : Croquette peut revenir, mais à un détail près... Désormais transformé en cheval, chien, perroquet ou poisson, l’aventure ne fait que commencer !'),
(3, 'Smile 2', 127, 1, 'Anglais', 'À l’aube d’une nouvelle tournée mondiale, la star de la pop Skye Riley se met à vivre des événements aussi terrifiants qu’inexplicables. Submergée par la pression de la célébrité et devant un quotidien qui bascule de plus en plus dans l’horreur, Skye est forcée de se confronter à son passé obscur pour tenter de reprendre le contrôle de sa vie avant qu’il ne soit trop tard.'),
(4, 'Azur et Asmar', 99, 0, 'Français', 'Il y a bien longtemps, deux enfants étaient bercés par la même femme. Azur, blond aux yeux bleus, fils du châtelain, et Asmar, brun aux yeux noirs, fils de la nourrice. Élevés comme deux frères, ils sont séparés brutalement mais se retrouvent plus tard à la recherche de la Fée des Djins.');

--
-- Dumping data for table `mesure`
--

INSERT INTO `mesure` (`id_mesure`, `temperature`, `humidite`, `co2`, `date_mesure`, `id_capteur`) VALUES
(1, 21.50, 45.00, 650, '2026-09-04 09:50:05', 203),
(2, 20.40, 48.10, 520, '2026-09-04 14:00:00', 203),
(3, 20.90, 49.30, 680, '2026-09-04 14:30:00', 203),
(4, 21.50, 52.00, 890, '2026-09-04 15:00:00', 203),
(5, 22.10, 55.40, 1150, '2026-09-04 15:30:00', 203),
(6, 21.80, 53.70, 980, '2026-09-04 16:00:00', 203),
(7, 20.00, 43.00, 480, '2026-09-04 10:00:00', 102),
(8, 20.40, 44.20, 560, '2026-09-04 10:30:00', 102),
(9, 20.90, 46.00, 690, '2026-09-04 11:00:00', 102),
(10, 21.30, 47.50, 810, '2026-09-04 11:30:00', 102),
(11, 21.70, 49.00, 920, '2026-09-04 12:00:00', 102),
(12, 19.80, 41.00, 440, '2026-09-04 10:00:00', 107),
(13, 20.10, 42.50, 530, '2026-09-04 10:30:00', 107),
(14, 20.50, 43.80, 650, '2026-09-04 11:00:00', 107),
(15, 21.00, 45.10, 760, '2026-09-04 11:30:00', 107),
(16, 21.40, 46.50, 870, '2026-09-04 12:00:00', 107);



--
-- Dumping data for table `salle`
--

INSERT INTO `salle` (`id_salle`, `nom_salle`, `numero_salle`, `nb_fauteuil`, `taille_ecran`, `amenagement`, `technologie`) VALUES
(1, 'Salle 1', 1, 0, '', NULL, NULL),
(2, 'Salle 2', 2, 0, '', NULL, NULL),
(3, 'Salle 3', 3, 0, '', NULL, NULL),
(7, 'Salle 7', 7, 0, '', NULL, NULL);

--
-- Dumping data for table `seance`
--

INSERT INTO `seance` (`id_seance`, `date_heure`, `version_langue`, `id_salle`, `id_film`) VALUES
(7, '2026-11-24 15:42:34', 'VOST', 1, 1),
(8, '2026-11-24 16:42:34', 'VF', 1, 1),
(9, '2026-11-24 17:42:34', 'VF', 2, 2),
(11, '2026-11-24 19:42:34', 'VF', 3, 3);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
