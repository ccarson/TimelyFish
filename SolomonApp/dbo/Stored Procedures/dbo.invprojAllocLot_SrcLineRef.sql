CREATE PROCEDURE invprojAllocLot_SrcLineRef
	@parm1 varchar( 3 ),
	@parm2 varchar( 15 ),
    @parm3 varchar ( 5 ),
    @Parm4 varchar (  25 ),
    @Parm5 varchar (   5)
AS
	SELECT *
	FROM InvProjallocLot
	WHERE SrcType = @parm1
	   AND Srcnbr = @parm2
       AND SrcLineRef = @Parm3
       And LotSerNbr = @Parm4
       And LotSerRef = @Parm5
	ORDER BY SrcType, SrcNbr, SrcLineRef, LotSerNbr, LotSerRef
