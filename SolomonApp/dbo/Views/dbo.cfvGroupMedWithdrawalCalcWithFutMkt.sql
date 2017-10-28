
CREATE  VIEW cfvGroupMedWithdrawalCalcWithFutMkt
AS
SELECT v.*, 
	NextFutureMarketDate = (Select Min(movementdate) from cftPM WHERE SourcePigGroupID = v.PigGroupID AND MovementDate >= GetDate()
						AND MarketSaleTypeID Not In('55','60','70')
						AND DestPigGroupID = '')
	FROM cfvGroupMedWithdrawalCalc v 					

