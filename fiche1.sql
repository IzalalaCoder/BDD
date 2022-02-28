-- Création de la base de données

CREATE DATABASE entreprise;

-- Question 1 ---------------------------------------------------------------------------------

-- : utiliser la base de données entreprise
USE entreprise;

-- Question 2 ---------------------------------------------------------------------------------

-- : créer la table PERSONNE
CREATE TABLE personne(
    CL_NUM INT,
    CL_NOM VARCHAR(20),
    CL_PRENOM VARCHAR(20),
    CL_PAYS VARCHAR(20)
);

-- Question 3 ---------------------------------------------------------------------------------

-- : renommer la table personne en clients
RENAME TABLE personne TO clients;

-- Question 4 ---------------------------------------------------------------------------------

-- : ajouter une clé primaire
ALTER TABLE clients
ADD PRIMARY KEY (CL_NUM);

-- Question 5 ---------------------------------------------------------------------------------

-- : insérer des données dans la table clients
--  Première façon d'insérer des données incomplètes
INSERT INTO clients 
VALUES
(1, "BLONDEL", "Mickael", "France"),
(2, "TRUMP", "Donald", NULL);

-- Seconde façon d'insérer des données incomplètes
INSERT INTO clients(CL_NUM, CL_NOM, CL_PRENOM)
VALUES (3, "KHABOURI", "Izana");

-- Question 6 ---------------------------------------------------------------------------------

-- : voir les données de la table clients
SELECT * FROM clients;

-- Question 7 ---------------------------------------------------------------------------------

-- : mise a jour des données 
UPDATE clients
SET CL_PAYS = "Espagne"
WHERE CL_PAYS IS NULL;

-- Question 8 ---------------------------------------------------------------------------------

-- : insertion des données
INSERT INTO clients 
VALUES
(4, "DURAND", NULL, "France"),
(5, "MULLER", "Loic", NULL),
(6, "FOURNIER", NULL, NULL);

UPDATE clients
SET CL_NOM = "DUPONT"
WHERE CL_PAYS IS NULL;

UPDATE clients
SET CL_PRENOM = "Guillaume"
WHERE CL_PRENOM IS NULL;

UPDATE clients
SET CL_PAYS = "France"
WHERE CL_PAYS IS NULL;

-- Question 9 ---------------------------------------------------------------------------------

-- : ajouter une colonne
ALTER TABLE clients
ADD CL_VILLE VARCHAR(10);

UPDATE clients
SET CL_VILLE = "Barcelone"
WHERE CL_PAYS = "Espagne";

UPDATE clients
SET CL_VILLE = "Rouen"
WHERE CL_NUM = 1 OR CL_NUM = 4;

UPDATE clients 
SET CL_VILLE = "Paris"
WHERE CL_VILLE IS NULL;

-- Question 10 ---------------------------------------------------------------------------------

-- : supprimer certaines données de la table
DELETE FROM clients
WHERE CL_NOM = "DUPONT";

-- Question 11 ---------------------------------------------------------------------------------

-- : changement de définition d'une colonne
ALTER TABLE clients
CHANGE CL_PAYS CL_PAYS VARCHAR(20) DEFAULT "France";

-- La valeur par défaut ne se met pas a la place de la valeur NULL
INSERT INTO clients
VALUES (5, "YORANCE", "Line", NULL, "Paris");

--  La valeur par défaut est correctement mise
INSERT INTO clients(CL_NUM, CL_NOM, CL_PRENOM, CL_VILLE)
VALUES (6, "PIMBOLI", "Makicia", "Paris");

-- Question 12 ---------------------------------------------------------------------------------

-- : changement de définition
ALTER TABLE clients
CHANGE CL_NOM CL_NOM VARCHAR(20) NOT NULL;

-- Question 13 ---------------------------------------------------------------------------------

-- : modification de nom de colonne
ALTER TABLE clients
CHANGE CL_NUM CLNUM INT;

ALTER TABLE clients
CHANGE CL_NOM CLNOM VARCHAR(20) NOT NULL;

ALTER TABLE clients
CHANGE CL_PRENOM CLPRENOM VARCHAR(20);

ALTER TABLE clients
CHANGE CL_PAYS CLPAYS VARCHAR(20) DEFAULT "France";

ALTER TABLE clients
CHANGE CL_VILLE CLVILLE VARCHAR(20);

-- Question 14 ---------------------------------------------------------------------------------

-- : creation de la table fournisseur
CREATE TABLE fournisseur(
    FRSNUM INT PRIMARY KEY,
    FRSNOM VARCHAR(30)
);

INSERT INTO fournisseur 
VALUES (1, "SAMSUMG");

INSERT INTO fournisseur
VALUES 
(2, "HUAWEI"),
(3, "TACOS"),
(4, "APPLE"),
(5, "CLAIREFONTAINE");

SELECT * FROM fournisseur;

-- Question 15 ---------------------------------------------------------------------------------

-- : creation de la table article
CREATE TABLE article(
    ARTNUM INT PRIMARY KEY AUTO_INCREMENT,
    ARTNOM VARCHAR(20),
    ARTPOIDS INT,
    ARTCOUL VARCHAR(10),
    ARTPA INT,
    ARTPV INT,
    ARTFRS INT
);

-- Question 16 ---------------------------------------------------------------------------------

-- : insertion des données dans la table article
INSERT INTO article(ARTNOM, ARTPOIDS, ARTCOUL, ARTPA, ARTPV, ARTFRS)
VALUES 
("AGRAFEUSE", 150, "ROUGE", 20, 29, 4),
("CALCULATRICE", 150, "NOIR", 200, 235, 1),
("CACHET-DATEUR", 100, "BLANC", 21, 30, 4),
("LAMPE", 550, "ROUGE", 105, 149, 5),
("LAMPE", 550, "BLANC", 100, 145, 5),
("LAMPE", 550, "BLEU", 105, 149, 5),
("LAMPE", 550, "VERT", 105, 149, 5),
("PESE-LETTRES 1-500", NULL, NULL, 120, 200, 3),
("PESE-LETTRES 1-1000", NULL, NULL, 150, 250, 3),
("CRAYON", 20, "ROUGE", 1, 2, 2),
("CRAYON", 20, "BLEU", 1, 2, 2),
("CRAYON LUXE", 20, "ROUGE", 3, 5, 2),
("CRAYON LUXE", 20, "VERT", 3, 5, 2),
("CRAYON LUXE", 20, "BLEU", 3, 5, 2),
("CRAYON LUXE", 20, "NOIR", 3, 5, 2);

SELECT * FROM article;

--  Question 17 ---------------------------------------------------------------------------------

-- sélections selon la clause WHERE
SELECT ARTNUM, ARTNOM, ARTPOIDS 
FROM article
WHERE ARTPOIDS > 200;

-- Question 18 ---------------------------------------------------------------------------------

SELECT ARTNUM, ARTNOM, ARTPOIDS
FROM article
WHERE ARTPV >= 2 * ARTPA;

-- Question 19 ---------------------------------------------------------------------------------

SELECT *
FROM article
WHERE ARTCOUL = "ROUGE" AND ARTPOIDS > 200;

-- Question 20 ---------------------------------------------------------------------------------

SELECT * 
FROM article
WHERE ARTCOUL != "ROUGE" AND ARTPOIDS <= 200;

-- Question 21 ---------------------------------------------------------------------------------

SELECT *
FROM article
WHERE ARTPA >= 100 AND ARTPA <= 150;

SELECT *
FROM article
WHERE ARTPA BETWEEN 100 AND 150;

-- Question 22 ---------------------------------------------------------------------------------

SELECT *
FROM article
WHERE ARTCOUL IS NULL;

-- Question 23 ---------------------------------------------------------------------------------

SELECT ARTNOM
FROM article
WHERE ARTNOM LIKE "C%";

-- Question 24 ---------------------------------------------------------------------------------

SELECT ARTNOM
FROM article
WHERE ARTNOM LIKE "C_____";

-- Question 25 ---------------------------------------------------------------------------------

-- : selection d'une colonne via les autres colonnes
SELECT ARTNOM, (ARTPV - ARTPA)
FROM article
WHERE ARTPA > 1; 

-- Question 26 ---------------------------------------------------------------------------------

SELECT ARTNOM, (ARTPV - ARTPA) AS MARGEB 
FROM article
WHERE ARTPA > 1; 