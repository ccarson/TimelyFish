
-- ===========================================================================
-- Author:		<Brian Cesafsky>
-- Create date: <05/20/2008>
-- Description:	<Selects Packer SortLoss record(s) by Packer contract dates>
-- ===========================================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_SORT_LOSS_SELECT_BY_CONTRACT_DATES]
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

	Select packerSortLoss.SortLossID,
			  packerSortLoss.ContactID, 
			  packerSortLoss.FromEffectDate,
			  packerSortLoss.ToEffectDate,
			  pigWeight.PigWeightID,
			  pigWeight.LowWeight,
			  pigWeight.HighWeight,
			  packerSortLoss.SortLoss,
			  packerSortLoss.SortLossType
	from dbo.cft_PACKER_SORT_LOSS packerSortLoss
	inner join dbo.cft_PIG_WEIGHT pigWeight
			 ON pigweight.PigWeightID = packerSortLoss.PigWeightID
	Where packerSortLoss.ContactID = @ContactID
	AND packerSortLoss.FromEffectDate BETWEEN @ContractFromDate AND @ContractToDate 
	Order By pigWeight.LowWeight, packerSortLoss.ToEffectDate desc
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_SORT_LOSS_SELECT_BY_CONTRACT_DATES] TO [db_sp_exec]
    AS [dbo];

