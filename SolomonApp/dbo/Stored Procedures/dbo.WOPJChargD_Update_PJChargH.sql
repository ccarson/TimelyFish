 CREATE PROCEDURE WOPJChargD_Update_PJChargH
	@Batch_ID	varchar( 10 ),
	@DeleteFlag	smallint

AS

	Declare
	@Last_Detail_Num 		SmallInt,
	@Batch_Amount			Float,
	@Cury_Batch_Amount		Float,
	@BaseCury				SmallInt,
	@TranCury				SmallInt
		-- Delete the Batch
	if @DeleteFlag = 1
		DELETE 	From PJChargH
		WHERE	Batch_ID = @Batch_ID
	else

	-- Update the PJChargH totals from its PJChargD
	BEGIN
		-- Get the base currency precision
		SELECT	@BaseCury = c.DecPl
		FROM	GLSetup s (NOLOCK),
				Currncy c (NOLOCK)
		WHERE	s.BaseCuryId = c.CuryId
		
		-- Get the batch transaction currency precision
		SELECT	@TranCury = c.DecPl
		FROM 	PJChargH h (NOLOCK),
				Currncy c (NOLOCK)
		WHERE	h.batch_id = @Batch_ID
		and     c.CuryId = h.CuryId

		-- Sum PJChargD values
		SELECT 	@Batch_Amount		  = 	Coalesce( Sum( Round(amount, @BaseCury) ), 0),
				@Cury_Batch_Amount	  = 	Coalesce( Sum( Round(CuryTranAmt, @TranCury) ), 0),
				@Last_Detail_Num	  = 	Coalesce( Max( detail_num ), 0)
		FROM 	PJChargD
		WHERE	batch_id = @Batch_ID

		UPDATE 	PJChargH
		SET 	batch_amount = Round( @Batch_Amount, @BaseCury ),
				batch_bal = Round( @Batch_Amount, @BaseCury ),
				Cury_batch_amount = Round( @Cury_Batch_Amount, @TranCury ),
				Cury_batch_bal = Round( @Cury_Batch_Amount, @TranCury ),
				last_detail_num = @Last_Detail_Num
		WHERE	batch_id = @Batch_ID
	END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJChargD_Update_PJChargH] TO [MSDSL]
    AS [dbo];

