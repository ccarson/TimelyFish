 CREATE PROC Return_Vp_LotSerMst_LotSerNbr
	@parm1 varchar ( 30),
	@parm2 varchar (10),
	@parm3 varchar (10),
	@parm4 varchar (25)
AS
    	SELECT * FROM VP_Return_AvailSerNbr
	WHERE InvtId = @parm1
              AND SiteId = @parm2
              AND WhseLoc = @parm3
              AND LotSerNbr = @parm4
              ORDER BY InvtId, SiteID,WhseLoc, LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Return_Vp_LotSerMst_LotSerNbr] TO [MSDSL]
    AS [dbo];

