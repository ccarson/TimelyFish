
CREATE PROCEDURE XDDCurrency_CuryID_Class
	@CuryID		varchar(4)
AS
	SELECT		DecPl,
			Descr
	FROM		Currncy (nolock)
	WHERE		CuryID = @CuryID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDCurrency_CuryID_Class] TO [MSDSL]
    AS [dbo];

