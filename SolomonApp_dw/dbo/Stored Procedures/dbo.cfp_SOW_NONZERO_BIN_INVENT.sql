

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 6/9/2011
-- Description:	Returns Sow Feed Bin Inventories not equal to Zero
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_NONZERO_BIN_INVENT]
(
	
	 @StartDate			datetime
	,@EndDate			datetime
   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @SBR Table
	(ContactName	VarChar(50)
	,BinNbr			VarChar(50)
	,Tons			Int)
	
	Insert Into @SBR

	Select 
	cftContact.ContactName,
	cftBin.BinNbr,
	Min(cftBinReading.Tons) as Tons

	From [$(SolomonApp)].dbo.cftBin cftBin

	left join [$(SolomonApp)].dbo.cftBarn cftBarn
	on cftBin.ContactID = cftBarn.ContactID
	and cftBin.BarnNbr = cftBarn.BarnNbr

	left join [$(SolomonApp)].dbo.cftSite cftSite
	on cftBin.ContactID = cftSite.ContactID 

	left join [$(SolomonApp)].dbo.cftContact cftContact
	on cftSite.ContactID = cftContact.ContactID 

	left join [$(SolomonApp)].dbo.cftBinReading cftBinReading
	on cftBin.ContactID = cftBinReading.SiteContactID
	and cftBin.BinNbr = cftBinReading.BinNbr

	Where cftBarn.StatusTypeID = 1
	and cftContact.StatusTypeID = 1
	and cftSite.FacilityTypeID = 001
	and cftBinReading.BinReadingDate between @StartDate and @EndDate
	
	Group by
	cftContact.ContactName,
	cftContact.ContactID, 
	cftSite.SiteID,
	cftBin.BinNbr

	Create Table #Int 
	(RowNumber	int IDENTITY (1, 1),
	ContactName	VarChar(50),
	BinNbr		VarChar(50))
	
	Insert #Int (ContactName, BinNbr)
	Select 
	ContactName,
	BinNbr
	From @SBR
	Where Tons <> 0
	Order by
	ContactName,
	BinNbr
	
	Select 
	RowNumber,
	rtrim(ContactName) as SowFarm,
	rtrim(BinNbr) as BinNbr
	from #Int
	Order by 
	RowNumber
	
	--Select 
	--Int.RowNumber,
	--rtrim(SBR.ContactName) as SowFarm,
	--rtrim(SBR.BinNbr) as BinNbr
	--From @SBR SBR
	--left join #Int Int 
	--on rtrim(SBR.ContactName) = Int.SowFarm 
	--and rtrim(SBR.BinNbr) = Int.BinNbr
	--Where Tons <> 0
	--Order by
	--ContactName,
	--BinNbr

Drop Table #Int

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_NONZERO_BIN_INVENT] TO [db_sp_exec]
    AS [dbo];

