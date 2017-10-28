-- ====================================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/27/2007>
-- Description:	<Updates a Packer Market Optimizer Constraint record>
-- ====================================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-26  Doran Dahle Added QtyDayMinSn, QtyDayMaxSn
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_PACKER_MARKET_OPTIMIZER_CONSTRAINT_UPDATE] 
(
	@PackerID						int,
	@QtyDayMinSn					int,
	@QtyDayMaxSn					int,
	@QtyDayMinMo					int,
	@QtyDayMaxMo					int,
	@QtyDayMinTu					int,
	@QtyDayMaxTu					int,
	@QtyDayMinWe					int,
	@QtyDayMaxWe					int,
	@QtyDayMinTh					int,
	@QtyDayMaxTh					int,
	@QtyDayMinFr					int,
	@QtyDayMaxFr					int,
	@QtyDayMinSa					int,
	@QtyDayMaxSa					int,
	@QtyWeekMin						int,
	@QtyWeekMax						int,
	@QtyLoadMin						int,
	@QtyLoadMax						int,
	@WtWeekAvg						int
)
AS
BEGIN
	UPDATE dbo.cft_PACKER_MARKET_OPTIMIZER_CONSTRAINT
	SET 
		QtyDayMinSn = @QtyDayMinSn,
		QtyDayMaxSn = @QtyDayMaxSn,
		QtyDayMinMo = @QtyDayMinMo,
		QtyDayMaxMo = @QtyDayMaxMo,
		QtyDayMinTu = @QtyDayMinTu,
		QtyDayMaxTu = @QtyDayMaxTu,
		QtyDayMinWe = @QtyDayMinWe,
		QtyDayMaxWe = @QtyDayMaxWe,
		QtyDayMinTh = @QtyDayMinTh,
		QtyDayMaxTh = @QtyDayMaxTh,
		QtyDayMinFr = @QtyDayMinFr,
		QtyDayMaxFr = @QtyDayMaxFr,
		QtyDayMinSa = @QtyDayMinSa,
		QtyDayMaxSa = @QtyDayMaxSa,
		QtyWeekMin = @QtyWeekMin,
		QtyWeekMax = @QtyWeekMax,
		QtyLoadMin = @QtyLoadMin,
		QtyLoadMax = @QtyLoadMax,
		WtWeekAvg = @WtWeekAvg
	WHERE PackerID = @PackerID
END








GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_MARKET_OPTIMIZER_CONSTRAINT_UPDATE] TO [db_sp_exec]
    AS [dbo];

