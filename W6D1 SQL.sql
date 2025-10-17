#1 e 2
Select *
from dimproduct;

#3 Cambio nome delle colonne

select
 ProductKey as CodiceProdotto,
 ProductAlternateKey as Modello,
 EnglishProductName as NomeProdotto,
 Color as Colore,
 StandardCost as CostoStandard,
 FinishedGoodsFlag as ProdottoFinito
 from dimproduct
 
 # 4 Solo prodotti finiti
 
 select 
 ProductKey as CodiceProdotto,
 EnglishProductName as NomeProdotto,
 Color as Colore,
 StandardCost as CostoStandard,
 FinishedGoodsFlag as ProdottoFinito
 from dimproduct
 where FinishedGoodsFlag = 1;
 
 # 5 fr o bk e colonna calcolata markup
 
 select
  ProductAlternateKey as Modello,
 ProductKey as CodiceProdotto,
 EnglishProductName as NomeProdotto,
 StandardCost as CostoStandard,
 FinishedGoodsFlag as ProdottoFinito,
 ListPrice as PrezzoListino,
 (ListPrice - StandardCost) as Markup
  from dimproduct
 where (ProductAlternateKey like 'FR%' or ProductAlternateKey like 'BK%')
 and FinishedGoodsFlag = 1;
 
 #ELENCO DEI PRODOTTI FINITI CON PREZZO TRA 1000 E 2000
 Select
ProductAlternateKey as Modello,
 ProductKey as CodiceProdotto,
 EnglishProductName as NomeProdotto,
 StandardCost as CostoStandard,
 FinishedGoodsFlag as ProdottoFinito,
 ListPrice as PrezzoListino,
 (ListPrice - StandardCost) as Markup
  from dimproduct
 where FinishedGoodsFlag = 1
 and ListPrice between 1000 and 2000
 order by ListPrice;
 
 #TABELLA DIMEMPLOYEE
 
 SELECT *
 FROM 	dimemployedimemployeee;

#ELENCO DEGLI AGENTI

SELECT 
	EmployeeKey,
    FirstName,
    LastName,
    Title,
    DepartmentName,
    Position, # grigio perche sono anche funzione metriche
    SalesPersonFlag
FROM 
	dimemployee
WHERE SalesPersonFlag = 1;

#tabella FactResellerSales

SELECT *
FROM
	factresellersales;

SELECT
SalesOrderNumber,
SalesOrderLineNumber,
OrderDate,
ProductKey,
OrderQuantity,
SalesAmount,
TotalProductCost,
SalesAmount - TotalProductCost as 'Profitto'
FROM 
factresellersales
WHERE
ProductKey in (597, 598, 477, 214)
and
OrderDate >='2020-01-01';
 
  

 
 
 
 
 
 
 