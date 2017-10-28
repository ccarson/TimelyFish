 CREATE PROCEDURE WOGLTran_Update_Batch
	@Module		varchar( 2 ),
   	@BatNbr		varchar( 10 ),
	@DeleteFlag	smallint

AS

	Declare
	@CrTot 		Float,
	@DrTot		Float,
	@CuryCrTot	Float,
	@CuryDrTot	Float,
	@BaseCury	SmallInt
		-- Delete the Batch
	if @DeleteFlag = 1
		DELETE 	From Batch
		WHERE	Module = @Module
			and BatNbr = @BatNbr
	else

	-- Update the Batch totals from its gltran
	BEGIN
		-- Get the base currency precision
		SELECT	@BaseCury = c.DecPl
		FROM	GLSetup s (NOLOCK),
			Currncy c (NOLOCK)
		WHERE	s.BaseCuryID = c.CuryID

		-- Sum gltran values
		SELECT 	@CrTot = 	Coalesce( Sum( Round(CrAmt, @BaseCury) ), 0),
			@DrTot = 	Coalesce( Sum( Round(DrAmt, @BaseCury) ), 0),
			@CuryCrTot = 	Coalesce( Sum( Round(CuryCrAmt, @BaseCury) ), 0),
			@CuryDrTot = 	Coalesce( Sum( Round(CuryDrAmt, @BaseCury) ), 0)
		FROM 	GLTran
		WHERE	Module = @Module
			and BatNbr = @BatNbr

		UPDATE 	Batch
		SET 	CrTot = Round ( @CrTot, @BaseCury ),
			CtrlTot = Round ( @CrTot, @BaseCury ),
			CuryCrTot = Round ( @CuryCrTot, @BaseCury ),
			CuryCtrlTot = Round ( @CuryCrTot, @BaseCury ),
			CuryDrTot = Round ( @CuryDrTot, @BaseCury ),
			DrTot = Round ( @DrTot, @BaseCury )
		WHERE	Module = @Module
			and BatNbr = @BatNbr
	END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOGLTran_Update_Batch] TO [MSDSL]
    AS [dbo];

