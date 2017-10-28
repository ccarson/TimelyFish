-- ===============================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/06/2007>
-- Description:	<Selects Cutout record based on a date passed in>
-- ===============================================================
CREATE PROCEDURE [dbo].[cfp_CUTOUT_SELECT_BY_DATE]
(
	@EffectiveDate		smalldatetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select TOP 1 CutoutID as CutoutID,
			EffectiveDate,
			LoadValue,
			CutValue,
			TrimValue,
			CarcassValue,
			LoinValue,
			ButtValue,
			PicValue,
			RibValue,
			HamValue,
			BellyValue
	FROM	dbo.cft_CUTOUT (NOLOCK)
	WHERE	EffectiveDate <= @EffectiveDate
	ORDER BY EffectiveDate DESC
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CUTOUT_SELECT_BY_DATE] TO [db_sp_exec]
    AS [dbo];

