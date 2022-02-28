USE entreprise;

-- 6 8 9

-- Q1 ---------------------------------------------------------------------------------

SELECT ARTNUM
FROM article
WHERE ARTCOUL = (SELECT MAX(ARTCOUL)
                 FROM article);


-- Q2 ---------------------------------------------------------------------------------

SELECT MIN(ARTPA) FROM article;

-- Requêtes imbriquées et IN
SELECT FRSNOM 
FROM fournisseur
WHERE FRSNUM IN (SELECT ARTFRS 
                 FROM article
                 WHERE ARTPA = (SELECT MIN(ARTPA)
                                FROM article
                                )
                );

-- Jointure et Requêtes imbriquée 
SELECT DISTINCT FRSNOM
FROM fournisseur, article
WHERE FRSNUM = ARTFRS   
AND ARTPA = (SELECT MIN(ARTPA)
             FROM article);

-- Q3 ---------------------------------------------------------------------------------

-- Requêtes imbriquées
SELECT ARTNUM, ARTNOM
FROM article
WHERE ARTCOUL = (SELECT ARTCOUL 
                 FROM article
                 WHERE ARTNUM = 1)
AND ARTPOIDS > (SELECT AVG(ARTPOIDS)
                FROM article);

-- Q4 ---------------------------------------------------------------------------------

-- RI
SELECT *
FROM article
WHERE ARTPV > (SELECT MIN(ARTPV)
               FROM article
               WHERE ARTCOUL = "VERT");

-- VARIANTE
SELECT *, (SELECT MIN(ARTPV)
           FROM article
           WHERE ARTCOUL = "VERT")
           AS COMP_V_MIN
FROM article
WHERE ARTPV > (SELECT MIN(ARTPV)
               FROM article
               WHERE ARTCOUL = "VERT");

-- Q5 ---------------------------------------------------------------------------------

SELECT MAX(ARTPV)
FROM article
WHERE ARTCOUL = "NOIR";

SELECT *
FROM article
WHERE ARTPV > ALL (SELECT ARTPV 
                    FROM article
                    WHERE ARTCOUL = "NOIR");

SELECT *
FROM article
WHERE ARTPV > (SELECT MAX(ARTPV)
               FROM article
               WHERE ARTCOUL = "NOIR");

-- Q6 ---------------------------------------------------------------------------------

-- Q7 ---------------------------------------------------------------------------------

-- EXISTS
SELECT FRSNUM
FROM fournisseur
WHERE NOT EXISTS (SELECT FILNUM 
                  FROM filiales
                  WHERE FILNUM = FRSNUM AND FRSVILLE = FILVILLE);

-- Q8 ---------------------------------------------------------------------------------
-- Q9 ---------------------------------------------------------------------------------
-- Q10 ---------------------------------------------------------------------------------

-- JOINTURE
SELECT FRSNOM
FROM fournisseur, filiales
WHERE FRSNUM = FILNUM 
GROUP BY FILNUM
HAVING COUNT(DISTINCT FILVILLE) >= 3;

-- IN
SELECT FRSNOM
FROM fournisseur
WHERE FRSNUM IN (SELECT FILNUM 
                 FROM filiales
                 GROUP BY FILNUM
                 HAVING COUNT(DISTINCT FILVILLE) >= 3
                );

-- Q11 ---------------------------------------------------------------------------------

-- IN
SELECT FRSNOM
FROM fournisseur
WHERE FRSNUM IN (SELECT FILNUM
                 FROM filiales
                 WHERE FILVILLE = "Rouen");
                
-- EXISTS
SELECT FRSNOM
FROM fournisseur
WHERE EXISTS (SELECT FILNUM 
              FROM filiales
              WHERE FILNUM = FRSNUM AND FILVILLE = "Rouen");

-- Q12 ---------------------------------------------------------------------------------
-- EXISTS
SELECT FRSNOM 
FROM fournisseur
WHERE EXISTS (SELECT FILNUM 
              FROM filiales
              WHERE FILNUM = FRSNUM AND FILVILLE = "Paris")
AND NOT EXISTS (SELECT FILNUM 
                FROM filiales 
                WHERE FILNUM = FRSNUM AND FILVILLE = "Rouen");
-- IN 
SELECT FRSNOM
FROM fournisseur
WHERE FRSNUM IN (SELECT DISTINCT FILNUM
                 FROM filiales
                 WHERE FILVILLE = "Paris")
    AND FRSNUM NOT IN (SELECT DISTINCT FILNUM
                       FROM filiales
                       WHERE FILVILLE = "Rouen"); 

-- Q13 ---------------------------------------------------------------------------------

SELECT *
FROM article
WHERE ARTPV > 20 
      AND ARTCOUL = "ROUGE" 
      AND ARTPV = (SELECT MAX(ARTPV)
                   FROM article
                   WHERE ARTCOUL = "ROUGE");

INSERT INTO article
VALUES(16, "LAMPE", 550, "ROUGE", 110, 149, 5);

DELETE FROM article
WHERE ARTNUM = 16;