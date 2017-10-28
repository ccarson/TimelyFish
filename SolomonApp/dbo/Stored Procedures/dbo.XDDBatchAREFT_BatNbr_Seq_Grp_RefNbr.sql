
CREATE PROCEDURE XDDBatchAREFT_BatNbr_Seq_Grp_RefNbr
	@BatNbr		varchar( 10 ),
	@BatSeq		smallint,
	@BatEFTGrp	smallint,
	@CustID		varchar( 15 ),
	@DocType	varchar( 2 ),
	@RefNbr		varchar( 10 )
AS

	SELECT		*
	FROM		XDDBatchAREFT
	WHERE		BatNbr = @BatNbr
			and BatSeq = @BatSeq
			and BatEFTGrp = @BatEFTGrp
			and CustID = @CustID
			and Doctype = @DocType
			and RefNbr = @RefNbr
