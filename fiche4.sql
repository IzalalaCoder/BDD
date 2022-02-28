USE entreprise;
-- Question 8 a finir

-- Question 1 ---------------------------------------------------------------------------------

-- La difference réside dans l'ordre 
SELECT ARTNUM, ARTNOM, ARTPV 
FROM article
WHERE ARTPV > 200

UNION 

SELECT ARTNUM, ARTNOM, ARTPV
FROM article
WHERE ARTCOUL = "ROUGE";

SELECT ARTNUM, ARTNOM, ARTPV
FROM article
WHERE ARTPV > 200 OR ARTCOUL = "ROUGE";

-- Question 2 ---------------------------------------------------------------------------------

SELECT ARTNUM, ARTNOM, ARTPV
FROM article
WHERE ARTPV > 200

UNION

(SELECT ARTNUM, ARTNOM, ARTPV
FROM article
WHERE ARTCOUL = "ROUGE"
ORDER BY ARTPV DESC);

-- Question 3 ---------------------------------------------------------------------------------

SELECT CLNOM AS NOMS
FROM clients 

UNION

SELECT FRSNOM
FROM fournisseur;

-- Question 4 ---------------------------------------------------------------------------------

-- JOINTURE
SELECT DISTINCT FRSNOM
FROM fournisseur, article
WHERE FRSNUM = ARTFRS AND ARTCOUL = "ROUGE";

-- IN
SELECT FRSNOM
FROM fournisseur
WHERE FRSNUM IN (SELECT DISTINCT ARTFRS 
                 FROM article
                 WHERE ARTCOUL = "ROUGE");

-- EXISTS
SELECT FRSNOM
FROM fournisseur
WHERE EXISTS (SELECT ARTFRS 
              FROM article
              WHERE ARTFRS = FRSNUM AND ARTCOUL = "ROUGE");

-- Question 5 ---------------------------------------------------------------------------------

-- ALL
SELECT DISTINCT ARTPV 
FROM article
WHERE ARTPV >= ALL (SELECT ARTPV 
                    FROM article
                    WHERE ARTFRS = 5)
AND ARTFRS = 5;

-- MAX
SELECT MAX(ARTPV)
FROM article
WHERE ARTFRS = 5;

-- REQUETES IMBRIQUEES
SELECT MAX(ARTPV)
FROM article
GROUP BY ARTFRS
HAVING ARTFRS = 5;

-- Question 6 ---------------------------------------------------------------------------------

-- Premiere solution
SELECT ARTNUM, ARTPV
FROM article
WHERE ARTPV = (SELECT MAX(ARTPV)
                FROM article 
                WHERE ARTFRS = 5)
AND ARTFRS = 5;

-- Seconde solution
SELECT ARTNUM, ARTPV
FROM article
WHERE ARTFRS = 5
AND ARTPV >= ALL (SELECT ARTPV 
                    FROM article
                    WHERE ARTFRS = 5);

-- Question 7 ---------------------------------------------------------------------------------

SELECT ARTNUM, ARTPOIDS, ARTPV
FROM article
WHERE ARTPV < 30 
AND ARTCOUL = "ROUGE" 
AND ARTPOIDS <= ALL (SELECT ARTPOIDS
                     FROM article
                     WHERE ARTCOUL = "ROUGE"
                    );

SELECT ARTNUM, ARTPOIDS, ARTPV
FROM article
WHERE ARTPV < 30 
AND ARTCOUL = "ROUGE" 
AND ARTPOIDS = (SELECT MIN(ARTPOIDS)
                FROM article
                WHERE ARTCOUL = "ROUGE"
                );

-- Question 8 ---------------------------------------------------------------------------------

-- premiere solution
SELECT ARTNUM, ARTPOIDS, ARTPV
FROM article
WHERE ARTNUM >= ALL (SELECT ARTNUM
                     FROM article
                     WHERE ARTCOUL = "ROUGE" AND ARTPV < 30
                    )
AND ARTCOUL = "ROUGE";

-- seconde solution


-- Question 9 ---------------------------------------------------------------------------------

SELECT FRSNUM, FRSNOM
FROM fournisseur
WHERE FRSNUM NOT IN (SELECT ARTFRS 
                     FROM article
                     WHERE ARTCOUL = "BLANC"
                     GROUP BY ARTFRS
                    );

-- Question 10 ---------------------------------------------------------------------------------

SELECT DISTINCT ARTNOM
FROM article
WHERE ARTPA = (SELECT MIN(ARTPA) 
               FROM article);

SELECT DISTINCT ARTNOM
FROM article
WHERE ARTPA <= ALL (SELECT ARTPA 
                   FROM article);