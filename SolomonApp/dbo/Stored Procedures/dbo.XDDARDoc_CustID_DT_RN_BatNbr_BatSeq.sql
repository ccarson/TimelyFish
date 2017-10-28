
CREATE PROCEDURE XDDARDoc_CustID_DT_RN_BatNbr_BatSeq
	@CustID		varchar(15),
	@DocType	varchar(2),
	@RefNbr		varchar(10),
	@BatNbr		varchar(10),
	@BatSeq		int
AS
	SELECT		*
	FROM		ARDoc (nolock)
	WHERE		CustID = @CustID
			and DocType = @DocType
			and RefNbr = @RefNbr
			and BatNbr = @BatNbr
			and BatSeq = @BatSeq

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARDoc_CustID_DT_RN_BatNbr_BatSeq] TO [MSDSL]
    AS [dbo];

