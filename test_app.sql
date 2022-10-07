-- Database: `platen`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `discs`
--

CREATE TABLE `discs` (
  `ID` int NOT NULL,
  `Titel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'not null',
  `Artiest` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Jaar` int NOT NULL
);

--
-- Gegevens worden geëxporteerd voor tabel `discs`
--

INSERT INTO `discs` (`ID`, `Titel`, `Artiest`, `Jaar`) VALUES
(1, 'TubularBells', 'Mike Oldfield', 1973),
(2, 'On The Move', 'Rogier Van Otterloo', 1975),
(3, 'Songs from liquid days', 'Philip Glass', 1988);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `tracks`
--

CREATE TABLE `tracks` (
  `TID` int NOT NULL,
  `Disc_fk` int NOT NULL,
  `TrackNo` int NOT NULL,
  `TrackTitle` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'not null',
  `TrackArtiest` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Tijdsduur` int NOT NULL
);

--
-- Gegevens worden geëxporteerd voor tabel `tracks`
--

INSERT INTO `tracks` (`TID`, `Disc_fk`, `TrackNo`, `TrackTitle`, `TrackArtiest`, `Tijdsduur`) VALUES
(1, 1, 1, 'Part One', 'Mike Oldfield', 25),
(2, 1, 2, 'Part Two', 'Mike Oldfield', 23),
(3, 2, 1, 'Go On Forever (We zullen doorgaan)', 'Rogier van Otterloo', 1),
(4, 2, 2, 'Alfie\'s Lullaby', 'Rogier van Otterloo', 1),
(5, 2, 3, 'On The Move', 'Rogier van Otterloo', 1),
(6, 2, 4, 'Alone At Last', 'Rogier van Otterloo', 1),
(7, 2, 5, 'My Dearest Fluffie', 'Rogier van Otterloo', 1),
(8, 2, 6, 'The Eternal Triangel', 'Rogier van Otterloo', 1),
(9, 2, 7, 'I Do Remember', 'Rogier van Otterloo', 1),
(10, 2, 8, 'The Flattened Tenth', 'Rogier van Otterloo', 1),
(11, 3, 1, 'Changing Opinion', 'Philip Glass', 1),
(12, 3, 2, 'Lighning', 'Philip Glass', 1),
(13, 3, 3, 'Freezing', 'Philip Glass', 1),
(14, 3, 4, 'Liquid Days', 'Philip Glass', 1),
(15, 3, 5, 'Open the Kingdom', 'Philip Glass', 1),
(16, 3, 6, 'Forgetting', 'Philip Glass', 1);

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `discs`
--
ALTER TABLE `discs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexen voor tabel `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`TID`);
COMMIT;
