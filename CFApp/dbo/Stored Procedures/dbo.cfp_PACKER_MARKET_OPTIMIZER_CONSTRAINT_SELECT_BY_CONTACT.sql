-- ======================================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/26/2007>
-- Description:	<Selects Packer Constraint record for the Optimizer>
-- ======================================================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2011-07-26  Doran Dahle Added QtyDayMinSn, QtyDayMaxSn
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[cfp_PACKER_MARKET_OPTIMIZER_CONSTRAINT_SELECT_BY_CONTACT]
(
	@ContactID						int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select packerConstraint.PackerID, 
			packerConstraint.QtyDayMinSn,
			packerConstraint.QtyDayMaxSn,
			packerConstraint.QtyDayMinMo,
			packerConstraint.QtyDayMaxMo,
			packerConstraint.QtyDayMinTu,
			packerConstraint.QtyDayMaxTu,
			packerConstraint.QtyDayMinWe,
			packerConstraint.QtyDayMaxWe,
			packerConstraint.QtyDayMinTh,
			packerConstraint.QtyDayMaxTh,
			packerConstraint.QtyDayMinFr,
			packerConstraint.QtyDayMaxFr,
			packerConstraint.QtyDayMinSa,
			packerConstraint.QtyDayMaxSa,
			packerConstraint.QtyWeekMin,
			packerConstraint.QtyWeekMax,
			packerConstraint.QtyLoadMin,
			packerConstraint.QtyLoadMax,
			packerConstraint.WtWeekAvg
	from dbo.cft_PACKER_MARKET_OPTIMIZER_CONSTRAINT packerConstraint (NOLOCK)
	where packerConstraint.PackerID = @ContactID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_MARKET_OPTIMIZER_CONSTRAINT_SELECT_BY_CONTACT] TO [db_sp_exec]
    AS [dbo];

