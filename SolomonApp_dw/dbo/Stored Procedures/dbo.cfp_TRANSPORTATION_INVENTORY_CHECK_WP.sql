

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 05/17/2011
-- Description:	Returns Sow Farm, Nursery/WTF and scheduled transport counts by PMLoadID
-- =============================================

	CREATE PROCEDURE dbo.cfp_TRANSPORTATION_INVENTORY_CHECK_WP
	(
		@StartDate			datetime,
		@EndDate			datetime
	)
	AS
	BEGIN
	SET NOCOUNT ON
	
	Declare @FarmCount Table
	(PMID			Float
	,SowFarmCount	Int
	,NurseryWPCount	Int)
	
	Insert into @FarmCount
	
	Select 
	pm.PMID,
	Sum(pm.SourceFarmQty) as SowFarmCount,
	Case when pm.RecountQty = 1 then Sum(pm.RecountQty) else Sum(pm.DestFarmQty) end as NurseryWPCount
	From [$(SolomonApp)].dbo.cftPMTranspRecord pm
	left join [$(SolomonApp)].dbo.cftPMTranspRecord re
	on pm.RefNbr = re.OrigRefNbr
	Where left(rtrim(pm.SubTypeID),1) = 'S'
	and re.RefNbr is null
	and pm.DocType <> 're'
	Group by
	pm.PMID,
	pm.RecountQty

	Delete From  dbo.cft_LOAD_TABLE_SOURCE_TRANSPORTATION_INVENTORY_CHECK_WP
	
	Insert into  dbo.cft_LOAD_TABLE_SOURCE_TRANSPORTATION_INVENTORY_CHECK_WP

	select distinct 
	pm.PMLoadID,
	SC.ContactName as SowSource
	from [$(SolomonApp)].dbo.cftPM pm
	left join [$(SolomonApp)].dbo.cftContact SC
	on pm.SourceContactID = SC.ContactID
	where pm.PigTypeID = '02'
	
	Delete From  dbo.cft_LOAD_TABLE_DESTINATION_TRANSPORTATION_INVENTORY_CHECK_WP
	
	Insert into  dbo.cft_LOAD_TABLE_DESTINATION_TRANSPORTATION_INVENTORY_CHECK_WP

	select distinct 
	pm.PMLoadID,
	DC.ContactName as DestFarm
	from [$(SolomonApp)].dbo.cftPM pm
	left join [$(SolomonApp)].dbo.cftContact DC
	on pm.DestContactID = DC.ContactID
	where pm.PigTypeID = '02'

	Select Distinct
	SS.PMLoadID,
	cftPM.MovementDate,
	SS.SowSource,
	DF.DestFarm,
	Sum(cftPM.EstimatedQty) as EstCount,
	Sum(FarmCount.SowFarmCount) as SowFarmCount,
	Sum(FarmCount.NurseryWPCount) as NurseryWPCount

	from (

	Select 
	PM.PMLoadID, 
	dbo.cffn_INVENTORY_CHECK_SOURCE(PM.PMLoadID) as SowSource
	from ( 
	Select PMLoadID
	from  dbo.cft_LOAD_TABLE_SOURCE_TRANSPORTATION_INVENTORY_CHECK_WP
	group by PMLoadID) PM ) SS
	
	left join (

	Select 
	PM.PMLoadID, 
	dbo.cffn_INVENTORY_CHECK_DESTINATION(PM.PMLoadID) as DestFarm
	from ( 
	Select PMLoadID
	from  dbo.cft_LOAD_TABLE_DESTINATION_TRANSPORTATION_INVENTORY_CHECK_WP
	group by PMLoadID) PM ) DF
	on SS.PMLoadID = DF.PMLoadID 

	left join [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
	on SS.PMLoadID = cftPM.PMLoadID 

	left join (
	Select 
	PMID, Sum(SowFarmCount) as SowFarmCount, Sum(NurseryWPCount) as NurseryWPCount
	from @FarmCount
	Group by PMID) FarmCount
	on cftPM.PMID = FarmCount.PMID

	where cftPM.MovementDate between @StartDate and @EndDate

	group by
	SS.PMLoadID,
	cftPM.MovementDate,
	SS.SowSource,
	DF.DestFarm
	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TRANSPORTATION_INVENTORY_CHECK_WP] TO [db_sp_exec]
    AS [dbo];

