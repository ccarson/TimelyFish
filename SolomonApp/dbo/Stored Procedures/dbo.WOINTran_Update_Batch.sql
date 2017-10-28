 CREATE PROCEDURE WOINTran_Update_Batch
	@Module		varchar( 2 ),
   	@BatNbr		varchar( 10 ),
	@DeleteFlag	smallint

AS

	Declare
	@CtrlTot 		Float,
	@DrTot			Float,
	@DecPlQty		SmallInt,
	@BaseCury		SmallInt

	-- Delete the Batch
	if @DeleteFlag = 1
		DELETE 	From Batch
		WHERE	Module = @Module
			and BatNbr = @BatNbr
	else

	-- Update the Batch totals from its INTran
	BEGIN
		-- Get the base currency precision
		SELECT	@BaseCury = c.DecPl
		FROM	GLSetup s (NOLOCK),
			Currncy c (NOLOCK)
		WHERE	s.BaseCuryID = c.CuryID

		SELECT	@DecPlQty = DecPlQty
		FROM	INSetup (nolock)

		-- Sum INTran values
		SELECT 	@CtrlTot = 	Coalesce( Sum( Round(TranAmt, @BaseCury) ), 0),
			@DrTot = 	Coalesce( Sum( Round(Qty, @DecPlQty) ), 0)
		FROM 	INTran
		WHERE	BatNbr = @BatNbr

		UPDATE 	Batch
		SET 	CtrlTot = Round ( @CtrlTot, @BaseCury ),
			CrTot = Round ( @CtrlTot, @BaseCury ),
			DrTot = Round ( @DrTot, @DecPlQty )
		WHERE	Module = @Module
			and BatNbr = @BatNbr
	END


