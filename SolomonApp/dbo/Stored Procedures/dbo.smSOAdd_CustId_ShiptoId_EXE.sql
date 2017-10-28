 CREATE PROCEDURE smSOAdd_CustId_ShiptoId_EXE
	@parm1 varchar(15)
	,@parm2 varchar(10)
AS
SELECT *
FROM SOAddress
	join smSOAddress
		on SOAddress.Custid = smSOAddress.Custid
		and SOAddress.ShiptoId = smSOAddress.ShiptoId
WHERE SOAddress.Custid = @parm1
	AND SOAddress.ShiptoId LIKE @parm2
ORDER BY SOAddress.Custid
	,SOAddress.Shiptoid


