# Esercizio W7D1
# 1 - 
# Verificare se campo è una PK - unicita e niente null
USE AdventureWorksDW;

SELECT *
FROM dimproduct;

# Sapere quante righe

SELECT COUNT(*) AS tot
FROM dimproduct;
# Sapere se ci sono null

SELECT *
FROM dimproduct
WHERE ProductKey IS NULL;  # o null - ok

#sapere se ci sono doppioni

SELECT ProductKey, COUNT(*)
FROM dimproduct
GROUP BY ProductKey; # adesso filtro il gruppo

SELECT ProductKey, COUNT(*)
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(*) > 1; # tot 0 allora èe una PK

# 2 -
# Verificare se due colonne insieme sono una PK

SELECT *
FROM factresellersales;

# veriricare se esistono null

SELECT *
FROM factresellersales
WHERE SalesOrderNumber IS NULL OR SalesOrderLineNumber IS NULL;

# verificare doppione

SELECT 
	SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS Quant_volte
FROM factresellersales
GROUP BY 
	SalesOrderNumber, 
    SalesOrderLineNumber
HAVING COUNT(*) > 1;

#  3 - numero di transazioe per data

SELECT OrderDate
From factresellersales;

SELECT
	OrderDate,
    COUNT(*) AS Transazioni
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate
ORDER BY OrderDate;

# ordinar per min e max 

SELECT
	OrderDate,
    COUNT(*) AS Transazioni    # vedere i giorno con più vendite
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate
ORDER BY Transazioni DESC
	LIMIT 5;
    

SELECT
	OrderDate,
    COUNT(*) AS Transazioni    # vedere i giorno con meno vendite
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY OrderDate
ORDER BY Transazioni ASC
	LIMIT 5;
    
#4 - Calcolare fatturato, quantita totale e prezzo medio per ogni prodotto dal 01/01/2020

SELECT *
FROM factresellersales;

SELECT 
	ProductKey,
    SalesAmount,    #seleciono le colunne che mi serveno dentro la data che mi serve
	OrderQuantity,
    UnitPrice
FROM factresellersales
WHERE OrderDate >= '2020-01-01';

SELECT 
ProductKey,
	SUM(SalesAmount) AS FatturatoTotale,  #Somma e calcolo da media
	SUM(OrderQuantity) AS QuantitaTotale,
AVG(UnitPrice) AS PrezzoMedio
FROM factresellersales
WHERE OrderDate >= '2020-01-01'
GROUP BY ProductKey;

SELECT 
	p.ProductKey,
    p.EnglishProductName AS NomeProdotto,  # aggiungiamo nome prodotto
    SUM(f.SalesAmount) AS FatturatoTotale,
    SUM(f.OrderQuantity) AS QuantitaTotale,
    AVG(f.UnitPrice) AS PrezzoMedio
FROM factresellersales AS f
JOIN dimproduct AS p
ON p.ProductKey = f.ProductKey
WHERE f.OrderDate >= '2020-01-01'
GROUP BY 
	p.ProductKey,
    p.EnglishProductName
ORDER BY FatturatoTotale DESC;

# 5- Calcolare fatturato e quantita venduta per categgoria

Select *
FROM dimproductcategory;  # mi servono 3 tabelle, ossia 2 join
	
Select *
From factresellersales;

SELECT 
	c.EnglishProductCategoryName AS Categoria,
    SUM(f.SalesAmount) AS FatturatoTottale,
    SUM(f.OrderQuantity) AS QuantitaTotale
FROM factresellersales AS f
JOIN dimproduct AS p             # parto prima dall from, dopo i join, dopo filtro  e dopo selct
ON f.ProductKey = p.ProductKey
JOIN dimproductcategory AS c
ON p.ProductSubcategoryKey = c.ProductCategoryKey
WHERE f.OrderDate >= '2020-01-01'
GROUP BY c.EnglishProductCategoryName
ORDER BY FatturatoTottale;


# 6 - Fatturato totale per citta, con filtro in data e quantita fatturato

#Ho bisogno delle tabelle vendite- factresellersales, dim reseller  e delle citta - dimgeography
# scoprire relazione - ogni vendita ha un resellerKey

SELECT 
	g.City AS citta,
    SUM(f.SalesAmount) AS FatturatoTotale
FROM factresellersales AS f
JOIN dimreseller AS r
ON f.ResellerKey = r.ResellerKey
JOIN dimgeography AS g
ON r.GeographyKey = g.GeographyKey
WHERE OrderDate >= '2020-01-01'
GROUP BY citta
HAVING SUM(f.SalesAmount) > 80000
ORDER BY FatturatoTotale DESC;



