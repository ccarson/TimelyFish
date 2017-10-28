
CREATE PROCEDURE XDDBatch_PmtTotal
  	@Module		varchar( 2 ),
  	@BatNbr		varchar( 10 )

AS

	declare	@BatTotal	float
	declare	@BaseCuryPrec	float

	-- Get the base currency precision
	SELECT	@BaseCuryPrec = c.DecPl
	FROM	GLSetup s (nolock),
		Currncy c (nolock)
	WHERE	s.BaseCuryID = c.CuryID

	SET @BatTotal = 0

	if @Module = 'AP'
		SELECT @BatTotal = Sum(round(CuryOrigDocAmt, @BaseCuryPrec)) 
		FROM 	APDoc (nolock) 
		WHERE 	BatNbr = @BatNbr 
			and DocType IN ('CK', 'HC', 'EP') 
			and Status <> 'V'
--	else
--		AR goes here

	SELECT @BatTotal
