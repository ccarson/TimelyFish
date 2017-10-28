 CREATE PROCEDURE WOLotSerT_CpnyID_BatNbr
	@CpnyID          varchar( 10 ),
	@BatNbr          varchar( 10 ),
	@TranSDType      varchar( 2 ),
	@TranLineRef     varchar( 5 ),
	@TranType        varchar( 5 ),
   @PJTK_Key        varchar( 24 ),
	@LineRef         varchar( 5 )

AS
	SELECT           *
	FROM             WOLotSerT
	WHERE            CpnyID LIKE @CpnyID and
	                 BatNbr LIKE @BatNbr and
	                 TranSDType LIKE @TranSDType and
	                 TranLineRef LIKE @TranLineRef and
	                 TranType LIKE @TranType and
	                 PJTK_Key LIKE @PJTK_Key and
	                 LineRef LIKE @LineRef
	ORDER BY         CpnyID, BatNbr, TranSDType, TranLIneRef, TranType, PJTK_Key, LineRef


