-- =========================================================
-- Author:		Brian Cesafsky
-- Create date: 08/21/2008
-- Description:	Returns the standard cost
-- =========================================================
CREATE PROCEDURE [dbo].[cfp_ACCOUNTING_STANDARD_COST_SELECT]
(
	@InvtID			varchar(30)
	,@SiteID		varchar(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [StdCost]*56 AS StandardCost
			,ItemSite.InvtID
			,ItemSite.SiteID 
			,ItemSite.StdCostDate
	FROM ItemSite (NOLOCK)
	WHERE ItemSite.InvtID = @InvtID -- '01201' 
	AND ItemSite.SiteID = @SiteID -- '101'
END

