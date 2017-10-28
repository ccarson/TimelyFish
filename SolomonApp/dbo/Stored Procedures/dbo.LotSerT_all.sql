 CREATE PROCEDURE LotSerT_all
	@cpnyid			varchar( 10 ),
	@batnbr			varchar( 10 ),
	@refnbr			varchar( 15 ),
	@intranlineref		varchar( 5 ),
	@lotserref			varchar( 5 )
AS
	SELECT *
	FROM LotSerT
	WHERE CpnyID = @cpnyid
	   AND BatNbr = @batnbr
	   AND RefNbr LIKE @refnbr
	   AND INTranLineRef LIKE @intranlineref
	   AND LotSerRef LIKE @lotserref
	ORDER BY CpnyID,
	   BatNbr,
	   RefNbr,
	   INTranLineRef,
	   LotSerRef


