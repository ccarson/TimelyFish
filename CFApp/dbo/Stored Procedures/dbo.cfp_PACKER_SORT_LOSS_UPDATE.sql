
-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/07/2007>
-- Description:	<Updates a Packer Sort Loss record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_SORT_LOSS_UPDATE]
(
	@SortLossID 					int,
	@ContactID 						int,
	@PigWeightID					int,
	@FromEffectDate					datetime,
	@ToEffectDate                   datetime,
	@SortLoss						decimal(10, 4),
	@SortLossType					varchar(10),
	@UpdatedBy					    varchar(50)
)
AS
BEGIN
	UPDATE dbo.cft_PACKER_SORT_LOSS
	SET	PigWeightID = @PigWeightID
		,FromEffectDate = @FromEffectDate
		,ToEffectDate = @ToEffectDate
		,SortLoss = @SortLoss
		,SortLossType = @SortLossType
		,UpdatedBy = @UpdatedBy
		,UpdatedDateTime = GETDATE()
	WHERE SortLossID = @SortLossID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_SORT_LOSS_UPDATE] TO [db_sp_exec]
    AS [dbo];

