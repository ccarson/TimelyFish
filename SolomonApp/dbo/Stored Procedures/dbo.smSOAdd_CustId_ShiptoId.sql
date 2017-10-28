 CREATE PROCEDURE smSOAdd_CustId_ShiptoId
	@parm1 varchar(15)
	,@parm2 varchar(10)
AS
--Customer ID Uses a "LIKE" comparison operator because it may contain a % in SD30300 Service Call Lookup
--This SQL cannot be dynamically generated because it is used in a PV in SD30300 and the PVREC wouldn't match
SELECT *
FROM SOAddress
	join smSOAddress
		on SOAddress.Custid = smSOAddress.Custid
		and SOAddress.ShiptoId = smSOAddress.ShiptoId
WHERE SOAddress.Custid LIKE @parm1
	AND SOAddress.ShiptoId LIKE @parm2
ORDER BY SOAddress.Custid
	,SOAddress.Shiptoid


