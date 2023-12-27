-- 1. Viewing full table
SELECT * FROM abnb;


-- 2. On which date Airbnb's Stock Sold the most volume
SELECT Date, Volume
FROM abnb
ORDER BY Volume DESC
LIMIT 5;


-- 3. On which date Airbnb's Stock opened at the highest price and closed at the lowest price
SELECT Date, Open
FROM abnb
ORDER BY Open DESC
LIMIT 5;

SELECT Date, Low
FROM abnb
ORDER BY Low
LIMIT 5;


-- 4. Number of volumes sold in specific years (ordered in descending form)
SELECT LEFT(date, 4) AS year, SUM(Volume)
FROM abnb
WHERE LEFT(date, 4) IN ('2020', '2021', '2022')
GROUP BY LEFT(date, 4)
ORDER BY SUM(Volume) DESC;


-- 5. What is the average opening, high, closing prices, and average volume?
SELECT
    ROUND(AVG(Open), 0) AS avg_open,
    ROUND(AVG(High), 0) AS avg_high,
    ROUND(AVG(Low), 0) AS avg_low,
    ROUND(AVG(Close), 0) AS avg_close,
    ROUND(AVG(Volume), 0) AS avg_volume
FROM abnb;


-- 6. Days with the highest positive and negative changes in stock prices
SELECT Date, ROUND((High - Open), 2) AS positive_change
FROM abnb
ORDER BY positive_change DESC
LIMIT 5;


-- 7. Days where there is a significant gap between the opening and the previous day's closing price
SELECT Date, Open, Close, ROUND((Open - LAG(Close) OVER (ORDER BY Date)), 2) AS PriceGap
FROM abnb
ORDER BY PriceGap DESC
LIMIT 5;


-- 8. Trends by calculating the average closing price for each month
SELECT
    EXTRACT(MONTH FROM CAST(date AS DATE)) AS Month,
    EXTRACT(YEAR FROM CAST(date AS DATE)) AS Year,
    AVG(Close)
FROM abnb
GROUP BY Month, Year
ORDER BY Month, Year;


-- 9. Day with the largest absolute percentage change in closing prices
SELECT Date, ROUND(ABS(((Open - Close) / Open) * 100), 2) AS abspercentagechange
FROM abnb
ORDER BY abspercentagechange DESC
LIMIT 5;


-- 10. Correlation between opening and closing prices
SELECT
    (COUNT(*) * SUM(Open * Close) - SUM(Open) * SUM(Close)) /
    SQRT((COUNT(*) * SUM(Open * Open) - POW(SUM(Open), 2)) * (COUNT(*) * SUM(Close * Close) - POW(SUM(Close), 2))) AS Correlation
FROM abnb;
