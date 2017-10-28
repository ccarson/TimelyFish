
CREATE PROCEDURE XDDAccount_CuryID
	@Account	varchar( 10 )

AS

	Declare @PmtCuryID 	varchar( 4 )

	SELECT	@PmtCuryID = BaseCuryID 
	FROM	GLSetup (nolock)
	
	if exists(Select * from CMSetup (nolock))
		SELECT	@PmtCuryID = CuryID 
		FROM	Account (nolock)
		WHERE	Acct = @Account

	SELECT @PmtCuryID
