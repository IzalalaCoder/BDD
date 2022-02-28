USE entreprise;

-- Question 1 ---------------------------------------------------------------------------------

-- : utilisation du mot cle distinct 
SELECT DISTINCT ARTNOM
FROM article 
WHERE ARTPOIDS = 20;

-- Question 2 ---------------------------------------------------------------------------------

-- :  utilisation du mot cle order 
SELECT *
FROM article
WHERE ARTPOIDS IS NOT NULL
ORDER BY ARTPOIDS DESC;

-- Question 3 ---------------------------------------------------------------------------------

SELECT *
FROM article
WHERE ARTPOIDS IS NOT NULL -- ghOR ARTPA IS NOT NULL
ORDER BY ARTPOIDS ASC, ARTPA DESC;

-- Question 4 ---------------------------------------------------------------------------------

SELECT *
FROM article
WHERE ARTCOUL IS NOT NULL
ORDER BY (ARTPV - ARTPA) DESC, ARTCOUL ASC; 

-- Question 5 ---------------------------------------------------------------------------------

SELECT *
FROM article 
ORDER BY (ARTPV - ARTPA) DESC, ARTNOM DESC;

-- Question 6 ---------------------------------------------------------------------------------

SELECT *
FROM article 
WHERE ARTCOUL = "ROUGE"
ORDER BY (ARTPV - ARTPA) DESC, ARTNOM DESC;

-- Question 7 ---------------------------------------------------------------------------------

SELECT *
FROM article
WHERE ARTNOM LIKE '%E'
LIMIT 3;

-- Question 8 ---------------------------------------------------------------------------------

SELECT *
FROM article
WHERE ARTNOM LIKE '%E'
LIMIT 5, 3;

-- Question 9 ---------------------------------------------------------------------------------

SELECT ARTNUM, ARTPA
FROM article
ORDER BY ARTPV DESC
LIMIT 1;

-- Question 10 ---------------------------------------------------------------------------------

DELETE FROM fournisseur;

INSERT INTO fournisseur 
VALUES  (1, "CATIO-ELECTRIQUE"),
        (2, "LES STYLOS REUNIS"),
        (3, "MECANIQUE DE PRECISION"),
        (4, "SARL ROULAND"),
        (5, "ELECTROLAMP");

-- Question 11 ---------------------------------------------------------------------------------

ALTER TABLE article ENGINE=InnoDB;
ALTER TABLE fournisseur ENGINE=InnoDB;
ALTER TABLE clients ENGINE=InnoDB;

ALTER TABLE article
ADD 
CONSTRAINT fk_art_frs
FOREIGN KEY (ARTFRS)
REFERENCES fournisseur(FRSNUM) 
ON DELETE CASCADE;

-- Question 12 ---------------------------------------------------------------------------------

SELECT DISTINCT FRSNOM
FROM fournisseur, article
WHERE ARTFRS = FRSNUM AND ARTNOM = "LAMPE";

-- Question 13 ---------------------------------------------------------------------------------

SELECT DISTINCT x.ARTNOM
FROM article AS x, article AS y
WHERE x.ARTPA > y.ARTPA AND y.ARTNUM = 5; 

-- Question 14 ---------------------------------------------------------------------------------

SELECT ARTPOIDS, ARTNOM, FRSNOM
FROM article, fournisseur
WHERE ARTCOUL = "ROUGE" AND FRSNUM = ARTFRS; 

-- Question 15 ---------------------------------------------------------------------------------

SELECT x.ARTNUM AS NUM_1, x.ARTCOUL AS COUL_1, y.ARTNUM AS NUM_2, y.ARTCOUL AS COUL_2, FRSNUM
FROM article AS x, article AS y, fournisseur
WHERE x.ARTFRS = FRSNUM AND x.ARTNUM != y.ARTNUM AND x.ARTCOUL = y.ARTCOUL AND x.ARTFRS = y.ARTFRS;

-- Variante --> EVITER LES DOUBLONS

SELECT x.ARTNUM AS NUM_1, x.ARTCOUL AS COUL_1, y.ARTNUM AS NUM_2, y.ARTCOUL AS COUL_2, FRSNUM
FROM article AS x, article AS y, fournisseur
WHERE x.ARTFRS = FRSNUM AND x.ARTNUM > y.ARTNUM AND x.ARTCOUL = y.ARTCOUL AND x.ARTFRS = y.ARTFRS;

-- Question 16 ---------------------------------------------------------------------------------

SELECT DISTINCT ARTNOM
FROM article, fournisseur
WHERE FRSNOM LIKE 'L%' AND ARTFRS = FRSNUM
ORDER BY ARTNOM DESC;

-- Question 17 ---------------------------------------------------------------------------------

SELECT CLNOM
FROM clients, fournisseur
WHERE CLNOM = FRSNOM;

INSERT INTO clients
VALUES (7, "SARL ROULAND", NULL, "France", "Paris");

-- Question 18 ---------------------------------------------------------------------------------

INSERT INTO clients
VALUES (8, "DURAND", "Thomas", "France", "Lyon");

SELECT x.CLNUM AS NUM_A, x.CLNOM AS NOM_A, y.CLNUM AS NUM_B, y.CLNOM AS NOM_B
FROM clients AS x, clients AS y
WHERE x.CLNUM < y.CLNUM AND x.CLNOM = y.CLNOM;

-- Question 19 ---------------------------------------------------------------------------------

SELECT A.ARTNOM, A.ARTPA
FROM article AS A, article AS AGRAFEUSE
WHERE A.ARTPV < AGRAFEUSE.ARTPV AND AGRAFEUSE.ARTNOM = "AGRAFEUSE";

-- Question 20 ---------------------------------------------------------------------------------

SELECT A.ARTNOM, A.ARTPA
FROM article AS A, article AS CDT
WHERE A.ARTPV > CDT.ARTPA AND CDT.ARTNOM = "CACHET-DATEUR";

-- Question 21 ---------------------------------------------------------------------------------

ALTER TABLE fournisseur 
ADD FRSVILLE VARCHAR(10);

-- Question 22 ---------------------------------------------------------------------------------

UPDATE fournisseur
SET FRSVILLE = "Paris"
WHERE FRSNUM = 2 OR FRSNUM = 4;

UPDATE fournisseur
SET FRSVILLE = "Rouen"
WHERE FRSNUM = 3;

UPDATE fournisseur
SET FRSVILLE = "Lyon"
WHERE FRSNUM = 5;

UPDATE fournisseur
SET FRSVILLE = "Rome"
WHERE FRSNUM = 1;

-- Question 23 ---------------------------------------------------------------------------------

SELECT CLNOM, FRSNOM, FRSVILLE
FROM clients, fournisseur
WHERE CLVILLE = FRSVILLE;

-- Question 24 ---------------------------------------------------------------------------------

SELECT DISTINCT CLNOM, FRSNOM
FROM clients, fournisseur
WHERE CLVILLE != FRSVILLE;

-- Question 25 ---------------------------------------------------------------------------------

SELECT x.FRSNUM AS xNUM, x.FRSNOM AS xNOM, y.FRSNUM AS yNUM, y.FRSNOM AS yNOM, x.FRSVILLE
FROM fournisseur AS x, fournisseur AS y
WHERE x.FRSNUM < y.FRSNUM AND x.FRSVILLE = y.FRSVILLE; 

-- Question 26 ---------------------------------------------------------------------------------

CREATE TABLE filiales(
    FILNUM INT,
    CONSTRAINT fk_fil_frs
    FOREIGN KEY (FILNUM)
    REFERENCES fournisseur(FRSNUM)
    ON DELETE CASCADE,
    FILVILLE VARCHAR(10),
    PRIMARY KEY(FILNUM, FILVILLE)
)ENGINE=InnoDB;

-- Question 27 ---------------------------------------------------------------------------------

INSERT INTO filiales
VALUES
(1, "Rome"),
(1, "Florence"),
(2, "Paris"),
(2, "Rouen"),
(3, "Dieppe"),
(3, "Paris"),
(1, "Barcelone"),
(4, "Paris"),
(4, "Marseille"),
(4, "Lyon");

-- Question 28 ---------------------------------------------------------------------------------

SELECT FRSNUM, FRSNOM
FROM fournisseur, filiales
WHERE FRSNUM = FILNUM AND FILVILLE = "Paris";

-- Question 29 ---------------------------------------------------------------------------------

SELECT FILVILLE
FROM filiales
WHERE FILNUM = 3;