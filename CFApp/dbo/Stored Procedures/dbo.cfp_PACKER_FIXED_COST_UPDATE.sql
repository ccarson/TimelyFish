
-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/19/2007>
-- Description:	<Updates a Packer Fixed Cost record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_FIXED_COST_UPDATE]
(
	@FixedCostID 					int,
	@ContactID 						int,
	@PigWeightID					int,
	@FromEffectDate					datetime,
	@ToEffectDate                   datetime,
	@FixedCost						decimal(10, 4),
	@UpdatedBy					    varchar(50)
)
AS
BEGIN
	UPDATE dbo.cft_PACKER_FIXED_COST
	SET	PigWeightID = @PigWeightID
		,FromEffectDate = @FromEffectDate
		,ToEffectDate = @ToEffectDate
		,FixedCost = @FixedCost
		,UpdatedBy = @UpdatedBy
		,UpdatedDateTime = GETDATE()
	WHERE FixedCostID = @FixedCostID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_FIXED_COST_UPDATE] TO [db_sp_exec]
    AS [dbo];

