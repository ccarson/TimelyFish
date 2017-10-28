
-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/19/2007>
-- Description:	<Selects Packer Fixed Cost record(s)>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_FIXED_COST_SELECT_BY_CONTACT]
(
	@ContactID						int,
	@EffectiveDate                  smalldatetime
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
	AND @EffectiveDate BETWEEN packerFixedCost.FromEffectDate AND packerFixedCost.ToEffectDate
	Order By pigWeight.LowWeight
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_FIXED_COST_SELECT_BY_CONTACT] TO [db_sp_exec]
    AS [dbo];

