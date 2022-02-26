--CREATE VIEW [SD_items_online] AS

SELECT

	i.ITEMID,
	i.NAMEALIAS,
	i.PRIMARYVENDORID,
	v.NAME AS VENDORNAME,
	c.EXTERNALITEMID AS 'ExternalID',
	i.OWIPUBLISHED AS Published,
	REPLACE(REPLACE(REPLACE(i.OSSEXSTOCKFLAG,'1','Ex-stock'),'2','Ex-stock and Due In'),'0','None') AS 'Ex-stock',
	i.LHAMAPPRICE AS MAP,
	i.LHAMARKETPLACEBANNED AS MarketPlaceBanned,
	i.LHASYNCCA AS MarketPlaceSync,
	i.LHASYNCCV3 AS CV3Sync,
	i.CITREQITEMWHSEID AS 'ManualCoverage',
	i.LHAMERCHDISCONID AS 'Discontinued',
	SUM(s.AVAILPHYSICAL) AS 'InventoryAvailable'

FROM InventTable i

LEFT JOIN CustVendExternalItem c ON i.ITEMID = c.ITEMID AND i.PrimaryVendorId = c.CustVendRelation

LEFT JOIN InventSum s ON i.ITEMID = s.ITEMID

JOIN Vendor v ON i.PRIMARYVENDORID = v.ACCOUNTNUM

WHERE c.MODULETYPE = '3'

GROUP BY  i.ITEMID, i.NAMEALIAS, i.PRIMARYVENDORID, v.NAME, c.EXTERNALITEMID, i.OWIPUBLISHED, i.OSSEXSTOCKFLAG, i.LHAMAPPRICE, i.LHAMARKETPLACEBANNED, i.LHASYNCCA, i.LHASYNCCV3, i.CITREQITEMWHSEID, i.LHAMERCHDISCONID