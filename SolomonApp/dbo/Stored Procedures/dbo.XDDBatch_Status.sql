
CREATE PROCEDURE XDDBatch_Status
	@BatNbr		varchar(10)
AS
	SELECT		*
	FROM		Batch (nolock)
	WHERE		Module = 'AR'
			and BatNbr = @BatNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatch_Status] TO [MSDSL]
    AS [dbo];

