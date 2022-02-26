--CREATE VIEW [SD_trade_agreements_NINV] AS

SELECT 

	p.RECID,
	p.ITEMRELATION AS ITEMID,
	i.NAMEALIAS AS NAMEALIAS,
	p.ACCOUNTRELATION AS PrimaryVendorId,
	c.EXTERNALITEMID AS ExternalID,
	i.ITEMBUYERGROUPID AS Buyer,
	i.LHAPARENTSKU AS ParentSKU,
	REPLACE(REPLACE(REPLACE(i.OSSEXSTOCKFLAG,'1','Ex-stock'),'2','Ex-stock and Due In'),'0','None') AS 'Ex-stock',
	i.CITREQITEMWHSEID AS ManualCoverage,
	i.LHAMERCHDISCONID AS Discontinued,
	p.AMOUNT AS CurrentPurchasePrice,
	p.UNITID AS UNITID,
	MAX(COALESCE(NULLIF(p.FROMDATE,''), '1990-01-01 00:00:00.000')) AS FROMDATE

FROM  PriceDiscTable p

JOIN InventTable i ON p.ITEMRELATION = i.ITEMID

LEFT JOIN CustVendExternalItem c ON i.ITEMID = c.ITEMID AND i.PrimaryVendorId = c.CustVendRelation

WHERE c.MODULETYPE = '3' 

GROUP BY p.RECID, p.ITEMRELATION, i.NAMEALIAS, p.ACCOUNTRELATION, c.EXTERNALITEMID, i.ITEMBUYERGROUPID, i.LHAPARENTSKU, i.OSSEXSTOCKFLAG, i.CITREQITEMWHSEID, i.LHAMERCHDISCONID, p.AMOUNT, p.UNITID

--ORDER BY p.ITEMRELATION ASC