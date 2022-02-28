USE entreprise;

-- Question 1 ---------------------------------------------------------------------------------

SELECT ARTNUM, ARTPOIDS, ARTPV
FROM article
WHERE ARTCOUL = "ROUGE" AND ARTPV < 30
ORDER BY ARTPOIDS, ARTNUM DESC
LIMIT 1;

-- Question 2 ---------------------------------------------------------------------------------

SELECT AVG(ARTPOIDS)
FROM article;

-- Question 3 ---------------------------------------------------------------------------------

SELECT AVG(ARTPOIDS), MAX(ARTPV - ARTPA), MIN(ARTPA)
FROM article;

-- Question 4 ---------------------------------------------------------------------------------

SELECT COUNT(*)
FROM article;

-- Question 5 ---------------------------------------------------------------------------------

SELECT COUNT(*)
FROM article
WHERE ARTCOUL IS NOT NULL;

-- Question 6 ---------------------------------------------------------------------------------

SELECT ARTCOUL, COUNT(ARTCOUL)
FROM article
WHERE ARTCOUL IS NOT NULL
GROUP BY ARTCOUL;

SELECT COUNT(DISTINCT ARTCOUL)
FROM article;

-- Question 7 ---------------------------------------------------------------------------------

SELECT SUM(ARTPA)
FROM article
WHERE ARTCOUL = "ROUGE";

-- Question 8 ---------------------------------------------------------------------------------

SELECT ARTCOUL
FROM article
GROUP BY ARTCOUL;

SELECT ARTCOUL
FROM article
WHERE ARTCOUL IS NOT NULL
GROUP BY ARTCOUL;

SELECT DISTINCT ARTCOUL
FROM article
WHERE ARTCOUL IS NOT NULL;

-- Question 9 ---------------------------------------------------------------------------------

SELECT ARTCOUL, AVG(ARTPV)
FROM article
WHERE ARTCOUL IS NOT NULL
GROUP BY ARTCOUL;

-- Question 10 ---------------------------------------------------------------------------------

SELECT ARTCOUL
FROM article
WHERE ARTCOUL IS NOT NULL
GROUP BY ARTCOUL
HAVING AVG(ARTPV) > 50;

-- Question 11 ---------------------------------------------------------------------------------

SELECT ARTNOM, COUNT(*)
FROM article 
GROUP BY ARTNOM
HAVING COUNT(*) >= 2;

-- Question 12 ---------------------------------------------------------------------------------

SELECT CLNOM
FROM clients
GROUP BY CLNOM
HAVING COUNT(*) = 1;

-- Question 13 ---------------------------------------------------------------------------------

SELECT ARTNUM
FROM article
ORDER BY ARTPV DESC
LIMIT 10;

-- Question 14 ---------------------------------------------------------------------------------

SELECT ARTNUM
FROM article, fournisseur
WHERE ARTFRS = FRSNUM AND FRSVILLE = "Paris";

-- Question 15 ---------------------------------------------------------------------------------

SELECT x.ARTNUM AS xNUM, y.ARTNUM AS yNUM
FROM article AS x, article AS y
WHERE x.ARTFRS = y.ARTFRS AND x.ARTNUM < y.ARTNUM;

-- Question 16 ---------------------------------------------------------------------------------

SELECT ARTNOM, SUM(ARTPV - ARTPA) AS MARGEB_TOTALE
FROM article
GROUP BY ARTNOM;

-- Question 17 ---------------------------------------------------------------------------------

SELECT ARTNOM
FROM article
WHERE (ARTPV - ARTPA) = (SELECT MAX(ARTPV - ARTPA)
                         FROM article
                        );

SELECT ARTNOM, MAX(ARTPV - ARTPA) AS MAXI
FROM article
GROUP BY ARTNOM
ORDER BY MAXI DESC
LIMIT 1; 


-- Question 18 ---------------------------------------------------------------------------------

SELECT DISTINCT MAX(ARTPOIDS)
FROM article
WHERE ARTPOIDS IS NOT NULL
GROUP BY (ARTPV - ARTPA);

-- Question 19 ---------------------------------------------------------------------------------

SELECT DISTINCT MAX(ARTPOIDS)
FROM article
WHERE (ARTPV - ARTPA) > 10 AND ARTCOUL IS NOT NULL
GROUP BY (ARTPV - ARTPA);

-- Question 20 ---------------------------------------------------------------------------------

SELECT FILVILLE
FROM filiales
GROUP BY FILVILLE
HAVING COUNT(FILVILLE) >= 3;

-- Question 21 ---------------------------------------------------------------------------------

SELECT FRSNUM, FRSVILLE
FROM fournisseur, filiales
WHERE FILNUM = FRSNUM AND FILVILLE = FRSVILLE;

-- Question 22 ---------------------------------------------------------------------------------

SELECT FILVILLE
FROM filiales, article
WHERE FILNUM = ARTFRS
GROUP BY FILVILLE
HAVING MAX(ARTPOIDS) <= 100 OR MAX(ARTPOIDS) IS NULL;

-- Question 23 ---------------------------------------------------------------------------------

SELECT CLNOM, CLPRENOM, COUNT(CLVILLE) AS NB_VILLE
FROM clients
GROUP BY CLNOM, CLPRENOM;

-- ESSAI
INSERT INTO clients
VALUES
(9, "DURAND", "Thomas", "France", "Paris"),
(10, "DURAND", "Thomas", "France", "Madrid");

-- Question 24 ---------------------------------------------------------------------------------

SELECT CLNOM, CLPRENOM
FROM clients
GROUP BY CLNOM, CLPRENOM
HAVING COUNT(*) = 1;

-- Question 25 ---------------------------------------------------------------------------------

SELECT FILVILLE
FROM filiales
GROUP BY FILVILLE
HAVING COUNT(*) > 1;