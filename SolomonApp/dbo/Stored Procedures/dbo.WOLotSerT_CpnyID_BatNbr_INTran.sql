 CREATE PROCEDURE WOLotSerT_CpnyID_BatNbr_INTran
	@CpnyID          varchar( 10 ),
	@BatNbr          varchar( 10 ),
	@TranSDType      varchar( 2 ),
	@INTranLineRef   varchar( 5 )

AS
	SELECT           *
	FROM             WOLotSerT
	WHERE            CpnyID = @CpnyID and
	                 BatNbr = @BatNbr and
	                 TranSDType = @TranSDType and
	                 INTranLineRef = @INTranLineRef


