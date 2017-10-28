-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <10/17/2007>
-- Description:	<Updates a Cutout record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_CUTOUT_UPDATE]
(
	@CutoutID						int,
	@EffectiveDate					smalldatetime,
	@LoadValue						decimal(10, 4),
	@CutValue						decimal(10, 4),
	@TrimValue						decimal(10, 4),
	@CarcassValue					decimal(10, 4),
	@LoinValue						decimal(10, 4),
	@ButtValue						decimal(10, 4),
	@PicValue						decimal(10, 4),
	@RibValue						decimal(10, 4),
	@HamValue						decimal(10, 4),
	@BellyValue						decimal(10, 4),
	@UpdatedBy					    varchar(50)
)
AS
BEGIN
	UPDATE dbo.cft_CUTOUT
	SET 
		EffectiveDate = @EffectiveDate,
		LoadValue = @LoadValue,
		CutValue = @CutValue,
		TrimValue = @TrimValue,
		CarcassValue = @CarcassValue,
		LoinValue = @LoinValue,
		ButtValue = @ButtValue,
		PicValue = @PicValue,
		RibValue = @RibValue,
		HamValue = @HamValue,
		BellyValue = @BellyValue,
		UpdatedBy = @UpdatedBy,
		UpdatedDateTime = getdate()
	WHERE CutoutID = @CutoutID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CUTOUT_UPDATE] TO [db_sp_exec]
    AS [dbo];

