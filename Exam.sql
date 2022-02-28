CREATE DATABASE examen;
USE examen;

-- Question 1

-- CREATION DES TABLES
CREATE TABLE artiste(
    NUMARTISTE INT PRIMARY KEY,
    NOM VARCHAR(50) NOT NULL,
    PRENOM VARCHAR(50) NOT NULL,
    DATENAISSANCE DATE NOT NULL,
    VILLENAISSANCE VARCHAR(50) NOT NULL,
    PAYSNAISSANCE VARCHAR(50) NOT NULL
)ENGINE = InnoDB;

CREATE TABLE film(
    CODEF INT PRIMARY KEY,
    TITRE VARCHAR(20) NOT NULL,
    ANNEEPROD YEAR NOT NULL,
    NUMREALISATEUR INT NOT NULL,
    CONSTRAINT fk_film_rea
    FOREIGN KEY (NUMREALISATEUR)
    REFERENCES artiste(NUMARTISTE)
    ON DELETE CASCADE
)ENGINE = InnoDB;

CREATE TABLE ajoue(
    CODEF INT NOT NULL,
    CONSTRAINT fk_ajoue_film
    FOREIGN KEY (CODEF)
    REFERENCES film(CODEF)
    ON DELETE CASCADE,
    NUMARTISTE INT NOT NULL,
    CONSTRAINT fk_ajoue_artiste
    FOREIGN KEY (NUMARTISTE)
    REFERENCES artiste(NUMARTISTE)
    ON DELETE CASCADE,
    PRIMARY KEY (CODEF, NUMARTISTE)
)ENGINE = InnoDB;

CREATE TABLE prix(
    NOMPRIX VARCHAR(10) PRIMARY KEY,
    PAYS VARCHAR(30) NOT NULL
)ENGINE = InnoDB;

CREATE TABLE attribution(
    NUMARTISTE INT NOT NULL,
    CONSTRAINT fk_attrib_artiste
    FOREIGN KEY (NUMARTISTE)
    REFERENCES artiste(NUMARTISTE)
    ON DELETE CASCADE,
    NOMPRIX VARCHAR(10) NOT NULL,
    CONSTRAINT fk_attrib_prix 
    FOREIGN KEY (NOMPRIX)
    REFERENCES prix(NOMPRIX)
    ON DELETE CASCADE,
    CODEF INT NOT NULL,
    CONSTRAINT fk_attrib_film
    FOREIGN KEY (CODEF)
    REFERENCES film(CODEF)
    ON DELETE CASCADE,
    DATEATTRIB DATE NOT NULL,
    PRIMARY KEY (NUMARTISTE, NOMPRIX, CODEF)
)ENGINE = InnoDB;

--  INSERTIONS DES DONNEES DANS LES TABLES
INSERT INTO artiste
VALUES 
(1, "Dupont", 'Jacques', '1960-09-12', "Paris", "France"),
(2, "Lisia", "Virna", '1945-04-01', "Rome", "Italie"),
(3, "Durand", "Marie", '1945-04-01', "Paris", "France"),
(4, "Wood", "Clint", '1938-05-31', "San Francisco", "USA"),
(5, "Depp", "Berry",  '1962-06-10', "NY", "USA"),
(6, "Plado", "Michele", '1945-04-01', "Rome", "Italie"),
(7, "Alvar", "Pedro", '1949-09-15', "Madrid", "Espagne"),
(8, "Gabon", "Jean", '1904-05-15', "Paris", "France");

INSERT INTO film 
VALUES
(1, "La vie", 2002, 4),
(2, "Le retour", 2002, 6),
(3, "La sanction", 2005, 4),
(4, "Le chateau", 2005, 7),
(5, "Passage", 2004, 6),
(6, "Bye", 2011, 1),
(7, "Aube", 2011, 1);

INSERT INTO ajoue
VALUES
(1, 2),
(1, 6),
(2, 3),
(3, 4),
(3, 5),
(4, 3),
(4, 6),
(4, 7),
(5, 5),
(6, 3),
(6, 4),
(2, 4);

INSERT INTO prix
VALUES 
("Cesario", "France"),
("Donato", "Italie"),
("Globe", "France"),
("Leone", "Italie"),
("Oscure", "USA");

INSERT INTO attribution
VALUES 
(1, "Cesario", 3, '2008-05-10'),
(1, "Oscure", 1, '2003-02-22'),
(1, "Oscure", 2, '2003-02-22'),
(1, "Oscure", 4, '2008-02-27'),
(2, "Donato", 5, '2005-04-11'),
(2, "Leone", 5, '2005-09-23'),
(5, "Cesario", 1, '2003-05-08'),
(5, "Cesario", 5, '2005-05-08');

-- Question 2

SELECT *
FROM film
WHERE ANNEEPROD IN (2002, 2004);

-- Question 3

SELECT *
FROM prix
WHERE PAYS = "France"

UNION

SELECT *
FROM prix
WHERE PAYS = "Italie";

-- Question 4

SELECT TITRE, NOM
FROM film, artiste
WHERE NUMREALISATEUR = NUMARTISTE AND TITRE LIKE 'LA%'

UNION 

SELECT TITRE, NOM
FROM film, artiste
WHERE NUMREALISATEUR = NUMARTISTE AND TITRE LIKE 'LE%';

-- Question 5

SELECT TITRE, ANNEEPROD
FROM film
ORDER BY ANNEEPROD ASC, TITRE DESC;

-- Question 6

SELECT NOM, PRENOM
FROM artiste
WHERE PAYSNAISSANCE = "France" 
AND NUMARTISTE IN (SELECT DISTINCT NUMARTISTE
                   FROM ajoue);

-- Question 7

SELECT COUNT(DISTINCT NUMARTISTE) AS "NOM D'ACTEUR"
FROM ajoue;

-- Question 8

SELECT PAYS, GROUP_CONCAT(NOMPRIX)
FROM prix
GROUP BY PAYS;

-- Question 9

SELECT j.NUMARTISTE AS 'NUMERO ACTEUR', 
        NOM AS 'NOM ACTEUR', 
        COUNT(DISTINCT j.CODEF) AS 'NOMBRE DE FILMS JOUEE', 
        GROUP_CONCAT(TITRE) AS 'FILMS'
FROM ajoue AS j, artiste AS a, film AS f
WHERE j.NUMARTISTE = a.NUMARTISTE
AND f.CODEF = j.CODEF
GROUP BY j.NUMARTISTE;

-- Question 10

SELECT j.NUMARTISTE, NOM, COUNT(DISTINCT j.CODEF)
FROM ajoue AS j, artiste AS a
WHERE j.NUMARTISTE = a.NUMARTISTE
GROUP BY j.NUMARTISTE
HAVING COUNT(*) >= 3;

-- Question 11

SELECT TITRE, ANNEEPROD
FROM film
WHERE ANNEEPROD = (SELECT MAX(ANNEEPROD) 
                   FROM film);
    
-- Question 12

SELECT NUMARTISTE, NOM
FROM artiste
WHERE NUMARTISTE NOT IN (SELECT DISTINCT NUMREALISATEUR
                         FROM film);

-- Question 13

SELECT NUMARTISTE, NOM
FROM artiste
WHERE NUMARTISTE IN (SELECT DISTINCT NUMREALISATEUR
                     FROM film)
AND NUMARTISTE NOT IN (SELECT DISTINCT NUMARTISTE
                       FROM ajoue);    

-- Question 14

SELECT film.*
FROM film, ajoue
WHERE film.CODEF = ajoue.CODEF
AND film.NUMREALISATEUR = ajoue.NUMARTISTE;

-- Question 15

SELECT NUMARTISTE, NOM
FROM artiste
WHERE NUMARTISTE IN (SELECT NUMARTISTE
                     FROM ajoue
                     GROUP BY NUMARTISTE
                     HAVING COUNT(*) >= ALL (SELECT COUNT(*)
                                             FROM ajoue
                                             GROUP BY CODEF));

-- Question 16

SELECT * 
FROM ajoue
GROUP BY NUMARTISTE
HAVING COUNT(DISTINCT CODEF) = (SELECT COUNT(*)
                                FROM film);

-- Question 17

SELECT NUMARTISTE
FROM attribution
GROUP BY CODEF, NUMARTISTE
HAVING COUNT(DISTINCT NOMPRIX) >= 2;


-- Question 18

SELECT artiste.NUMARTISTE, artiste.NOM
FROM attribution, artiste, prix
WHERE artiste.NUMARTISTE = attribution.NUMARTISTE
AND prix.NOMPRIX = attribution.NOMPRIX
AND artiste.PAYSNAISSANCE = prix.PAYS
GROUP BY attribution.NUMARTISTE
HAVING COUNT(*) >= 1;

-- Question 19 JE N'Y ARRIVE PAS DSL

-- Question 20

SELECT COUNT(DISTINCT NUMARTISTE)
FROM ajoue 
WHERE NUMARTISTE IN (SELECT NUMARTISTE
                     FROM ajoue
                     GROUP BY NUMARTISTE
                     HAVING COUNT(DISTINCT CODEF) = (SELECT COUNT(DISTINCT CODEF)
                                                     FROM ajoue AS j, artiste AS a
                                                     WHERE a.NUMARTISTE = j.NUMARTISTE 
                                                     AND a.NOM = "Depp"
                                                     AND a.PRENOM = "Berry"));$

-- EXAMEN TERMINAL

-- Q1

SELECT DISTINCT NUMARTISTE, NOM
FROM artiste, film
WHERE NUMARTISTE = NUMREALISATEUR
AND PRENOM = "Michele";

-- Q2

SELECT DISTINCT NUMARTISTE
FROM artiste
WHERE NUMARTISTE NOT IN (SELECT DISTINCT NUMARTISTE
                         FROM ajoue)
AND NUMARTISTE NOT IN (SELECT DISTINCT NUMREALISATEUR
                       FROM film);

-- Q3

SELECT CODEF
FROM ajoue
GROUP BY CODEF
HAVING COUNT(DISTINCT NUMARTISTE) <= ALL (SELECT COUNT(DISTINCT CODEF)
                                          FROM ajoue
                                          GROUP BY NUMARTISTE);

-- Q4

SELECT NUMARTISTE
FROM attribution
WHERE NOMPRIX IN (SELECT DISTINCT NOMPRIX
                  FROM attribution
                  WHERE NUMARTISTE = 1)
GROUP BY NUMARTISTE 
HAVING COUNT(DISTINCT NOMPRIX) = (SELECT COUNT(DISTINCT NOMPRIX)
                                  FROM attribution
                                  WHERE NUMARTISTE = 1);
    
INSERT INTO attribution
VALUES (5, "Oscure", 5, CURRENT_DATE());

INSERT INTO attribution
VALUES (5, "Leone", 5, CURRENT_DATE());

DELETE FROM attribution
WHERE DATEATTRIB = CURRENT_DATE();