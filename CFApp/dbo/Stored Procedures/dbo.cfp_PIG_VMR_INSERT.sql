-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/26/2007>
-- Description:	<Inserts a Pig VMR record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PIG_VMR_INSERT]
(
	@EffectiveDate								smalldatetime,
	@AverageValue								decimal(10, 4),
	@OverageValue								decimal(10, 4),
	@BackFatPointSeven_LoinDepthFourLow			decimal(10, 4),
	@BackFatPointEight_LoinDepthFourLow			decimal(10, 4),
	@BackFatPointNine_LoinDepthFourLow			decimal(10, 4),
	@BackFatOne_LoinDepthFourLow				decimal(10, 4),
	@BackFatOnePointOne_LoinDepthFourLow		decimal(10, 4),
	@BackFatPointNine_LoinDepthFiveLow			decimal(10, 4),
	@BackFatOne_LoinDepthFiveLow				decimal(10, 4),
	@BackFatOnePointOne_LoinDepthFiveLow		decimal(10, 4),
	@BackFatOnePointTwo_LoinDepthFiveLow		decimal(10, 4),
	@BackFatOnePointOne_LoinDepthSixLow			decimal(10, 4),
	@BackFatOnePointTwo_LoinDepthSixLow			decimal(10, 4),
	@BackFatOnePointFour_LoinDepthSixLow		decimal(10, 4),
	@BackFatOnePointFour_LoinDepthSevenLow		decimal(10, 4),
	@BackFatPointSeven_LoinDepthFourHigh		decimal(10, 4),
	@BackFatPointEight_LoinDepthFourHigh		decimal(10, 4),
	@BackFatPointNine_LoinDepthFourHigh			decimal(10, 4),
	@BackFatOne_LoinDepthFourHigh				decimal(10, 4),
	@BackFatOnePointOne_LoinDepthFourHigh		decimal(10, 4),
	@BackFatPointNine_LoinDepthFiveHigh			decimal(10, 4),
	@BackFatOne_LoinDepthFiveHigh				decimal(10, 4),
	@BackFatOnePointOne_LoinDepthFiveHigh		decimal(10, 4),
	@BackFatOnePointTwo_LoinDepthFiveHigh		decimal(10, 4),
	@BackFatOnePointOne_LoinDepthSixHigh		decimal(10, 4),
	@BackFatOnePointTwo_LoinDepthSixHigh		decimal(10, 4),
	@BackFatOnePointFour_LoinDepthSixHigh		decimal(10, 4),
	@BackFatOnePointFour_LoinDepthSevenHigh		decimal(10, 4),
	@CreatedBy									varchar(50)
)	
AS
BEGIN
	INSERT INTO dbo.cft_PIG_VMR
	(   
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
		[BackFatOnePointFour_LoinDepthSevenHigh],
		[CreatedBy]
	)
	VALUES 
	(	
		@EffectiveDate,
		@AverageValue,
		@OverageValue,
		@BackFatPointSeven_LoinDepthFourLow,
		@BackFatPointEight_LoinDepthFourLow,
		@BackFatPointNine_LoinDepthFourLow,
		@BackFatOne_LoinDepthFourLow,
		@BackFatOnePointOne_LoinDepthFourLow,
		@BackFatPointNine_LoinDepthFiveLow,
		@BackFatOne_LoinDepthFiveLow,
		@BackFatOnePointOne_LoinDepthFiveLow,
		@BackFatOnePointTwo_LoinDepthFiveLow,
		@BackFatOnePointOne_LoinDepthSixLow,
		@BackFatOnePointTwo_LoinDepthSixLow,
		@BackFatOnePointFour_LoinDepthSixLow,
		@BackFatOnePointFour_LoinDepthSevenLow,
		@BackFatPointSeven_LoinDepthFourHigh,
		@BackFatPointEight_LoinDepthFourHigh,
		@BackFatPointNine_LoinDepthFourHigh,
		@BackFatOne_LoinDepthFourHigh,
		@BackFatOnePointOne_LoinDepthFourHigh,
		@BackFatPointNine_LoinDepthFiveHigh,
		@BackFatOne_LoinDepthFiveHigh,
		@BackFatOnePointOne_LoinDepthFiveHigh,
		@BackFatOnePointTwo_LoinDepthFiveHigh,
		@BackFatOnePointOne_LoinDepthSixHigh,
		@BackFatOnePointTwo_LoinDepthSixHigh,
		@BackFatOnePointFour_LoinDepthSixHigh,
		@BackFatOnePointFour_LoinDepthSevenHigh,
		@CreatedBy
	)
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_VMR_INSERT] TO [db_sp_exec]
    AS [dbo];

