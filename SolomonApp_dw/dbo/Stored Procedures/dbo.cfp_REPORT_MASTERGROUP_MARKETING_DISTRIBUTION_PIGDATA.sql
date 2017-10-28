
-- =============================================
-- Author:		Matt Brandt
-- Create date: 01/06/2011
-- Description:	This procedure makes the Pig Data dataset for the Mastergroup Marketing Distribution report.
-- =============================================

CREATE PROCEDURE dbo.cfp_REPORT_MASTERGROUP_MARKETING_DISTRIBUTION_PIGDATA 
	@PigGroupID Char(6) 
AS
BEGIN

If Exists (Select * From tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb..#Results'))
Begin
Drop table #Results
End

Declare @Mastergroup Table (ID Int Identity(1,1), PigGroupID Char(10))
Insert Into @Mastergroup
Select PigGroupID From [$(SolomonApp)].dbo.cftPigGroup Where CF03 = (Select CF03 From [$(SolomonApp)].dbo.cftPigGroup Where PigGroupID = @PigGroupID)

Declare @Counter Int
Declare @EndCount Int
Set @Counter = 1
Select @EndCount = Max(ID) From @Mastergroup

Create Table #Results 
(PigGroupID char(6)
, Barn char(6)
, Category char(20)
, CategoryRank Int
, AdjustedWeight Float
, Headcount Int
, AvgWeightToPacker Float
, CV Float)

While @Counter <= @EndCount

	Begin
	
	Select @PigGroupID = m.PigGroupID From @Mastergroup m Where m.ID = @Counter 
	
	Insert Into #Results
	Exec  dbo.cfp_DATA_MARKETING_DISTRIBUTION_PIGGROUP @PigGroupID
	
	Set @Counter = @Counter+1
	
	End
	
Select * From #Results

Drop Table #Results

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MASTERGROUP_MARKETING_DISTRIBUTION_PIGDATA] TO [db_sp_exec]
    AS [dbo];

