 CREATE PROCEDURE ADG_LotSerT_Delete
		@CpnyID		varchar(10),
	@Batnbr		varchar(15),
	@RefNbr		varchar(15),
	@INTranLineRef  	varchar(5),
	@LotSerRef		varchar(5)
AS
	DELETE FROM LotSerT
	WHERE	CpnyID = @CpnyID AND
		BatNbr = @BatNbr AND
		RefNbr = @RefNbr AND
		INTranLineRef = @INTranLineRef AND
		LotSerRef = @LotSerRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LotSerT_Delete] TO [MSDSL]
    AS [dbo];

