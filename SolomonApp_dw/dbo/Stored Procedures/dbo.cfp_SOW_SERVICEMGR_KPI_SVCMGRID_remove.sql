


-- =============================================
-- Author:		Mike Zimanski
-- Create date: 11/22/2010
-- Description:	Returns alL Service Mgrs in Sow System
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_SERVICEMGR_KPI_SVCMGRID_remove]
(
	 @FYPeriod			int

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT	-1 as SvcMgrID, '--All--' as SvcMgr
	UNION ALL

	Select Distinct 
	
	SvcMgrC.ContactId SvcMgrID,
	SvcMgrC.Contactname SvcMgr

	From earth.Sowdata.dbo.FarmSetup Farm	-- removed the saturn_reference 20130905 smr as part of the  saturn_retirement 

	cross join [$(SolomonApp)].dbo.cftWeekDefinition WeekDef (nolock)

	left join [$(CentralData)].dbo.Contact Contact (nolock)
	on Farm.ContactID = Contact.ContactID

	left join [$(CentralData)].dbo.Site Site (nolock)
	on Farm.ContactID = Site.ContactID

	--Service Manager--

	left join [$(SolomonApp)].dbo.cftSiteSvcMgrAsn SvcMgrS (nolock)
	on Farm.ContactID = SvcMgrS.SiteContactID
	and SvcMgrS.effectivedate =
	(select max(effectivedate)
	from [$(SolomonApp)].dbo.cftsitesvcmgrasn 
	where sitecontactid=farm.contactid
	and effectivedate <= (select max(WeekEndDate)
	from [$(SolomonApp)].dbo.cftWeekDefinition 
	where fiscalyear = weekdef.fiscalyear
	and fiscalperiod = weekdef.fiscalperiod
	group by fiscalyear, fiscalperiod))

	left join [$(CentralData)].dbo.Contact SvcMgrC (nolock)
	on SvcMgrS.SvcMgrContactId = SvcMgrC.ContactID

	Where
	Farm.Status = 'A'
	and Contact.StatusTypeID = '01'
	and Contact.ContactId not in ('002286','002287')
	and Case when Weekdef.FiscalPeriod < 10 
	then Rtrim(CAST(Weekdef.FiscalYear AS char)) + '0' + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) 
	else Rtrim(CAST(Weekdef.FiscalYear AS char)) + Rtrim(CAST(Weekdef.FiscalPeriod AS char)) end like @FYPeriod
	
	Group by
	SvcMgrC.Contactname,
	SvcMgrC.ContactId 
	
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SERVICEMGR_KPI_SVCMGRID_remove] TO [db_sp_exec]
    AS [dbo];

