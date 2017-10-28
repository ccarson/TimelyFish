
-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/07/2007>
-- Description:	<Selects Packer SortLoss record(s)>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_SORT_LOSS_SELECT_BY_CONTACT]
(
	@ContactID						int,
	@EffectiveDate                  smalldatetime
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
	AND @EffectiveDate BETWEEN packerSortLoss.FromEffectDate AND packerSortLoss.ToEffectDate
	Order By pigWeight.LowWeight
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_SORT_LOSS_SELECT_BY_CONTACT] TO [db_sp_exec]
    AS [dbo];

