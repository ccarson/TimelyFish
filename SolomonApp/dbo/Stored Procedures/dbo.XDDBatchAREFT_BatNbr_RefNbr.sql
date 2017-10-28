
CREATE PROCEDURE XDDBatchAREFT_BatNbr_RefNbr
	@BatNbr		varchar(10),
	@RefNbr		varchar(10)
AS

	SELECT		*
	FROM		XDDBatchAREFT
	WHERE		BatNbr = @BatNbr
			and RefNbr = @RefNbr
