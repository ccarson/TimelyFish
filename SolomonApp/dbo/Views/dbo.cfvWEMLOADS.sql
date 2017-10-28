CREATE VIEW cfvWEMLOADS
--*************************************************************
--	Purpose:Convert WEM Load Data to Solomon Format
--	Author: Sue Matter
--	Date:  11/7/2006
--	Usage: XF608 Delivery Report
--	Parms:
--*************************************************************

AS
SELECT  Type=CASE fo.InvtID
WHEN RTrim(mt.[Formula No]) THEN ''
ELSE 'RationVariance' END,
LoadQty=CAST([Bin Feed Amount 1] AS FLOAT), 
ContactID=Left([Farm No],6),MillIDW=Left([Feed Mill Code],6),
InvtIDW=RTrim([Formula No]),SiteID=RTrim([House No]),
LoadDate= CONVERT(datetime,[Load Date],120), LoadNo=[Load No],BinNbrW=RTrim([Pen No]),
OrdNbrW=RTrim([Ticket Comment]), fo.*, ct.ContactName
FROM MTECHLOADORDERS mt
JOIN cftFOList fo ON mt.[Ticket Comment]= fo.OrdNbr
JOIN cftContact ct ON fo.MillID=ct.ContactID
