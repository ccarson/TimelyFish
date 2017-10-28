


-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/01/2010
-- Description:	Returns # of Services and Farrows vs. Target
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_BT_FT_smr]
(
	
	 @WeekOfDate		datetime

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select
	Rtrim(BTFT.ContactName) ContactName,
	Rtrim(BTFT.Region) Region,
	BTFT.Service,
	BTFT.BT,
	RBTFT.BT as RBT,
	SBTFT.BT as SBT,
	BTFT.Farrow,
	BTFT.FT,
	RBTFT.FT as RFT,
	SBTFT.FT as SFT,
	BTFT.PicYear,
	BTFT.PicWeek
	
	from  dbo.cft_SOW_BT_FT_smrpc BTFT
	
	left join (
	Select 
	PICYear,
	PICWeek,
	Max(WeekOfDate) WeekOfDate
	from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
	Group by
	PICYear,
	PICWeek) WD
	on WD.PICYear = BTFT.PICYear
	and WD.PICWeek = BTFT.PICWeek
	
	left join (
	Select 
	BTFT.Region,
	sum(BTFT.BT) BT,
	sum(BTFT.FT) FT
	From (Select Distinct Region, ContactName, BT, FT
	From  dbo.cft_SOW_BT_FT_smrpc) BTFT
	Group by
	BTFT.Region) RBTFT
	on RBTFT.Region = BTFT.Region
	
	cross join (
	Select 
	sum(BTFT.BT) BT,
	sum(BTFT.FT) FT
	From (Select Distinct ContactName, BT, FT
	From  dbo.cft_SOW_BT_FT_smrpc) BTFT) SBTFT
	
	Where WD.WeekOfDate between @WeekOfDate-182 and @WeekOfDate
	
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_BT_FT_smr] TO [db_sp_exec]
    AS [dbo];

