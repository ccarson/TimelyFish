 CREATE PROCEDURE Return_LotSerMst_LotSerNbr_LIFODate
	@parm1 varchar ( 30),
	@parm2 varchar (10),
	@parm3 varchar (10)
AS
    	SELECT * FROM VP_Return_AvailSerNbr
	WHERE InvtId = @parm1
              AND SiteId = @parm2
              AND WhseLoc = @parm3
              ORDER BY InvtId, LIFOdate desc, LotSerNbr desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Return_LotSerMst_LotSerNbr_LIFODate] TO [MSDSL]
    AS [dbo];

