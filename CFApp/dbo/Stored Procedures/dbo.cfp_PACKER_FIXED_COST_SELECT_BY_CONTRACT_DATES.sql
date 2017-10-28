
-- ===========================================================================
-- Author:		<Brian Cesafsky>
-- Create date: <05/20/2008>
-- Description:	<Selects Packer Fixed Cost record(s) by Packer contract dates>
-- ===========================================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_FIXED_COST_SELECT_BY_CONTRACT_DATES]
(
	@ContactID						int,
	@ContractFromDate               smalldatetime,
	@ContractToDate                 smalldatetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select packerFixedCost.FixedCostID,
			  packerFixedCost.ContactID, 
			  packerFixedCost.FromEffectDate,
			  packerFixedCost.ToEffectDate,
			  pigWeight.PigWeightID,
			  pigWeight.LowWeight,
			  pigWeight.HighWeight,
			  packerFixedCost.FixedCost
	from dbo.cft_PACKER_FIXED_COST packerFixedCost
	inner join dbo.cft_PIG_WEIGHT pigWeight
			 ON pigweight.PigWeightID = packerFixedCost.PigWeightID
	Where packerFixedCost.ContactID = @ContactID
	AND packerFixedCost.FromEffectDate BETWEEN @ContractFromDate AND @ContractToDate 
	Order By pigWeight.LowWeight, packerFixedCost.ToEffectDate desc
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_FIXED_COST_SELECT_BY_CONTRACT_DATES] TO [db_sp_exec]
    AS [dbo];

