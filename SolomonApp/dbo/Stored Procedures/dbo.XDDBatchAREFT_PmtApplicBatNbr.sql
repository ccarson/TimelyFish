
CREATE PROCEDURE XDDBatchAREFT_PmtApplicBatNbr
	@BatNbr		varchar(10),
	@BatEFTGrp 	smallint
AS

	SELECT		*
	FROM		XDDBatchAREFT (nolock)
	WHERE		BatNbr = @BatNbr
			and BatEFTGrp = @BatEFTGrp
			and PmtApplicBatNbr <> ''
