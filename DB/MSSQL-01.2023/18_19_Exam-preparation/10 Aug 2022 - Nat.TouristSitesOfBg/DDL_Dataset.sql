﻿USE NationalTouristSitesOfBulgaria

-- Table: Tourists
SET IDENTITY_INSERT Tourists ON

INSERT INTO Tourists(Id, Name, Age, PhoneNumber, Nationality, Reward) VALUES
(1, 'Mariya Petrova', 37, '+359887564235', 'Bulgaria', NULL),
(2, 'Kameliya Dimitrova', 42, '+359898645326', 'Bulgaria', NULL),
(3, 'Emilio Bianchi', 51, '+393125965845', 'Italy', NULL),
(4, 'Stoyan Mitev', 19, '+359878564123', 'Bulgaria', NULL),
(5, 'Krasen Krasenov', 62, '+359897653265', 'Bulgaria', NULL),
(6, 'Gabriela Stoeva', 24, '+359898563210', 'Bulgaria', NULL),
(7, 'Nivien Becker', 36, '+491711234567', 'Germany', NULL),
(8, 'Jeff Morrison', 58, '+447700154426', 'UK', NULL),
(9, 'Brus Brown', 42, '+447459881347', 'UK', NULL),
(10, 'Teodor Petrov', 19, '+359888100200', 'Bulgaria', NULL),
(11, 'Zac Walsh', 51, '+41756236598', 'Switzerland', NULL),
(12, 'Danny Kane', 39, '+32487454880', 'Belgium', NULL),
(13, 'Matrina Kovacheva', 29, '+359896363220', 'Bulgaria', NULL),
(14, 'Cosimo Ajello', 51, '+393521112654', 'Italy', NULL),
(15, 'Piotr Filipek', 39, '+48606128969', 'Poland', NULL),
(16, 'Pavel Mateev', 51, '+359879632123', 'Bulgaria', NULL),
(17, 'Merle Bauer', 49, '+496913265224', 'Germany', NULL),
(18, 'John Smith', 28, '+447505747175', 'UK', NULL),
(19, 'Alonzo Conti', 36, '+393336258996', 'Italy', NULL),
(20, 'Claudia Reuss', 54, '+4930774615846', 'Germany', NULL),
(21, 'Gerhild Lutgard', 35, '+4915917757675','Germany', NULL),
(22, 'Matthew Jones', 53, '+447503233764', 'UK', NULL),
(23, 'Derex Koch', 29, '+4916337136946', 'Germany', NULL),
(24, 'Frank Murphy', 41, '+353822170617', 'Ireland', NULL),
(25, 'Cyrek Gryzbowski', 64, '+48503435735', 'Poland', NULL),
(26, 'Dobroslav Mihalev', 39, '+359889632200', 'Bulgaria', NULL)

SET IDENTITY_INSERT Tourists OFF

-- Table: Categories
SET IDENTITY_INSERT Categories ON

INSERT INTO Categories(Id, Name) VALUES
(1, 'Nature and natural parks'),
(2, 'Mountain'),
(3, 'Spare time in the city'),
(4, 'Adventure'),
(5, 'Culture and art'),
(6, 'Religion'),
(7, 'Eco tourism'),
(8, 'History and archaeology')

SET IDENTITY_INSERT Categories OFF

-- Table: Locations
SET IDENTITY_INSERT Locations ON

INSERT INTO Locations(Id, Name, Municipality, Province) VALUES
(1, 'Arbanasi', 'Veliko Tarnovo', 'Veliko Tarnovo'),
(2, 'Asenovgrad', 'Asenovgrad', 'Plovdiv'),
(3, 'Bachkovo village', 'Asenovgrad', 'Plovdiv'),
(4, 'Balchik', 'Balchik', 'Dobrich'),
(5, 'Balkan Mountains', NULL, NULL),
(6, 'Bansko', 'Bansko', 'Blagoevgrad'),
(7, 'Batak','Batak', 'Pazardzhik'),
(8, 'Belogradchik', 'Belogradchik', 'Vidin'),
(9, 'Berkovitsa', 'Berkovitsa', 'Montana'),
(10, 'Botevgrad', 'Botevgrad', 'Sofia'),
(11, 'Bratsigovo', 'Bratsigovo', 'Pazardzhik'),
(12, 'Brestnitsa village', 'Yablanitsa', 'Lovech'),
(13, 'Chelopek village', 'Vratsa', 'Vratsa'),
(14, 'Cherni osam village', 'Troyan', 'Lovech'),
(15, 'Chiprovtsi', 'Chiprovtsi', 'Montana'),
(16, 'Chirpan', 'Chirpan', 'Stara Zagora'),
(17, 'Sliven', 'Sliven', 'Sliven'),
(18, 'Dobarsko village', 'Razlog', 'Blagoevgrad'),
(19, 'Dryanovo', 'Dryanovo', 'Gabrovo'),
(20, 'Elena', 'Elena', 'Veliko Tarnovo'),
(21, 'Elhovo', 'Elhovo', 'Yambol'),
(22, 'Etropole', 'Etropole', 'Sofia'),
(23, 'Gabrovo', 'Gabrovo', 'Gabrovo'),
(24, 'Haskovo', 'Haskovo', 'Haskovo'),
(25, 'Isperih', 'Isperih', 'Razgrad'),
(26, 'Ivanovo village', 'Ivanovo', 'Rousse'),
(27, 'Ivaylovgrad', 'Ivaylovgrad', 'Haskovo'),
(28, 'Kakrina village', 'Lovech', 'Lovech'),
(29, 'Kalofer', 'Karlovo', 'Plovdiv'),
(30, 'Kardzhali', 'Kardzhali', 'Kardzhali'),
(31, 'Karlovo', 'Karlovo', 'Plovdiv'),
(32, 'Karlukovo Village', 'Lukovit', 'Lovech'),
(33, 'Kavarna', 'Kavarna', 'Dobrich'),
(34, 'Kazanlak', 'Karlovo', 'Plovdiv'),
(35, 'Klisura', 'Karlovo', 'Plovdiv'),
(36, 'Koprivshtitsa', 'Koprivshtitsa', 'Sofia'),
(37, 'Kotel', 'Kotel', 'Sliven'),
(38, 'Kozloduy', 'Kozloduy', 'Vratsa'),
(39, 'Kyustendil', 'Kyustendil', 'Kyustendil'),
(40, 'Lovech', 'Lovech', 'Lovech'),
(41, 'Madara', 'Shumen', 'Shumen'),
(42, 'Malko Tarnovo', 'Malko Tarnovo', 'Burgas'),
(43, 'Mezek village', 'Svilengrad ', 'Haskovo'),
(44, 'Mogilitsa', 'Smolyan', 'Smolyan'),
(45, 'Montana', 'Montana', 'Montana'),
(46, 'Nesebar', 'Nesebar', 'Burgas'),
(47, 'Nikyup village', 'Veliko Tarnovo', 'Veliko Tarnovo'),
(48, 'Oborishte', 'Panagyurishte ', 'Pazardzhik '),
(49, 'Osenovlag village', 'Svoge', 'Sofia'),
(50, 'Osogovo Mountain', NULL, NULL),
(51, 'Pazardzhik', 'Pazardzhik', 'Pazardzhik'),
(52, 'Perushtitsa', 'Perushtitsa', 'Plovdiv'),
(53, 'Petrich', 'Petrich', 'Blagoevgrad'),
(54, 'Pleven', 'Pleven', 'Pleven'),
(55, 'Pliska', 'Kaspitchan', 'Shumen '),
(56, 'Plovdiv', 'Plovdiv', 'Plovdiv'),
(57, 'Pomorie', 'Pomorie', 'Burgas'),
(58, 'Razgrad', 'Razgrad', 'Razgrad'),
(59, 'Rhodope Mountain', NULL, NULL),
(60, 'Rila Mountain', NULL, NULL),
(61, 'Rousse', 'Rousse', 'Rousse'),
(62, 'Samokov', 'Samokov', 'Sofia'),
(63, 'Shipka town', 'Kazanlak', 'Stara Zagora'),
(64, 'Shiroka Laka village', 'Smolyan', 'Smolyan'),
(65, 'Karlanovo village', 'Sandanski', 'Blagoevgrad'),
(66, 'Silistra', 'Silistra', 'Silistra'),
(67, 'Devetaki', 'Lovech', 'Lovech'),
(68, 'Smolyan', 'Smolyan', 'Smolyan'),
(69, 'Sofia', 'Sofia', 'Sofia'),
(70, 'Sozopol', 'Sozopol', 'Burgas'),
(71, 'Srebarna village', 'Silistra', 'Silistra'),
(72, 'Stara Zagora', 'Stara Zagora', 'Stara Zagora'),
(73, 'Starosel village', 'Hisarya', 'Plovdiv'),
(74, 'Stob village', 'Kocherinovo', 'Kyustendil'),
(75, 'Sveshtari village', 'Isperih', 'Razgrad'),
(76, 'Teteven', 'Teteven', 'Lovech'),
(77, 'Tran', 'Tran', 'Pernik'),
(78, 'Troyan', 'Troyan', 'Lovech'),
(79, 'Tryavna', 'Tryavna', 'Gabrovo'),
(80, 'Tutrakan', 'Tutrakan', 'Silistra'),
(81, 'Varna', 'Varna', 'Varna'),
(82, 'Veliki Preslav', 'Veliki Preslav', 'Shumen'),
(83, 'Veliko Tarnovo', 'Veliko Tarnovo', 'Veliko Tarnovo'),
(84, 'Velingrad', 'Velingrad', 'Pazardzhik'),
(85, 'Vidin', 'Vidin', 'Vidin'),
(86, 'Vratsa', 'Vratsa', 'Vratsa'),
(87, 'Yagodina village', 'Borino', 'Smolyan'),
(88, 'Yambol', 'Yambol', 'Yambol'),
(89, 'Zlatograd', 'Zlatograd', 'Smolyan'),
(90, 'Ustren village', 'Dzhebel', 'Kardzhali'),
(91, 'Shumen', 'Shumen', 'Shumen'),
(92, 'Rupite village', 'Petrich', 'Blagoevgrad')

SET IDENTITY_INSERT Locations OFF

-- Table: Sites
SET IDENTITY_INSERT Sites ON

INSERT INTO Sites(Id, Name, LocationId, CategoryId, Establishment) VALUES
(1, 'History Museum – Karlovo', 31, 8, '1871'),
(2, 'Planetarium – Smolyan', 68, 3, '1975'),
(3, 'Art Gallery Vladimir Dimitrov – Maystora – Kyustendil', 39, 5, '1972'),
(4, 'National Art Gallery', 4, 5, '1892'),
(5, 'Zoo – Sofia', 69, 4, '1888'),
(6, 'House of Humour and Satire Museum – Gabrovo', 23, 3, '1972'),
(7, 'Founders of the Bulgarian State Monument', 91, 8, '1977'),
(8, 'Bacho Kiro Cave', 19, 4, NULL),
(9, 'Museum of Education – Gabrovo', 23, 3, '1974'),
(10, 'Georgi Stoykov Rakovski’s Pantheon', 37, 8, '1981'),
(11, 'Pantheon of National Revival Heroes', 61, 8, '1978'),
(12, 'Sherif Halil Pasha Mosque – Shumen', 91, 6, '1744'),
(13, 'Patriarchal Cathedral St. Alexander Nevsky', 69, 6, '1924'),
(14, 'Architectural Park Complex – The Palace – Balchik', 4, 8, '1924'),
(15, 'Chiprovtsi Monastery Saint Ivan Rilski – Chiprovtsi', 15, 6, 'X'),
(16, 'St. Athanasius Monastery – Zlatna Livada', 16, 6, '344'),
(17, 'Cathedral Church St. Mary – Pazardzhik', 51, 6, '1836'),
(18, 'Holy Trinity Temple – Bansko', 6, 6, '1835'),
(19, 'Temple-monument Nativity – Shipka', 63, 6, '1902'),
(20, 'St. Yoan Predtecha Monastery – Kardzhali', 30, 6, 'VI'),
(21, 'Monument of the Virgin Mary – Haskovo', 24, 6, '2003'),
(22, 'Church St. Teodor Tiron and St. Teodor Stratilat – Dobarsko', 18, 6, '1614'),
(23, 'Ruen Peak', 50, 2, NULL),
(24, 'Rupite', 92, 7, '1962'),
(25, 'Snezhanka Peak', 59, 2, NULL),
(26, 'Clock Tower – Botevgrad', 10, 3, '1866'),
(27, 'Regional History Museum – Montana', 45, 8, '1951'),
(28, 'Permanent Icon Exhibition Bansko Art School – Bansko', 6, 5, '1749'),
(29, 'Yambol’s Covered Bazaar', 88, 3, '1509'),
(30, 'Demir Baba Tekke', 75, 8, 'XVII'),
(31, 'The Wonder Bridges', 59, 7, NULL),
(32, 'Koprivshtitsa Architectural and Historical Reserve', 36, 8, '1952'),
(33, 'Clock Tower of Etropole', 22, 3, '1710'),
(34, 'Arbanasi Archeological Reserve', 1, 8, NULL),
(35, 'Historical and Architectural Complex Daskalolivnitsata – Elena', 20, 8, '1844'),
(36, 'Museum Nikola Vaptsarov – Bansko', 6, 8, NULL),
(37, 'Okolchitsa – National Park of Hristo Botev', 13, 8, '1926'),
(38, 'Velyanova Kashta – Bansko', 6, 8, 'XVIII'),
(39, 'Ethnographic Institute with Museum, BAS', 69, 5, '1892'),
(40, 'Kakrina Inn', 28, 8, NULL),
(41, 'Oborishte Historical Site', 48, 8, NULL),
(42, 'National Park-Museum Shipka', 5, 8, '1934'),
(43, 'Buinovo Gorge', 59, 1, NULL),
(44, 'Trigrad Gorge', 59, 1, NULL),
(45, 'Gorge of Erma River', 77, 1, NULL),
(46, 'Devetashka Cave', 67, 4, NULL),
(47, 'Seven Rila Lakes', 60, 2, NULL),
(48, 'Prohodna Cave', 32, 4, NULL),
(49, 'Uhlovitsa Cave', 44, 4, NULL),
(50, 'Snezhanka Cave', 59, 4, NULL),
(51, 'Yagodina Cave', 87, 4, NULL),
(52, 'Sàeva Dupka Cave', 12, 4, NULL),
(53, 'Nikopolis ad Istrum', 47, 8, 'II'),
(54, 'Roman Baths Varna', 81, 3, 'II'),
(55, 'National archaeological reserve Kabile', 88, 8, 'II BC'),
(56, 'Samuil’s Fortress', 53, 7, 'X'),
(57, 'Medzhidi Tabiya Fortress', 66, 7, '1941'),
(58, 'Shumen Fortress Historical-Archaeological Preserve', 91, 8, 'I BC'),
(59, 'Asen’s Fortress', 2, 7, 'V BC'),
(60, 'The Stob Pyramids', 74, 7, NULL),
(61, 'The Magura Cave', 8, 4, NULL),
(62, 'Pleven Epopee 1877 Panorama', 54, 8, '1977'),
(63, 'Srebarna Nature Reserve', 71, 1, '1948'),
(64, 'Thracian Tomb of Kazanlak', 34, 8, 'IV BC'),
(65, 'Boyana Church of St. Nicholas and St. Pantaleimon', 69, 6, 'XII'),
(66, 'History Museum – Isperih', 25, 8, '1927'),
(67, 'History Museum – Bratsigovo', 11, 8, '1926'),
(68, 'Natural History Museum – Cherni Osam', 14, 8, '1976'),
(69, 'Salt Museum – Pomorie', 57, 3, '2002'),
(70, 'Archeological Reserve Sboryanovo – Isperih', 25, 8, '1988'),
(71, 'Ethnographic Museum of Danube Fishing and Boat Building – Tutrakan', 80, 8, '1974'),
(72, 'History Museum Kolyu Ficheto – Dryanovo', 19, 8, '1969'),
(73, 'History Museum – Samokov', 62, 8, '1936'),
(74, 'History Musuem – Teteven', 76, 8, '1911'),
(75, 'Regional History Museum – Shumen', 91, 8, '1857'),
(76, 'Museum House of Peyo Yavorov – Chirpan', 16, 5, '1954'),
(77, 'Regional Ethnographic Museum – Plovdiv', 56, 5, '1917'),
(78, 'Museum House Hadzhi Dimitar – Sliven', 17, 5, '1955'),
(79, 'Ethnographic Museum – Elhovo', 21, 5, '1958'),
(80, 'Ethnographic Museum – Berkovitsa', 9, 5, '1950'),
(81, 'Museum House of Stanislav Dospevski – Pazardzhik', 51, 8, '1952'),
(82, 'History Museum – Etropole', 22, 8, '1958'),
(83, 'History Museum – Klisura', 35, 8, '1976'),
(84, 'Historical Museum – Perushtitsa', 52, 8, '1955'),
(85, 'History Museum – Malko Tarnovo', 42, 8, '1983'),
(86, 'Neofit Rilski House Museum – Bansko', 6, 5, '1967'),
(87, 'Archaeological Museum – Nesebar', 46, 8, '1956'),
(88, 'Radetski Steamship National Museum – Kozloduy', 38, 8, '1982'),
(89, 'Regional History Museum – Yambol', 88, 8, '1952'),
(90, 'Regional History Museum – Plovdiv', 56, 8, '1951'),
(91, 'History Museum – Velingrad', 84, 8, '1952'),
(92, 'Museum of Vasil Levski – Lovech', 40, 5, '1954'),
(93, 'Archaeological Museum – Sozopol', 70, 8, '1961'),
(94, 'National Archaeological Institute with Museum at the Bulgarian Academy of Sciences – Sofia', 69, 8, '1905'),
(95, 'Museum of Wood Carving and Icon Painting – Tryavna', 79, 3, '1944'),
(96, 'History Museum – Batak', 7, 8, '1956'),
(97, 'Regional History Museum – Stara Zagora', 72, 8, '1907'),
(98, 'Regional History Museum – Smolyan', 68, 8, '1935'),
(99, 'Regional History Museum – Kardzhali', 30, 8, '1980'),
(100, 'Regional History Museum – Vratsa', 86, 8, '1956'),
(101, 'Regional History Museum – Veliko Tarnovo', 83, 8, '1985'),
(102, 'Regional Historical Museum – Varna', 81, 8, '1887'),
(103, 'National Anthropological Museum – Sofia', 69, 5, '2007'),
(104, 'National Museum of Vasil Levski – Karlovo', 31, 5, '1937'),
(105, 'National Museum Hristo Botev – Kalofer', 29, 5, '1944'),
(106, 'Museum of Textile Industry – Sliven', 17, 3, '1984'),
(107, 'National Polytechnic Museum – Sofia', 69, 3, '1957'),
(108, 'National Museum of Natural History at the Bulgarian Academy of Sciences – Sofia', 69, 8, '1889'),
(109, 'Naval Museum – Varna', 81, 3, '1923'),
(110, 'National Museum of Military History – Sofia', 69, 3, '1916'),
(111, 'National Museum Earth and Man – Sofia', 69, 3, '1987'),
(112, 'National History Museum – Sofia', 69, 8, '1973'),
(113, 'Osenovlashky monastery of the Most Holy Mother of God (The Seven Altars)', 49, 6, 'XI'),
(114, 'Ivanovo rock monastery St. Archangel Michael', 26, 6, '1220'),
(115, 'Etropolski Monastery St. Trinity', 22, 6, 'XII'),
(116, 'Dryanovo Monastery St. Archangel Michael', 19, 6, 'XII'),
(117, 'Aladzha Monastery Holy Trinity', 81, 6, 'X'),
(118, 'Troyan Monastery The Assumption of Mary', 78, 6, '1600'),
(119, 'Bachkovo Monastery Assumption of the Virgin', 3, 6, '1083'),
(120, 'Rila Monastery St Ivan of Rila', 60, 6, 'X'),
(121, 'Ledenika Cave', 5, 4, NULL),
(122, 'Baba Vida Fortress', 85, 7, 'X'),
(123, 'Perperikon – Medieval Archaeological Complex', 59, 7, 'V BC'),
(124, 'Kaliakra – Archaeological Reserve', 33, 7, NULL),
(125, 'The Belogradchik Cliffs', 8, 7, NULL),
(126, 'Antique Theater – Plovdiv', 56, 3, 'II'),
(127, 'Tsarevets – Architecture and Museum Reserve', 83, 8, 'XII'),
(128, 'Armira Villa', 27, 8, 'I'),
(129, 'Arbitus – Archaeological Reserve', 58, 8, 'I'),
(130, 'Starosel – Thracian Temple Complex', 73, 8, 'V BC'),
(131, 'Shiroka Laka – Architectural Reserve', 64, 8, 'XVII'),
(132, 'Etar – Architectural and Ethnographic Complex', 23, 8, '1964'),
(133, 'Ethnographic Areal Complex – Zlatograd', 89, 3, NULL),
(134, 'Medieval Fortress near the village of Mezek', 43, 7, 'XI'),
(135, 'Mezek Tomb', 43, 8, 'IV BC'),
(136, 'Madara – National Historical-Archeological Reserve', 41, 7, 'IV'),
(137, 'Veliki Preslav – National Historical-Archaeological Reserve', 82, 8, 'I'),
(138, 'Pliska – National Historical and Architectural Reserve', 55, 8, 'I')

SET IDENTITY_INSERT Sites OFF

-- Table: BonusPrizes
SET IDENTITY_INSERT BonusPrizes ON

INSERT INTO BonusPrizes(Id, Name) VALUES
(1, 'Car'),
(2, 'Bicycle'),
(3, 'Tent'),
(4, 'Excursion to Varna'),
(5, 'Sleeping bag'),
(6, 'Electric kettle'),
(7, 'Waffle maker'),
(8, 'Fireproof pan'),
(9, 'Blender'),
(10, 'Sandwich toaster'),
(11, 'Travel Backpack'),
(12, 'Tea cups'),
(13, 'Water filter jug'),
(14, 'Hand mixer')

SET IDENTITY_INSERT BonusPrizes OFF

-- Table: TouristsBonusPrizes
INSERT INTO TouristsBonusPrizes(TouristId, BonusPrizeId) VALUES
(5, 8),
(1, 14),
(3, 1),
(7, 9),
(6, 4),
(21, 12),
(18, 5),
(20, 5),
(13, 2),
(12, 13)

-- Table: SitesTourists
INSERT INTO SitesTourists(TouristId, SiteId) VALUES
(1, 5),
(1, 14),
(1, 39),
(2, 84),
(2, 138),
(3, 44),
(3, 52),
(3, 97),
(3, 129),
(4, 1),
(4, 5),
(4, 7),
(4, 8),
(4, 10),
(4, 12),
(4, 14),
(4, 25),
(4, 32),
(4, 35),
(4, 41),
(4, 45),
(4, 47),
(4, 50),
(4, 67),
(4, 83),
(4, 85),
(4, 96),
(4, 97),
(4, 98),
(4, 102),
(4, 112),
(4, 126),
(4, 128),
(4, 136),
(5, 32),
(6, 24),
(6, 38),
(6, 59),
(6, 101),
(7, 5),
(7, 12),
(7, 35),
(7, 37),
(7, 39),
(7, 56),
(8, 41),
(8, 47),
(8, 124),
(9, 38),
(9, 134),
(10, 1),
(10, 5),
(10, 6),
(10, 7),
(10, 8),
(10, 11),
(10, 12),
(10, 14),
(10, 18),
(10, 19),
(10, 22),
(10, 24),
(10, 25),
(10, 26),
(10, 31),
(10, 33),
(10, 34),
(10, 35),
(10, 36),
(10, 39),
(10, 41),
(10, 42),
(10, 44),
(10, 45),
(10, 49),
(10, 53),
(10, 58),
(10, 59),
(10, 60),
(10, 65),
(10, 68),
(10, 71),
(10, 72),
(10, 75),
(10, 81),
(10, 82),
(10, 85),
(10, 86),
(10, 87),
(10, 96),
(10, 98),
(10, 99),
(10, 100),
(10, 102),
(10, 103),
(10, 104),
(10, 112),
(10, 115),
(10, 117),
(10, 123),
(10, 135),
(10, 137),
(11, 28),
(11, 31),
(11, 39),
(11, 42),
(11, 56),
(11, 58),
(11, 59),
(11, 62),
(11, 74),
(11, 75),
(11, 76),
(11, 81),
(11, 82),
(11, 93),
(11, 99),
(11, 100),
(11, 103),
(11, 104),
(11, 120),
(11, 121),
(11, 122),
(11, 128),
(11, 129),
(11, 130),
(11, 132),
(11, 137),
(12, 39),
(12, 45),
(13, 91),
(14, 45),
(15, 6),
(15, 7),
(15, 11),
(15, 12),
(15, 16),
(15, 19),
(15, 75),
(15, 86),
(15, 92),
(15, 100),
(15, 101),
(15, 123),
(16, 12),
(16, 21),
(16, 37),
(16, 98),
(16, 103),
(16, 105),
(17, 1),
(17, 15),
(17, 17),
(17, 44),
(17, 47),
(17, 56),
(17, 68),
(17, 92),
(17, 97),
(17, 138),
(18, 14),
(18, 21),
(18, 23),
(18, 45),
(18, 48),
(18, 53),
(18, 56),
(18, 58),
(18, 74),
(18, 85),
(18, 92),
(18, 100),
(18, 108),
(18, 115),
(18, 123),
(19, 2),
(19, 3),
(19, 4),
(19, 11),
(19, 15),
(19, 16),
(19, 17),
(19, 23),
(19, 25),
(19, 28),
(19, 29),
(19, 31),
(19, 32),
(19, 33),
(19, 37),
(19, 38),
(19, 39),
(19, 41),
(19, 42),
(19, 45),
(19, 50),
(19, 53),
(19, 55),
(19, 56),
(19, 60),
(19, 61),
(19, 66),
(19, 68),
(19, 71),
(19, 72),
(19, 79),
(19, 80),
(19, 85),
(19, 89),
(19, 92),
(19, 95),
(19, 96),
(19, 98),
(19, 99),
(19, 100),
(19, 103),
(19, 105),
(19, 112),
(19, 114),
(19, 125),
(19, 127),
(19, 129),
(19, 130),
(19, 131),
(19, 133),
(19, 134),
(20, 36),
(20, 105),
(20, 133),
(21, 1),
(21, 2),
(21, 3),
(21, 4),
(21, 5),
(21, 7),
(21, 9),
(21, 10),
(21, 11),
(21, 13),
(21, 14),
(21, 15),
(21, 16),
(21, 17),
(21, 18),
(21, 19),
(21, 21),
(21, 22),
(21, 23),
(21, 24),
(21, 27),
(21, 28),
(21, 29),
(21, 35),
(21, 36),
(21, 37),
(21, 38),
(21, 39),
(21, 44),
(21, 45),
(21, 47),
(21, 48),
(21, 49),
(21, 50),
(21, 51),
(21, 52),
(21, 55),
(21, 56),
(21, 57),
(21, 59),
(21, 62),
(21, 63),
(21, 64),
(21, 66),
(21, 67),
(21, 68),
(21, 69),
(21, 70),
(21, 71),
(21, 73),
(21, 75),
(21, 76),
(21, 77),
(21, 78),
(21, 79),
(21, 82),
(21, 84),
(21, 86),
(21, 87),
(21, 88),
(21, 89),
(21, 90),
(21, 91),
(21, 93),
(21, 94),
(21, 95),
(21, 96),
(21, 97),
(21, 98),
(21, 99),
(21, 101),
(21, 102),
(21, 103),
(21, 105),
(21, 107),
(21, 108),
(21, 109),
(21, 110),
(21, 111),
(21, 112),
(21, 115),
(21, 116),
(21, 119),
(21, 120),
(21, 121),
(21, 122),
(21, 123),
(21, 125),
(21, 126),
(21, 127),
(21, 128),
(21, 129),
(21, 130),
(21, 131),
(21, 132),
(21, 133),
(21, 134),
(21, 135),
(21, 136),
(21, 137),
(21, 138),
(22, 46),
(22, 47),
(22, 56),
(22, 57),
(22, 62),
(22, 74),
(22, 82),
(22, 89),
(22, 90),
(22, 96),
(22, 99),
(22, 100),
(22, 101),
(22, 112),
(22, 124),
(22, 130),
(23, 34),
(23, 37),
(23, 42),
(23, 56),
(23, 58),
(23, 64),
(23, 69),
(23, 74),
(23, 78),
(24, 37),
(24, 52),
(24, 108),
(25, 2),
(25, 13),
(25, 28),
(25, 57),
(25, 64),
(25, 123),
(26, 91)