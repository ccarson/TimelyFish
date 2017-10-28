
CREATE PROCEDURE Fetch_InvProjAllocLots
	@parm1 varchar( 15 ),
    @parm2 varchar ( 5 ),
    @Parm3 varchar ( 30 ),
    @Parm4 varchar (  16),
    @parm5 varchar ( 32 ),
    @parm6 varchar ( 10 ),
    @parm7 varchar ( 10 ),
    @parm8 varchar ( 10 )
AS
	SELECT *
	FROM InvProjallocLot
	WHERE  Srcnbr = @parm1
       AND SrcLineRef = @Parm2
       And InvtId = @Parm3
       And ProjectId = @parm4
       And TaskId = @parm5
       And WhseLoc = @parm6
       And SiteId = @parm7
       AND CpnyId  = @parm8
