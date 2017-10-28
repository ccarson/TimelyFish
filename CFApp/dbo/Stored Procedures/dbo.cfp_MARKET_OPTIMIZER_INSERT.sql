-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/17/2007>
-- Description:	<Inserts a Market Optimzer record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_OPTIMIZER_INSERT]
(
	@LoadID					        int,
	@CalculatingOptionID			int,
	@ContactID						int,
	@EstimatedQuantity				int,
	@EstimatedWeight				int,
	@ActualQuantity					int,
	@ActualWeight					int,
	@MovementDate					smalldatetime,
	@OutByDay						int,
	@BasePrice						decimal(10, 4),
	@BaseDollarAmount				decimal(10, 4),
	@SortAmount						decimal(10, 4),
	@LeanAmount						decimal(10, 4),
	@FixedCost						decimal(10, 4),
	@TransportationCost				decimal(10, 4),
	@NetLoadAmount					decimal(10, 4),
	@CreatedBy					    varchar(50)
)	
AS
BEGIN
	INSERT INTO dbo.cft_MARKET_OPTIMIZER
	(
		[LoadID],
		[CalculatingOptionID],
		[ContactID],
		[EstimatedQuantity],
		[EstimatedWeight],
		[ActualQuantity],
		[ActualWeight],
		[MovementDate],
		[OutByDay],
		[BasePrice],
		[BaseDollarAmount],
		[SortAmount],
		[LeanAmount],
		[FixedCost],
		[TransportationCost],
		[NetLoadAmount],
		[CreatedBy]
	)
	VALUES 
	(	
		@LoadID,
		@CalculatingOptionID,
		@ContactID,
		@EstimatedQuantity,
		@EstimatedWeight,
		@ActualQuantity,
		@ActualWeight,
		@MovementDate,
		@OutByDay,
		@BasePrice,
		@BaseDollarAmount,
		@SortAmount,
		@LeanAmount,
		@FixedCost,
		@TransportationCost,
		@NetLoadAmount,
		@CreatedBy
	)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_OPTIMIZER_INSERT] TO [db_sp_exec]
    AS [dbo];

