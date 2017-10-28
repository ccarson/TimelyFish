-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/05/2007>
-- Description:	<Selects Cutout record(s)>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_CUTOUT_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select CutoutID as CutoutID,
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
	from dbo.cft_CUTOUT (nolock)
	Order By EffectiveDate desc
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CUTOUT_SELECT] TO [db_sp_exec]
    AS [dbo];

