-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/26/2007>
-- Description:	<Updates a Pig VMR record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PIG_VMR_UPDATE]
(
	@VmrID										int,
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
	@UpdatedBy									varchar(50)
)	
AS
BEGIN
	UPDATE dbo.cft_PIG_VMR
	SET	[EffectiveDate] = @EffectiveDate,
		[AverageValue] = @AverageValue,
		[OverageValue] = @OverageValue,
		[BackFatPointSeven_LoinDepthFourLow] = @BackFatPointSeven_LoinDepthFourLow,
		[BackFatPointEight_LoinDepthFourLow] = @BackFatPointEight_LoinDepthFourLow,
		[BackFatPointNine_LoinDepthFourLow] = @BackFatPointNine_LoinDepthFourLow,
		[BackFatOne_LoinDepthFourLow] = @BackFatOne_LoinDepthFourLow,
		[BackFatOnePointOne_LoinDepthFourLow] = @BackFatOnePointOne_LoinDepthFourLow,
		[BackFatPointNine_LoinDepthFiveLow] = @BackFatPointNine_LoinDepthFiveLow,
		[BackFatOne_LoinDepthFiveLow] = @BackFatOne_LoinDepthFiveLow,
		[BackFatOnePointOne_LoinDepthFiveLow] = @BackFatOnePointOne_LoinDepthFiveLow,
		[BackFatOnePointTwo_LoinDepthFiveLow] = @BackFatOnePointTwo_LoinDepthFiveLow,
		[BackFatOnePointOne_LoinDepthSixLow] = @BackFatOnePointOne_LoinDepthSixLow,
		[BackFatOnePointTwo_LoinDepthSixLow] = @BackFatOnePointTwo_LoinDepthSixLow,
		[BackFatOnePointFour_LoinDepthSixLow] = @BackFatOnePointFour_LoinDepthSixLow,
		[BackFatOnePointFour_LoinDepthSevenLow] = @BackFatOnePointFour_LoinDepthSevenLow,
		[BackFatPointSeven_LoinDepthFourHigh] = @BackFatPointSeven_LoinDepthFourHigh,
		[BackFatPointEight_LoinDepthFourHigh] = @BackFatPointEight_LoinDepthFourHigh,
		[BackFatPointNine_LoinDepthFourHigh] = @BackFatPointNine_LoinDepthFourHigh,
		[BackFatOne_LoinDepthFourHigh] = @BackFatOne_LoinDepthFourHigh,
		[BackFatOnePointOne_LoinDepthFourHigh] = @BackFatOnePointOne_LoinDepthFourHigh,
		[BackFatPointNine_LoinDepthFiveHigh] = @BackFatPointNine_LoinDepthFiveHigh,
		[BackFatOne_LoinDepthFiveHigh] = @BackFatOne_LoinDepthFiveHigh,
		[BackFatOnePointOne_LoinDepthFiveHigh] = @BackFatOnePointOne_LoinDepthFiveHigh,
		[BackFatOnePointTwo_LoinDepthFiveHigh] = @BackFatOnePointTwo_LoinDepthFiveHigh,
		[BackFatOnePointOne_LoinDepthSixHigh] = @BackFatOnePointOne_LoinDepthSixHigh,
		[BackFatOnePointTwo_LoinDepthSixHigh] = @BackFatOnePointTwo_LoinDepthSixHigh,
		[BackFatOnePointFour_LoinDepthSixHigh] = @BackFatOnePointFour_LoinDepthSixHigh,
		[BackFatOnePointFour_LoinDepthSevenHigh] = @BackFatOnePointFour_LoinDepthSevenHigh,
		UpdatedBy = @UpdatedBy,
		UpdatedDateTime = getdate()
		WHERE VmrID = @VmrID
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_VMR_UPDATE] TO [db_sp_exec]
    AS [dbo];

