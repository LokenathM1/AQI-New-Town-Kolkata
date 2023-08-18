
SELECT `Date`, STR_TO_DATE(`Date`, '%d-%m-%Y') as newdate FROM aqi;

UPDATE aqi
set `Date` = STR_TO_DATE(`Date`, '%d-%m-%Y');

ALTER TABLE aqi
MODIFY COLUMN `date` DATE;


SELECT hour,TIME_FORMAT(STR_TO_DATE(HOUR, '%H'), '%h %p') as converted_time FROM aqi;

UPDATE aqi
set `Hour` = TIME_FORMAT(STR_TO_DATE(HOUR, '%H'), '%h %p');

SELECT YEAR(`date`),MONTHNAME(`date`),AVG(aqi) 
FROM aqi
WHERE WEEKDAY(`date`) NOT in (5,6)
GROUP BY YEAR(`date`),MONTHNAME(`date`);

SELECT YEAR(`date`) as `Year`,MONTHNAME(`date`) as Months,AVG(aqi) as `AQI`
FROM aqi
WHERE WEEKDAY(`date`) in (5,6)
GROUP BY YEAR(`date`),MONTHNAME(`date`);

-------------Week day aqi vs weekend aqi----

WITH CTE AS (SELECT YEAR(`date`) AS YR,MONTHNAME(`date`) AS Months,AVG(aqi) AS `AQI1`
FROM aqi
WHERE WEEKDAY(`date`) NOT in (5,6)
GROUP BY YEAR(`date`),MONTHNAME(`date`)),
CTE2 AS (SELECT YEAR(`date`) as YR,MONTHNAME(`date`) as Months,AVG(aqi) as `AQI2`
FROM aqi
WHERE WEEKDAY(`date`) in (5,6)
GROUP BY YEAR(`date`),MONTHNAME(`date`))
SELECT YR,Months,`AQI1`,`AQI2` FROM CTE JOIN CTE2 USING(Months,YR);


SELECT YEAR(`date`),DAYNAME(`date`),AVG(aqi) 
FROM aqi
GROUP BY YEAR(`date`),DAYNAME(`date`)
ORDER BY YEAR(`date`) , WEEKDAY(`date`);

SELECT YEAR(`date`),MONTHNAME(`date`),ROUND(AVG(aqi)) AS `AVG`
FROM aqi
GROUP BY YEAR(`date`),MONTHNAME(`date`);

SELECT * FROM aqi
ORDER BY `AQI`;

SELECT * FROM aqi
ORDER BY `AQI` DESC;

SELECT * FROM aqi
WHERE `AQI` = (SELECT max(`AQI`) FROM aqi);

SELECT * FROM aqi
WHERE `AQI` = (SELECT MIN(`AQI`) FROM aqi);

SELECT YEAR(`date`),`Hour`,AVG(`AQI`)
FROM aqi
GROUP BY YEAR(`date`),`Hour`;

SELECT `Hour`, 
        ROUND(AVG(CASE WHEN year(`date`) = 2021 THEN `AQI` ELSE NULL END)) as `2021`,
        ROUND(AVG(CASE WHEN year(`date`) = 2022 THEN `AQI` ELSE NULL END)) as `2021`
FROM aqi
GROUP BY `Hour`
ORDER BY `Hour`;

with cte as(SELECT  date , AVG(`AQI`) as Avg_daily FROM aqi
GROUP BY `date`)
SELECT YEAR (`date`),MONTHNAME(date),
  COUNT(CASE WHEN Avg_daily < 150 THEN Avg_daily else null end) as `Good Days`,
  COUNT(CASE WHEN Avg_daily >= 150 THEN Avg_daily else null end) as `Bad Days`
FROM cte
GROUP BY YEAR(`date`), MONTH(date)
ORDER BY YEAR(`date`), MONTH(date) ASC;

SELECT * FROM aqi
ORDER BY `date` DESC;

SELECT  date , AVG(`AQI`) as Avg_daily FROM aqi
GROUP BY `date`
ORDER BY `date`;


