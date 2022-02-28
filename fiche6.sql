-- MISE A JOUR ##############################################

UPDATE fournisseur
SET FRSNOM = "BUFFETTO"
WHERE FRSNUM = 1;

-- CREATION DE LA TABLE MAGASIN

CREATE TABLE magasin(
    MAGNUM INT PRIMARY KEY,
    MAGVILLE VARCHAR(20),
    MAGGER VARCHAR(20)
)ENGINE = InnoDB;

INSERT INTO magasin
VALUES 
(1, "Rouen", "Donald"),
(2, "Paris", "Bonnet"),
(3, "Paris", "Nikola");

-- CREATION DE LA TABLE VENTE

CREATE TABLE vente(
    VNTNUM INT PRIMARY KEY,
    VNTCL INT,
    CONSTRAINT fk_vnt_cl 
    FOREIGN KEY (VNTCL)
    REFERENCES clients(CLNUM),
    VNTMAG INT, 
    CONSTRAINT fk_vnt_mag
    FOREIGN KEY (VNTMAG)
    REFERENCES magasin(MAGNUM),
    VNTART INT, 
    CONSTRAINT fk_vnt_art
    FOREIGN KEY (VNTART)
    REFERENCES article(ARTNUM),
    VNTQTE INT,
    VNTPRIX INT, 
    VNTDATE DATE
)ENGINE = InnoDB;

INSERT INTO vente
VALUES
(1, 2, 2, 3, 150, 25, '2012-05-11'),
(2, 1 ,1 ,5, 200, 80, '2012-05-08'),
(3, 1, 3, 11, 100, 2, '2012-05-10'),
(4, 2, 2, 15, 20, 4, '2012-05-13'),
(5, 2, 1, 3, 100, 28, '2012-05-10'),
(6, 1, 3, 11, 200, 1, '2012-05-14'),
(7, 2, 2, 3, 150, 24, '2013-03-11'),
(8, 3, 2, 3, 220, 23, '2011-03-15');

-- 21 pose problème

-- REQUETES ##############################################
-- Q1

-- IN
SELECT FRSNUM, FRSNOM
FROM fournisseur
WHERE FRSNUM NOT IN (SELECT FILNUM 
                     FROM filiales);
-- EXISTS
SELECT FRSNUM, FRSNOM
FROM fournisseur
WHERE NOT EXISTS (SELECT FILNUM
                  FROM filiales
                  WHERE FILNUM = FRSNUM);

-- Q2

-- IN
SELECT FRSNUM, FRSNOM
FROM fournisseur
WHERE FRSNUM NOT IN (SELECT ARTFRS 
                     FROM article);

-- EXISTS
SELECT FRSNUM, FRSNOM
FROM fournisseur 
WHERE NOT EXISTS (SELECT ARTFRS 
                  FROM article
                  WHERE ARTFRS = FRSNUM);

--  test 
INSERT INTO fournisseur
VALUES (6, "Enterprise", "Paris");

-- Q3

SELECT FRSNUM, FRSNOM 
FROM fournisseur
WHERE FRSNUM = (SELECT FILNUM
                FROM filiales
                GROUP BY FILNUM 
                HAVING COUNT(FILNUM) = 1)
AND EXISTS (SELECT FILNUM
            FROM filiales 
            WHERE FILNUM = FRSNUM AND FILVILLE = FRSVILLE);

INSERT INTO filiales
VALUES (6, "Paris");

INSERT INTO fournisseur 
VALUES (7, "PlayBoy", "Lyon");

INSERT INTO filiales
VALUES (7, "Rouen");

DELETE FROM fournisseur
WHERE FRSNUM = 7;

-- Q4

SELECT FRSNUM
FROM fournisseur
WHERE FRSNUM IN (SELECT FILNUM
                 FROM filiales
                 GROUP BY FILNUM
                 HAVING COUNT(DISTINCT FILVILLE) >= 3)
AND FRSNUM IN (SELECT FILNUM 
               FROM filiales 
               WHERE FILVILLE = "Paris");

-- Q5

SELECT FRSNUM, FRSNOM
FROM fournisseur
WHERE FRSNUM IN (SELECT FILNUM
                 FROM filiales
                 GROUP BY FILNUM
                 HAVING COUNT(DISTINCT FILVILLE) >= 3)
AND FRSNUM IN (SELECT FILNUM 
               FROM filiales 
               WHERE FILVILLE = "Paris");

-- Q6

SELECT FILVILLE
FROM filiales
GROUP BY FILVILLE
HAVING COUNT(DISTINCT FILNUM) = (SELECT COUNT(*)
                                 FROM fournisseur); 

INSERT INTO filiales
VALUES
(1, "Paris"),
(5, "Paris");

-- Q7

SELECT FILVILLE 
FROM filiales
WHERE FILVILLE NOT IN (SELECT FRSVILLE 
                       FROM fournisseur);

-- Q8 

SELECT ARTNOM, AVG(ARTPA)
FROM article
WHERE ARTFRS = (SELECT FRSNUM
                FROM fournisseur
                WHERE FRSVILLE = "Lyon")
GROUP BY ARTNOM
HAVING MIN(ARTPA) >= 100;

-- Q9

SELECT DISTINCT VNTART
FROM vente;

-- Q10

SELECT ARTNUM, ARTNOM
FROM article
WHERE ARTNUM IN (SELECT DISTINCT VNTART
                 FROM vente);

-- Q11

SELECT ARTNUM, ARTNOM
FROM article
WHERE ARTNUM NOT IN (SELECT DISTINCT VNTART
                     FROM vente);

-- Q12

SELECT ARTNOM
FROM article
WHERE ARTNOM NOT IN (SELECT DISTINCT ARTNOM 
                    FROM article 
                    WHERE ARTNUM IN (SELECT VNTART 
                                    FROM vente
                                    GROUP BY VNTART
                                    HAVING COUNT(*) > 0));

-- Q13

SELECT VNTART, AVG(VNTPRIX)
FROM vente
GROUP BY VNTART;

-- GROUPE ##############################################

-- Q14

SELECT GROUP_CONCAT(ARTNUM)
FROM article
GROUP BY ARTCOUL;

SELECT ARTCOUL, GROUP_CONCAT(ARTNUM)
FROM article
WHERE ARTCOUL IS NOT NULL
GROUP BY ARTCOUL;

-- Q15

SELECT GROUP_CONCAT(ARTCOUL)
FROM article
GROUP BY ARTNOM;

SELECT GROUP_CONCAT(ARTCOUL), ARTNOM
FROM article
WHERE ARTCOUL IS NOT NULL
GROUP BY ARTNOM;

-- Q16

SELECT COUNT(*) AS NBR_ARTICLE, GROUP_CONCAT(ARTNUM)
FROM article
GROUP BY ARTNOM;

-- DATE ################################################

-- Q17

SELECT * 
FROM vente
WHERE VNTDATE = '2012-05-10';

-- Q18

SELECT * 
FROM vente
WHERE MONTH(VNTDATE) = 3;

-- Q19

SELECT *
FROM vente
WHERE MONTH(VNTDATE) = 3 
AND YEAR(VNTDATE) = 2013;

-- Q20

SELECT DAY(VNTDATE)
FROM vente
WHERE MONTH(VNTDATE) = 3;

-- Q21

SELECT DAY(VNTDATE)
FROM vente
WHERE MONTH(VNTDATE) = 3
AND VNTNUM IN (SELECT VNTNUM
               FROM vente
               GROUP BY VNTDATE
               HAVING COUNT(*) = 1);

-- Q22

SELECT VNTNUM, DAY(VNTDATE), MONTHNAME(VNTDATE), YEAR(VNTDATE)
FROM vente
WHERE VNTNUM = 7;

-- Q23

INSERT INTO vente
VALUES
(9, 3, 3, 12, 5, 250, CURRENT_DATE()),
(10, 6, 2, 1, 1, 30, CURRENT_DATE()),
(11, 2, 1, 9, 100, 200, CURRENT_DATE());

SELECT * 
FROM vente
WHERE VNTDATE = CURRENT_DATE();

SELECT *
FROM vente
WHERE VNTDATE = '2021-04-29';

-- Q24

-- PREMIER ESSAI
SELECT CLNUM, CLNOM
FROM clients
WHERE CLNUM IN (SELECT DISTINCT VNTCL 
                FROM vente
                WHERE DATEDIFF(CURRENT_DATE(), VNTDATE) < 21);

-- SECOND ESSAIE
SELECT DISTINCT CLNUM, CLNOM, CURRENT_DATE(), VNTDATE
FROM clients, vente
WHERE CLNUM IN (SELECT DISTINCT VNTCL 
                FROM vente
                WHERE DATEDIFF(CURRENT_DATE(), VNTDATE) < 21)
AND CLNUM = VNTCL
AND VNTNUM IN (SELECT DISTINCT VNTNUM
               FROM vente
               WHERE DATEDIFF(CURRENT_DATE(), VNTDATE) < 21);

DELETE FROM vente
WHERE VNTNUM IN (9, 10, 11);