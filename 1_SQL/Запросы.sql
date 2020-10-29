
SELECT st.name as "УИК", st.id_county_number as "Округ" 
FROM station st 
INNER JOIN county_number cn ON st.id_county_number = cn.id 
INNER JOIN candidate cd ON cn.id = cd.id_county_number 
AND cd.election = 'избран'  AND fraction = 'КПРФ' 
ORDER BY 2;

SELECT st.name as "УИК", st.id_county_number as "Округ"
FROM station st 
INNER JOIN county_number cn ON st.id_county_number = cn.id 
INNER JOIN candidate cd ON cn.id = cd.id_county_number 
AND cd.election IS NULL AND fraction = 'КПРФ' 
ORDER BY 2;

SELECT 
(SUM(CASE WHEN sub.election = 'избран' THEN sub.votescprf END) / SUM(CASE WHEN sub.election = 'избран' THEN sub.votesall END) ) as "Результат КПРФ с представителем",
(SUM(CASE WHEN sub.election IS NULL THEN sub.votescprf END) / SUM(CASE WHEN sub.election IS NULL THEN sub.votesall END) ) as "Результат КПРФ без представителя",
100 * ((SUM(CASE WHEN sub.election = 'избран' THEN sub.votescprf END) / SUM(CASE WHEN sub.election = 'избран' THEN sub.votesall END) ) -
(SUM(CASE WHEN sub.election IS NULL THEN sub.votescprf END) / SUM(CASE WHEN sub.election IS NULL THEN sub.votesall END))) / (SUM(CASE WHEN sub.election = 'избран' THEN sub.votescprf END) / SUM(CASE WHEN sub.election = 'избран' THEN sub.votesall END) ) as "Дельта"
FROM
(SELECT cn.*, cd.election 
FROM county_number cn 
	INNER JOIN candidate cd ON cn.id = cd.id_county_number 
	AND cd.fraction = 'КПРФ'  
	ORDER BY 1) sub;
