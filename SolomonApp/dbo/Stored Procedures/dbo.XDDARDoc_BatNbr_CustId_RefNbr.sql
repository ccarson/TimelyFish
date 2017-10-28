

CREATE PROCEDURE XDDARDoc_BatNbr_CustId_RefNbr
	@BatNbr			varchar(10),
	@CustID			varchar(15),
	@RefNbr			varchar(10),
	@Doctype		varchar(2)
AS	
	SELECT		* 
	FROM		ARDoc (nolock)
	WHERE		BatNbr = @BatNbr
		        and CustId = @CustID
		        and RefNbr = @RefNbr
		        and DocType = @DocType


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARDoc_BatNbr_CustId_RefNbr] TO [MSDSL]
    AS [dbo];

