




-- =============================================
-- Author:		Mike Zimanski
-- Create date: 11/22/2010
-- Description:	Returns alL Sites in Sow System
-- 20150330 sripley, ref pigchamp changes.
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_SERVICEMGR_KPI_SITE]
(
	 @FYPeriod			int
	,@SvcMgrID			varchar(20)

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @TempSvcMgrID varchar(20)

	IF @SvcMgrID = -1 

	BEGIN
		SET @TempSvcMgrID = '%'
	END
	
	ELSE
	BEGIN
		SET @TempSvcMgrID = @SvcMgrID
	END

	SELECT	-1 as SiteID, '--All--' as Site
	UNION ALL
	
	Select Distinct 
	
	Site.Siteid,
	Contact.Contactname Site
	From [$(PigCHAMP)].[dbo].[CFV_FarmSetup] Farm	-- 20150330 ref pigchamp

	cross join [$(SolomonApp)].dbo.cftWeekDefinition WeekDef (nolock)

	left join [$(CentralData)].dbo.Contact Contact (nolock)
	on Farm.ContactID = Contact.ContactID

	left join [$(CentralData)].dbo.Site Site (nolock)
	on Farm.ContactID = Site.ContactID

	--Service Manager--

	left join [$(SolomonApp)].dbo.cftSiteSvcMgrAsn SvcMgrS (nolock)
	on cast(Farm.ContactID as int) = cast(SvcMgrS.SiteContactID as int)	--20150330 smr -- ref pigchamp
	and SvcMgrS.effectivedate =
	(select max(effectivedate)
	from [$(SolomonApp)].dbo.cftsitesvcmgrasn 
	where cast(sitecontactid as int)=cast(farm.contactid as int)	--20150330 smr -- ref pigchamp
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
	and SvcMgrC.ContactID like @TempSvcMgrID
	
	Group by
	Contact.Contactname,
	Site.SiteID

	/*Select Distinct 
	
	Site.Siteid,
	Contact.Contactname Site

	From [$(PigCHAMP)].[dbo].[CFV_FarmSetup] Farm	-- removed saturn reference 20130905 smr, part of the saturn retirement. 

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
	and SvcMgrC.ContactID like @TempSvcMgrID
	
	Group by
	Contact.Contactname,
	Site.SiteID
*/
	
END







GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SERVICEMGR_KPI_SITE] TO [db_sp_exec]
    AS [dbo];

