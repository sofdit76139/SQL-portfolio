--CREATE VIEW [SD_Sales_By_Item] AS

SELECT

	--s.OSSCHANNELID AS 'Channel',
	l.ITEMID,
	i.NAMEALIAS,
	i.PRIMARYVENDORID,
	v.NAME AS 'Vendor Name',
	c.EXTERNALITEMID AS 'ExternalID',
	SUM(l.QTYORDERED) AS 'Total Qty',
	SUM(l.COSTPRICE) AS 'Total Cost',
	SUM(l.LINEAMOUNT) AS 'Total Sales',
	SUM(l.LINEAMOUNT - l.COSTPRICE) AS 'Total Profit'/*,*/
	--REPLACE(REPLACE(REPLACE(i.OSSEXSTOCKFLAG,'1','Ex-stock'),'2','Ex-stock and Due In'),'0','None') AS 'Ex-stock',
	--i.OWIPUBLISHED AS 'Published',
	--l.CREATEDDATETIME

FROM SalesTable s

LEFT JOIN SalesLine l ON s.SALESID = l.SALESID

JOIN InventTable i ON l.ITEMID = i.ITEMID

JOIN Vendor v ON i.PRIMARYVENDORID = v.ACCOUNTNUM

LEFT JOIN CustVendExternalItem c ON i.ITEMID = c.ITEMID AND i.PrimaryVendorId = c.CustVendRelation

WHERE l.CREATEDDATETIME > '2021-01-01 04:59:59'

GROUP BY /*s.OSSCHANNELID,*/ l.ITEMID, i.NAMEALIAS, i.PRIMARYVENDORID, v.NAME, c.EXTERNALITEMID--, i.OSSEXSTOCKFLAG, i.OWIPUBLISHED, l.CREATEDDATETIME