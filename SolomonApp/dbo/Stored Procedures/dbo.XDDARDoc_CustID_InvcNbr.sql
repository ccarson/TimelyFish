
CREATE PROCEDURE XDDARDoc_CustID_InvcNbr
	@CustID		varchar(15),
	@InvcNbr	varchar(10)
AS

	SELECT		* 
	FROM		ARDoc (nolock)
	WHERE		CustID = @CustID
			and RefNbr LIKE @InvcNbr
			and DocType IN ('IN', 'DM', 'FI')

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDARDoc_CustID_InvcNbr] TO [MSDSL]
    AS [dbo];

