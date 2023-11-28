-- Challenge 1
SELECT
    CASE
        WHEN Price < 300 THEN 'Low Price'
        WHEN Price >= 300 AND Price <= 600 THEN 'Medium Price'
        ELSE 'High Price'
    END AS PriceCategory,
    COUNT(*) AS ProductCount
FROM
    products
GROUP BY
    PriceCategory;

-- Challenge 2
SELECT
    p.ProductName,
    SUM(ps.QuantitySold) AS Total_Quantity_Sold
FROM
    productsales ps
JOIN
    products p ON ps.ProductID = p.ProductID
GROUP BY
    p.ProductName
ORDER BY
    Total_Quantity_Sold DESC
LIMIT 3;

-- Challenge 3
SELECT
    p.ProductName,
    SUM(CASE WHEN ps.SaleDate = CURDATE() THEN QuantitySold ELSE 0 END) AS CurrentPeriodSales,
    SUM(CASE WHEN ps.SaleDate = DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND ps.SaleDate < CURDATE() THEN QuantitySold ELSE 0 END)AS PreviousPeriodSales
FROM Products p
LEFT JOIN ProductSales ps ON p.ProductID = ps.ProductID
GROUP BY p.ProductID, p.ProductName;

-- Challenge 4
WITH ProductsWithPrevious AS (
    SELECT
        p.ProductID,
        p.ProductName,
        p.Price,
        LAG(p.Price) OVER (ORDER BY p.ProductID) AS PreviousPrice
    FROM
        products p
)

SELECT
    ProductID,
    ProductName,
    Price,
    AVG(Price - PreviousPrice) AS AvgPriceDifference
FROM
    ProductsWithPrevious
WHERE
    PreviousPrice IS NOT NULL
GROUP BY
    ProductID, ProductName, Price;

-- Another Challenge 4
SELECT 
	p1.ProductID,
    p1.ProductName,
    p1.Price,
    AVG(p1.Price - p2.Price) AS avg_different
FROM
	products p1
JOIN
	products p2 ON p1.ProductID = p2.ProductID + 1
GROUP BY
	p1.ProductID,
    p1.ProductName,
    p1.Price;
    

-- Challenge 5
SELECT
    ProductName,
    ProductCode
FROM
    products
WHERE
    Price IS NULL;
