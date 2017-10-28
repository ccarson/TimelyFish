-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/05/2007>
-- Description:	<Inserts a Cutoout record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_CUTOUT_INSERT]
(
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
	@CreatedBy					    varchar(50)
)	
AS
BEGIN
	INSERT INTO dbo.cft_CUTOUT
	(
		[EffectiveDate],
		[LoadValue],
		[CutValue],
		[TrimValue],
		[CarcassValue],
		[LoinValue],
		[ButtValue],
		[PicValue],
		[RibValue],
		[HamValue],
		[BellyValue],
		[CreatedBy]
	)
	VALUES 
	(	
		@EffectiveDate,
		@LoadValue,
		@CutValue,
		@TrimValue,
		@CarcassValue,
		@LoinValue,
		@ButtValue,
		@PicValue,
		@RibValue,
		@HamValue,
		@BellyValue,
		@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CUTOUT_INSERT] TO [db_sp_exec]
    AS [dbo];

