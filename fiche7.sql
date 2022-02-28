USE entreprise;

-- 7 8 
-- 12 

-- Q1 

SELECT VNTCL
FROM vente
GROUP BY VNTCL
HAVING COUNT(*) > 2;

-- Q2

-- IN et JOINTURE

SELECT CLNUM, CLNOM, VNTDATE
FROM clients, vente
WHERE CLNUM = VNTCL
AND CLNUM IN (SELECT VNTCL 
              FROM vente
              GROUP BY VNTCL
              HAVING COUNT(*) = 1);

-- Q3

SELECT VNTART
FROM vente
GROUP BY VNTART
HAVING AVG(VNTQTE) > (SELECT AVG(VNTQTE)
                      FROM vente);

--   Q4

SELECT SUM(VNTQTE), COUNT(DISTINCT VNTCL), COUNT(DISTINCT DAY(VNTDATE))
FROM vente
WHERE YEAR(VNTDATE) = 2012
GROUP BY VNTMAG;

-- Q5

-- IN
SELECT ARTNUM, ARTNOM
FROM article
WHERE ARTNUM IN (SELECT DISTINCT VNTCL
                 FROM vente 
                 WHERE VNTMAG IN (SELECT DISTINCT MAGNUM
                                  FROM magasin 
                                  WHERE MAGVILLE = "Paris"));

-- JOINTURE
SELECT DISTINCT ARTNUM, ARTNOM
FROM article, vente, magasin
WHERE ARTNUM = VNTCL
AND MAGNUM = VNTMAG
AND MAGVILLE = "Paris";

-- Q6

SELECT MAX(VNTPRIX)
FROM vente
WHERE VNTMAG IN (SELECT DISTINCT MAGNUM
                 FROM magasin
                 WHERE MAGVILLE = "Paris")
GROUP BY VNTART;

-- Q7

-- Q9

SELECT ARTNOM
FROM article
WHERE ARTFRS = (SELECT ARTFRS
                FROM article
                WHERE ARTNOM = "AGRAFEUSE");

-- Q10

SELECT VNTART
FROM vente
GROUP BY VNTART
HAVING COUNT(DISTINCT VNTCL) > 10;

-- Q11

SELECT CLNUM, CLNOM
FROM clients
WHERE CLNUM IN (SELECT VNTCL
                FROM vente
                GROUP BY VNTCL
                HAVING COUNT(*) >= 1 AND SUM(VNTQTE) >= 20)
ORDER BY CLNOM ASC;

-- ajouter la clarte

-- Q12

SELECT CLNUM, CLNOM
FROM clients
WHERE 
ORDER BY 

-- Q13

SELECT CLNUM, CLNOM
FROM clients
WHERE CLNUM IN (SELECT VNTCL 
                FROM vente
                WHERE VNTART IN (SELECT ARTNUM  
                                FROM article
                                WHERE ARTNOM LIKE 'CRAYON%')
                GROUP BY VNTCL
                HAVING SUM(VNTQTE) >= 100);

-- Q14

SELECT SUM(VNTQTE) AS QTE_TOTALE
FROM vente
WHERE VNTCL IN (SELECT CLNUM 
                FROM clients
                WHERE CLVILLE = "Paris")
GROUP BY VNTCL
ORDER BY QTE_TOTALE DESC;

-- Q15

SELECT CLNUM, CLNOM, VNTQTE
FROM clients, vente
WHERE CLNUM = VNTCL AND VNTART IN (SELECT ARTNUM 
				                   FROM ARTICLE 
 				                   WHERE ARTNOM  LIKE "CRAYON%" )
                    AND VNTQTE IN (SELECT MAX(VNTQTE) 
                                    FROM VENTE 
                                    WHERE VNTART IN (SELECT ARTNUM 
                                                    FROM ARTICLE 
                                                    WHERE ARTNOM  LIKE "CRAYON%"));