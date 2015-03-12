SELECT `compliance status`, count(`compliance status`)
FROM ecb2
GROUP BY `compliance status`;

SELECT `compliance status`, count(`compliance status`)
FROM ecb2
WHERE `compliance STATUS` NOT IN ('', 'All Terms Met')
-- AND `charge #2: code description` <> ''
-- GROUP BY `compliance status`
;

SELECT `compliance status`, count(`compliance status`)
FROM ecb2
WHERE `charge #2: code description` <> ''
;

-- # of businesses with more than one charge: 23283
	-- # of those multiple charges in the same cluster: 15393 (or more)
-- # of businesses not fully compliant: 255703
-- # of businesses not fully compliant AND more than one charge: 5779
;

SELECT count(`Ticket Number`) AS 'numTickets', `Respondent Last Name`, `Respondent First Name`
FROM ecb2
WHERE `Violation Location (Zip CODE)` <> ''
GROUP BY `Violation Location (Zip CODE)`, `Violation Location (Street NAME)`, `Violation Location (House #)`, `REspondent last name`
HAVING count(`Ticket Number`) > 1
ORDER BY numTickets DESC
;

SELECT *
FROM ecb2
WHERE `RESPONDENT LAST NAME` = 'Susan'
AND `respondent FIRST NAME` = 'ANTENEN';

ALTER TABLE ecbwcluster
ADD `Charge #2: Cluster` INT(11);

UPDATE ecbwcluster e
LEFT JOIN clusterkeys ON `Charge #2: code` = codenum
SET `Charge #2: Cluster` = cluster
WHERE `Charge #2: Code` = codenum
AND `Charge #2: Code` <> ''
;

SELECT *
FROM ecbwcluster
WHERE cluster = `Charge #2: Cluster`;

UPDATE ecb3 e
LEFT JOIN ecbwcluster ec ON e.`Ticket Number` = ec.`Ticket Number`
SET e.`Charge #2: Cluster` = ec.`Charge #2: Cluster`;

-- Total cost: 3,479,735
SELECT sum(`Charge #1: Infraction Amount`)
FROM ecb3
WHERE `Charge #2: Code` <> ''
AND `Charge #1: Cluster` = `Charge #2: Cluster`
AND `Charge #1: Infraction Amount` < `Charge #2: Infraction Amount`;

-- TOTAL cost: 8,663,935
SELECT sum(`Charge #1: Infraction Amount`)
FROM ecb3
WHERE `Charge #2: Code` <> ''
AND `Charge #1: Cluster` = `Charge #2: Cluster`
AND `Charge #1: Infraction Amount` > `Charge #2: Infraction Amount`;

-- Total value of first charges: 221,924,401
SELECT sum(`Charge #1: Infraction Amount`)
FROM ecb3;

-- Total value of first charges: 14,456,336
SELECT sum(`Charge #2: Infraction Amount`)
FROM ecb3;
