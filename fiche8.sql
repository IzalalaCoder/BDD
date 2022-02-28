USE entreprise;
-- Q1

-- IN
SELECT CLNUM, CLNOM
FROM clients
WHERE CLNUM IN (SELECT VNTCL 
                FROM vente 
                GROUP BY VNTCL
                HAVING COUNT(*) = (SELECT COUNT(*)
                                   FROM article));


INSERT INTO clients
VALUES (11, "TEST", "Enterprise", "France", "Rouen");

INSERT INTO vente
VALUES 
(9, 11, 1, 1, 100, 189, CURRENT_DATE()),
(10, 11, 1, 2, 100, 189, CURRENT_DATE()),
(11, 11, 1, 3, 100, 189, CURRENT_DATE()),
(12, 11, 1, 4, 100, 189, CURRENT_DATE()),
(13, 11, 1, 5, 100, 189, CURRENT_DATE()),
(14, 11, 1, 6, 100, 189, CURRENT_DATE()),
(15, 11, 1, 7, 100, 189, CURRENT_DATE()),
(16, 11, 1, 8, 100, 189, CURRENT_DATE()),
(17, 11, 1, 9, 100, 189, CURRENT_DATE()),
(18, 11, 1, 10, 100, 189, CURRENT_DATE()),
(19, 11, 1, 11, 100, 189, CURRENT_DATE()),
(20, 11, 1, 12, 100, 189, CURRENT_DATE()),
(21, 11, 1, 13, 100, 189, CURRENT_DATE()),
(22, 11, 1, 14, 100, 189, CURRENT_DATE()),
(23, 11, 1, 15, 100, 189, CURRENT_DATE());

DELETE FROM vente
WHERE VNTCL = 11;

DELETE FROM clients
WHERE CLNUM = 11;

-- Q2

SELECT ARTNUM, ARTNOM
FROM article
WHERE 
ARTNUM IN (SELECT VNTART 
           FROM vente 
           WHERE VNTQTE > 100)
AND ARTNUM NOT IN (SELECT VNTART 
                     FROM vente 
                     WHERE VNTQTE <= 100);

-- Q3

SELECT CLNUM, CLNOM, CLVILLE
FROM clients
WHERE CLNUM IN (SELECT VNTCL 
                FROM vente
                GROUP BY VNTCL
                HAVING COUNT(DISTINCT VNTMAG) = 1);

-- Q4

SELECT CLNUM, CLNOM, CLVILLE, ARTCOUL, VNTPRIX, MAGVILLE, FRSNOM
FROM clients, vente, article, fournisseur, magasin
WHERE CLNUM = VNTCL 
    AND VNTART = ARTNUM 
    AND ARTCOUL = "BLANC"
    AND ARTFRS = FRSNUM
    AND FRSNOM = "ELECTROLAMP"
    AND YEAR(VNTDATE) = 2012
    AND MAGNUM = VNTMAG
    AND MAGVILLE = "Paris";

INSERT INTO vente
VALUES (9, 1, 2, 5, 199, 26, '2012-07-25');

DELETE FROM vente
WHERE VNTNUM = 9;

-- Q5

SELECT ARTNUM, ARTNOM
FROM article 
WHERE ARTNUM IN (SELECT VNTART 
                 FROM vente
                 GROUP BY VNTART 
                 HAVING COUNT(*) >= ALL (SELECT COUNT(*)
                                         FROM vente
                                         GROUP BY VNTART));

SELECT ARTNUM, ARTNOM
FROM article 
WHERE ARTNUM IN (SELECT VNTART 
                 FROM vente
                 GROUP BY VNTART 
                 HAVING SUM(VNTQTE) >= ALL (SELECT SUM(VNTQTE)
                                             FROM vente
                                             GROUP BY VNTART));

-- Q6

SELECT VNTMAG
FROM vente
GROUP BY VNTMAG
HAVING COUNT(DISTINCT VNTQTE) >= ALL (SELECT COUNT(DISTINCT VNTQTE)
                                        FROM vente);

-- Q7

-- PREMIER ESSAI
SELECT VNTCL
FROM vente
GROUP BY VNTCL
HAVING COUNT(DISTINCT VNTART) = (SELECT COUNT(*)
                                 FROM magasin);

-- GROUP BY
SELECT VNTCL, COUNT(DISTINCT VNTART), COUNT(DISTINCT VNTMAG)
FROM vente
GROUP BY VNTCL 
HAVING COUNT(DISTINCT VNTART) = (SELECT COUNT(*)
                                 FROM magasin);

-- BONNE REPONSE
SELECT  VNTCL, COUNT(DISTINCT VNTART), COUNT(DISTINCT VNTMAG)
FROM vente
GROUP BY VNTCL
HAVING COUNT(DISTINCT VNTART) = COUNT(DISTINCT VNTMAG);

INSERT INTO vente
VALUES (9, 2, 3, 8, 50, 20, CURRENT_DATE());

DELETE FROM vente
WHERE VNTNUM = 9;

-- Q8

-- Premier essai
SELECT VNTCL
FROM vente
GROUP BY VNTCL
HAVING COUNT(DISTINCT VNTART) = 2
        AND COUNT(DISTINCT VNTMAG) = 2;


-- Jointure
SELECT VNTCL, COUNT(DISTINCT VNTMAG), COUNT(DISTINCT VNTART)
FROM vente
GROUP BY VNTCL
HAVING COUNT(DISTINCT VNTART) = 2 
        AND COUNT(DISTINCT VNTMAG) = 2;