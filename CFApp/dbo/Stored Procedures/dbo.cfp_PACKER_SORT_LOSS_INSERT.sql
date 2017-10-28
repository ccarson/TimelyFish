
-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/07/2007>
-- Description:	<Inserts a Packer Sort Loss record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_SORT_LOSS_INSERT]
(
	@ContactID						int,
	@PigWeightID					int,
	@FromEffectDate					datetime,
	@ToEffectDate                   datetime,
	@SortLoss						decimal(10, 4),
	@SortLossType					varchar(10),
	@CreatedBy					    varchar(50)
)	
AS
BEGIN

	INSERT INTO dbo.cft_PACKER_SORT_LOSS
	(   
		[ContactID],
		[PigWeightID],
		[FromEffectDate],
		[ToEffectDate],
		[SortLoss],
		[SortLossType],
		[CreatedBy]
	)
	VALUES 
	(	
		@ContactID,
		@PigWeightID,
		@FromEffectDate,
		@ToEffectDate,
		@SortLoss,
		@SortLossType,
		@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_SORT_LOSS_INSERT] TO [db_sp_exec]
    AS [dbo];

