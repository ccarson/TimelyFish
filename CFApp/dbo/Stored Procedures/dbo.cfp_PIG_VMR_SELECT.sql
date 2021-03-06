﻿-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/20/2007>
-- Description:	<Selects VMR record(s)>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PIG_VMR_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select [VmrId],
			[EffectiveDate],
			[AverageValue],
			[OverageValue],
			[BackFatPointSeven_LoinDepthFourLow],
			[BackFatPointEight_LoinDepthFourLow],
			[BackFatPointNine_LoinDepthFourLow],
			[BackFatOne_LoinDepthFourLow],
			[BackFatOnePointOne_LoinDepthFourLow],
			[BackFatPointNine_LoinDepthFiveLow],
			[BackFatOne_LoinDepthFiveLow],
			[BackFatOnePointOne_LoinDepthFiveLow],
			[BackFatOnePointTwo_LoinDepthFiveLow],
			[BackFatOnePointOne_LoinDepthSixLow],
			[BackFatOnePointTwo_LoinDepthSixLow],
			[BackFatOnePointFour_LoinDepthSixLow],
			[BackFatOnePointFour_LoinDepthSevenLow],
			[BackFatPointSeven_LoinDepthFourHigh],
			[BackFatPointEight_LoinDepthFourHigh],
			[BackFatPointNine_LoinDepthFourHigh],
			[BackFatOne_LoinDepthFourHigh],
			[BackFatOnePointOne_LoinDepthFourHigh],
			[BackFatPointNine_LoinDepthFiveHigh],
			[BackFatOne_LoinDepthFiveHigh],
			[BackFatOnePointOne_LoinDepthFiveHigh],
			[BackFatOnePointTwo_LoinDepthFiveHigh],
			[BackFatOnePointOne_LoinDepthSixHigh],
			[BackFatOnePointTwo_LoinDepthSixHigh],
			[BackFatOnePointFour_LoinDepthSixHigh],
			[BackFatOnePointFour_LoinDepthSevenHigh]
	from dbo.cft_PIG_VMR (NOLOCK)
	Order By EffectiveDate desc
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_VMR_SELECT] TO [db_sp_exec]
    AS [dbo];

