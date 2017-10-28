 CREATE PROCEDURE Return_LotSerMst_LotSerNbr_RcptDate
	@parm1 varchar ( 30),
	@parm2 varchar (10),
	@parm3 varchar (10)
AS
    	SELECT * FROM VP_Return_AvailSerNbr
	WHERE InvtId = @parm1
              AND SiteId = @parm2
              AND WhseLoc = @parm3
              ORDER BY InvtId, Rcptdate, LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Return_LotSerMst_LotSerNbr_RcptDate] TO [MSDSL]
    AS [dbo];

