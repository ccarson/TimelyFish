 CREATE PROCEDURE WOLotSerT_All
	@WONbr			  varchar( 16 ),
	@TaskID			  varchar( 32 ),
   @TranSDType      varchar( 2 ),
	@TranLineRef     varchar( 5 ),
	@TranType        varchar( 5 ),
	@PJTK_Key        varchar( 24 ),
	@LotSerNbr       varchar( 25 )

AS
	SELECT           *
	FROM             WOLotSerT
	WHERE            WONbr LIKE @WONbr and
	                 TaskID LIKE @TaskID and
	                 TranSDType LIKE @TranSDType and
	                 TranLineRef LIKE @TranLineRef and
	                 TranType LIKE @TranType and
	                 PJTK_Key LIKE @PJTK_Key and
	                 LotSerNbr LIKE @LotSerNbr
	ORDER BY         WONbr,
	                 TaskID,
	                 TranSDType,
                    TranLineRef,
                    TranType,
                    PJTK_Key,
                    LotSerNbr


