 CREATE PROC LotSerNbr_Return_PV
	@parm1 varchar ( 30),
	@parm2 varchar (10),
	@parm3 varchar (10),
	@parm4 varchar (25)
AS
SELECT *  FROM LotSerMst
           WHERE InvtID = @parm1
           AND SiteId = @parm2
           AND WhseLoc = @parm3
	   AND lotsernbr like @Parm4
           AND QtyonHand = 0
           AND Status = 'A'
           ORDER BY InvtId, SiteID, WhseLoc, LotSerNbr


