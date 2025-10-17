# Sottocategoria di ogni prodotto
USE AdventureWorksDW;

SELECT p.ProductKey, p.EnglishProductName AS ProductName, sc. EnglishProductSubcategoryName AS Subcategory
FROM dimproduct AS p
JOIN dimproductsubcategory AS sc
ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey;

# Aggiungere la categoria e sottocategoria

SELECT p.ProductKey, p.EnglishProductName AS ProductName, sc. EnglishProductSubcategoryName AS Subcategory, c. EnglishProductCategoryName AS Category
FROM dimproduct AS p
JOIN dimproductsubcategory AS sc
ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
JOIN dimproductcategory AS c
ON sc. ProductSubcategoryKey = c. ProductCategoryKey;

# Solo i prodotti venduti

SELECT p.ProductKey, p.EnglishProductName AS ProductName
FROM factresellersales AS f
JOIN dimproduct AS p
ON f.ProductKey = p.ProductKey;

# Prodotti non vendutti ma finiti

SELECT p.ProductKey, p.EnglishProductName, p.FinishedGoodsFlag
FROM dimproduct As p
LEFT JOIN factresellersales AS f
ON f.ProductKey = p.ProductKey
WHERE p.FinishedGoodsFlag = 1
AND f.ProductKey IS NULL;

 # Elenco vendita con nome prodotto
 
 SELECT f.SalesOrderNumber, f.OrderDate, f.ProductKey, p.EnglishProductName AS ProductName, f.OrderQuantity, f.UnitPrice, f.SalesAmount
 FROM factresellersales AS f
 JOIN dimproduct AS p
 ON f.ProductKey = p.ProductKey
 ORDER BY f.OrderDate, f.SalesOrderNumber;
 
 # Transazione di vendita con la categoria
 
 
