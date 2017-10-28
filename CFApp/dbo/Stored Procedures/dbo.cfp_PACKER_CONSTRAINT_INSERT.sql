/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-26  Doran Dahle Added QtyDayMinSn, QtyDayMaxSn
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_PACKER_CONSTRAINT_INSERT] 
(
	@ContactID						int,
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
	@WtWeekAvg						int,
	@CreatedBy					    varchar(50)
)
AS
BEGIN
	INSERT INTO dbo.cft_PACKER_CONSTRAINT
	(
		[ContactID],
		[QtyDayMinMo],
		[QtyDayMaxMo],
		[QtyDayMinTu],
		[QtyDayMaxTu],
		[QtyDayMinWe],
		[QtyDayMaxWe],
		[QtyDayMinTh],
		[QtyDayMaxTh],
		[QtyDayMinFr],
		[QtyDayMaxFr],
		[QtyDayMinSa],
		[QtyDayMaxSa],
		[QtyWeekMin],
		[QtyWeekMax],
		[QtyLoadMin],
		[QtyLoadMax],
		[WtWeekAvg],
		[CreatedBy],
		[QtyDayMinSn],
		[QtyDayMaxSn]
	)
	VALUES 
	(	
		@ContactID,
		@QtyDayMinMo,
		@QtyDayMaxMo,
		@QtyDayMinTu,
		@QtyDayMaxTu,
		@QtyDayMinWe,
		@QtyDayMaxWe,
		@QtyDayMinTh,
		@QtyDayMaxTh,
		@QtyDayMinFr,
		@QtyDayMaxFr,
		@QtyDayMinSa,
		@QtyDayMaxSa,
		@QtyWeekMin,
		@QtyWeekMax,
		@QtyLoadMin,
		@QtyLoadMax,
		@WtWeekAvg,
		@CreatedBy,
		@QtyDayMinSn,
		@QtyDayMaxSn
	)
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_CONSTRAINT_INSERT] TO [db_sp_exec]
    AS [dbo];

