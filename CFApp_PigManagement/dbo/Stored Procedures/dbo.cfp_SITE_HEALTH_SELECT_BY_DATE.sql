-- =====================================================================
-- Author:		Matt Dawson
-- Create date: 07/07/2008
-- Description:	Returns the Site Health information from date input
-- =====================================================================
CREATE PROCEDURE [dbo].[cfp_SITE_HEALTH_SELECT_BY_DATE]
(
	@StartDate datetime
)
AS
BEGIN

CREATE TABLE #PGVisitTally
(	SrSvcManager varchar(100)
,	SvcManager varchar(100)
,	SiteContactID int
,	Site varchar(100)
,	BarnID int
,	BarnNbr varchar(6)
,	PigGroupID int
,	HealthConcern varchar(3)
,	LastVisit datetime
,	PreviousVisit datetime
,	DeadsLastContact bigint
,	DeadsWeek bigint
,	InjectionsLastContact bigint
,	InjectionsWeek bigint
,	PreviousWeekInventory bigint
,	WaterMedsUsed varchar(200))

/* populate base information */
INSERT INTO #PGVisitTally
SELECT
	Prod_SvcMgr_Contact.ContactName 'Sr Svc Mgr'
,	SvcMgr_Contact.ContactName 'Svc Mgr'
,	Site_Contact.ContactID 'SiteContactID'
,	Site_Contact.ContactName 'Site'
,	cft_Barn_Health.BarnID
,	Barn.BarnNbr
,	cft_Barn_Health.PigGroupID
,	CASE 
		WHEN cft_Site_Health.HealthConcern = 1 THEN 'Yes'
		ELSE 'No'
	END HealthConcern
,	MAX(cft_Site_Health.SiteContactDate) 'LastVisit'
,	MAX(cft_Site_Health_Prev.SiteContactDate) 'PrevVisit'
,	NULL --DeadsLastContact
,	NULL --DeadsWeek
,	NULL --InjectionsLastContact
,	NULL --InjectionsWeek
,	NULL --PreviousWeekInventory
,	NULL --WaterMedsUsed
FROM		(SELECT SiteContactID, MAX(SiteContactDate) MaxSiteContactDate FROM cft_site_health (nolock) WHERE SiteContactDate <= @StartDate GROUP BY SiteContactID) SiteHealthMaxDate
INNER JOIN	dbo.cft_Site_Health cft_Site_Health (NOLOCK)
	ON cft_Site_Health.SiteContactID = SiteHealthMaxDate.SiteContactID
	AND cft_Site_Health.SiteContactDate = SiteHealthMaxDate.MaxSiteContactDate
	AND cft_Site_Health.SiteContactDate <= @StartDate
left outer join cft_site_health cft_site_health_prev
	on cft_site_health_prev.sitecontactid = cft_site_health.sitecontactid
	and cft_site_health_prev.sitecontactdate < cft_site_health.sitecontactdate
	and cft_site_health_prev.sitecontactdate <= @StartDate
INNER JOIN	dbo.cft_Barn_Health cft_Barn_Health (NOLOCK)
	ON	cft_Barn_Health.SiteHealthID = cft_Site_Health.SiteHealthID
LEFT OUTER JOIN [$(CentralData)].dbo.Contact Site_Contact (NOLOCK)
	ON	Site_Contact.ContactID = cft_Site_Health.SiteContactID
INNER JOIN	(SELECT SiteContactID, MAX(EffectiveDate) EffDate FROM [$(CentralData)].dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment2
		WHERE SiteContactID = SiteSvcMgrAssignment2.SiteContactID
		AND EffectiveDate <= @StartDate
		GROUP BY SiteContactID) Sites
	ON Sites.SiteContactID = cft_Site_Health.SiteContactID
INNER JOIN	[$(CentralData)].dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment (NOLOCK)
	ON	SiteSvcMgrAssignment.SiteContactID = Sites.SiteContactID
	AND	SiteSvcMgrAssignment.EffectiveDate = Sites.EffDate
	AND	SiteSvcMgrAssignment.EffectiveDate <= @StartDate
LEFT OUTER JOIN [$(CentralData)].dbo.Contact SvcMgr_Contact (NOLOCK)
	ON	SvcMgr_Contact.ContactID = SiteSvcMgrAssignment.SvcMgrContactID

INNER JOIN	(SELECT SiteContactID, MAX(EffectiveDate) EffDate FROM [$(CentralData)].dbo.ProdSvcMgrAssignment ProdSvcMgrAssignment2
		WHERE SiteContactID = ProdSvcMgrAssignment2.SiteContactID
		AND EffectiveDate <= @StartDate
		GROUP BY SiteContactID) SrSvcMgrSites
	ON SrSvcMgrSites.SiteContactID = cft_Site_Health.SiteContactID
INNER JOIN	[$(CentralData)].dbo.ProdSvcMgrAssignment ProdSvcMgrAssignment (NOLOCK)
	ON	ProdSvcMgrAssignment.SiteContactID = SrSvcMgrSites.SiteContactID
	AND	ProdSvcMgrAssignment.EffectiveDate = SrSvcMgrSites.EffDate
	AND	ProdSvcMgrAssignment.EffectiveDate <= @StartDate
LEFT OUTER JOIN [$(CentralData)].dbo.Contact Prod_SvcMgr_Contact (NOLOCK)
	ON	Prod_SvcMgr_Contact.ContactID = ProdSvcMgrAssignment.ProdSvcMgrContactID

LEFT OUTER JOIN [$(CentralData)].dbo.Barn Barn (NOLOCK)
	ON	Barn.BarnID = cft_Barn_Health.BarnID
WHERE		cft_Site_Health.SiteContactDate >= dateadd(d,-7,@StartDate)
GROUP BY
	Prod_SvcMgr_Contact.ContactName
,	SvcMgr_Contact.ContactName
,	Site_Contact.ContactID
,	Site_Contact.ContactName
,	cft_Barn_Health.BarnID
,	Barn.BarnNbr
,	cft_Barn_Health.PigGroupID
,	cft_Site_Health.HealthConcern


/** START:	calculate deads last contact **/
UPDATE	PGVisitTally
SET	DeadsLastContact = DeadTbl.NumDead
FROM	#PGVisitTally PGVisitTally
INNER JOIN
	(SELECT cft_Site_Health.SiteContactID, cft_Barn_Health.BarnID, cft_Barn_Health.PigGroupID, SUM(cft_Barn_Health.NumberOfDead) 'NumDead'
	FROM		cft_Site_Health cft_Site_Health (NOLOCK)
	INNER JOIN	cft_Barn_Health cft_Barn_Health (NOLOCK)
		ON	cft_Barn_Health.SiteHealthID = cft_Site_Health.SiteHealthID
	INNER JOIN	#PGVisitTally PGVisitTally
		ON	PGVisitTally.SiteContactID = cft_Site_Health.SiteContactID
		AND	PGVisitTally.BarnID = cft_Barn_Health.BarnID
	WHERE	cft_Site_Health.SiteContactDate >= PGVisitTally.LastVisit
	AND	cft_Site_Health.SiteContactDate <= @StartDate
	GROUP BY cft_Site_Health.SiteContactID, cft_Barn_Health.BarnID, cft_Barn_Health.PigGroupID) DeadTbl
		ON DeadTbl.SiteContactID = PGVisitTally.SiteContactID
		AND DeadTbl.BarnID = PGVisitTally.BarnID
		AND DeadTbl.PigGroupID = PGVisitTally.PigGroupID
/** END:	calculate deads last contact **/


/** START:	calculate injections last contact **/
UPDATE	PGVisitTally
SET	InjectionsLastContact = InjectTbl.NumInjections
FROM	#PGVisitTally PGVisitTally
INNER JOIN
	(SELECT cft_Site_Health.SiteContactID, cft_Barn_Health.BarnID, cft_Barn_Health.PigGroupID, SUM(cft_Barn_Health.NumberOfInjections) 'NumInjections'
	FROM		cft_Site_Health cft_Site_Health (NOLOCK)
	INNER JOIN	cft_Barn_Health cft_Barn_Health (NOLOCK)
		ON	cft_Barn_Health.SiteHealthID = cft_Site_Health.SiteHealthID
	INNER JOIN	#PGVisitTally PGVisitTally
		ON	PGVisitTally.SiteContactID = cft_Site_Health.SiteContactID
		AND	PGVisitTally.BarnID = cft_Barn_Health.BarnID
	WHERE	cft_Site_Health.SiteContactDate >= PGVisitTally.LastVisit
	AND	cft_Site_Health.SiteContactDate <= @StartDate
	GROUP BY cft_Site_Health.SiteContactID, cft_Barn_Health.BarnID, cft_Barn_Health.PigGroupID) InjectTbl
		ON InjectTbl.SiteContactID = PGVisitTally.SiteContactID
		AND InjectTbl.BarnID = PGVisitTally.BarnID
		AND InjectTbl.PigGroupID = PGVisitTally.PigGroupID
/** END:	calculate injections last contact **/


/** START:	calculate deads last week **/
UPDATE	PGVisitTally
SET	DeadsWeek = DeadTbl.NumDead
FROM	#PGVisitTally PGVisitTally
INNER JOIN
	(SELECT cft_Site_Health.SiteContactID, cft_Barn_Health.BarnID, cft_Barn_Health.PigGroupID, SUM(cft_Barn_Health.NumberOfDead) 'NumDead'
	FROM		cft_Site_Health cft_Site_Health (NOLOCK)
	INNER JOIN	cft_Barn_Health cft_Barn_Health (NOLOCK)
		ON	cft_Barn_Health.SiteHealthID = cft_Site_Health.SiteHealthID
	INNER JOIN	#PGVisitTally PGVisitTally
		ON	PGVisitTally.SiteContactID = cft_Site_Health.SiteContactID
		AND	PGVisitTally.BarnID = cft_Barn_Health.BarnID
	WHERE	cft_Site_Health.SiteContactDate >= DATEADD(d,-7,@StartDate)
	GROUP BY cft_Site_Health.SiteContactID, cft_Barn_Health.BarnID, cft_Barn_Health.PigGroupID) DeadTbl
		ON DeadTbl.SiteContactID = PGVisitTally.SiteContactID
		AND DeadTbl.BarnID = PGVisitTally.BarnID
		AND DeadTbl.PigGroupID = PGVisitTally.PigGroupID
/** END:	calculate deads last week **/


/** START:	calculate injections last week **/
UPDATE	PGVisitTally
SET	InjectionsWeek = InjectTbl.NumInjections
FROM	#PGVisitTally PGVisitTally
INNER JOIN
	(SELECT cft_Site_Health.SiteContactID, cft_Barn_Health.BarnID, cft_Barn_Health.PigGroupID, SUM(cft_Barn_Health.NumberOfInjections) 'NumInjections'
	FROM		cft_Site_Health cft_Site_Health (NOLOCK)
	INNER JOIN	cft_Barn_Health cft_Barn_Health (NOLOCK)
		ON	cft_Barn_Health.SiteHealthID = cft_Site_Health.SiteHealthID
	INNER JOIN	#PGVisitTally PGVisitTally
		ON	PGVisitTally.SiteContactID = cft_Site_Health.SiteContactID
		AND	PGVisitTally.BarnID = cft_Barn_Health.BarnID
	WHERE	cft_Site_Health.SiteContactDate >= DATEADD(d,-7,@StartDate)
	GROUP BY cft_Site_Health.SiteContactID, cft_Barn_Health.BarnID, cft_Barn_Health.PigGroupID) InjectTbl
		ON InjectTbl.SiteContactID = PGVisitTally.SiteContactID
		AND InjectTbl.BarnID = PGVisitTally.BarnID
		AND InjectTbl.PigGroupID = PGVisitTally.PigGroupID
/** END:	calculate injections last week **/


/** START:	list water meds in last week **/
UPDATE	PGVisitTally
SET	WaterMedsUsed = dbo.cffn_GET_MEDICATIONS_BY_SITE_BARN_PIGGROUP(PGVisitTally.SiteContactID,PGVisitTally.BarnID,PGVisitTally.PigGroupID,@StartDate)
FROM	#PGVisitTally PGVisitTally
--adding next join because we can't be processing any medicationid's with null values
INNER JOIN	(SELECT cft_site_health.sitecontactid, cft_barn_health.barnid, cft_barn_health.piggroupid
		FROM cft_site_health cft_site_health (nolock)
		INNER JOIN cft_barn_health cft_barn_health
			ON cft_barn_health.sitehealthid = cft_site_health.sitehealthid
		WHERE cft_barn_health.medicationid IS NOT NULL
		GROUP BY cft_site_health.sitecontactid, cft_barn_health.barnid, cft_barn_health.piggroupid) validmeds
	ON validmeds.SiteContactID = PGVisitTally.SiteContactID
	AND validmeds.BarnID = PGVisitTally.BarnID
	AND validmeds.PigGroupID = PGVisitTally.PigGroupID
WHERE	PGVisitTally.lastvisit >= dateadd(d,-7,@StartDate)
/** END:	list water meds in last week **/


/** START:	calculate previous week's inventory, jmaas **/
UPDATE	PGVisitTally
SET	PreviousWeekInventory = Inv.Inventory
FROM	#PGVisitTally PGVisitTally
INNER JOIN
(select
t.InvDate,
t.GroupNumber,
t.PigGroupID,
t.GroupAlias,
t.SiteContactID,
t.BarnNbr,
Sum(t.Qty) Inventory
from
(select DATEADD(DD,-DATEPART(DW,@StartDate),@StartDate) InvDate, 
	rtrim(IT.acct) Account, 
	IT.TranDate, 
	'PG'+rtrim(IT.PigGroupID) 'GroupNumber',
	PG.PigGroupID,
	'PG'+rtrim(IT.PigGroupID)+'-'+rtrim(PG.Description) GroupAlias,
	PG.SiteContactID,
	PG.BarnNbr,
	IT.Qty*IT.InvEffect Qty
from [$(SolomonApp)].dbo.cftPGInvTran IT (NOLOCK)
left join [$(SolomonApp)].dbo.cftPigGroup PG (NOLOCK)
	on IT.PigGroupID=PG.PigGroupID
where
PG.PGStatusID='A'
and IT.Reversal = '0'
and IT.Qty <> '0'
--and IT.PigGroupID='20739'
/*THIS chooses the last Saturday from the current date*/
and IT.TranDate <=DATEADD(DD,-DATEPART(DW,@StartDate),@StartDate)
) t
group by
t.InvDate,
t.GroupNumber,
t.PigGroupID,
t.GroupAlias,
t.SiteContactID,
t.BarnNbr) Inv
	ON Inv.PigGroupID = PGVisitTally.PigGroupID
	AND Inv.SiteContactID = PGVisitTally.SiteContactID
	AND rtrim(Inv.BarnNbr) = rtrim(PGVisitTally.BarnNbr)
/** END:	calculate previous week's inventory, jmaas **/

SELECT
	#PGVisitTally.SrSvcManager
,	#PGVisitTally.SvcManager
,	#PGVisitTally.Site
,	#PGVisitTally.BarnNbr
,	#PGVisitTally.PigGroupID
,	COALESCE(cftPigGroup.PigProdPhaseID,'N/A') 'PigProdPhaseID'
,	#PGVisitTally.PreviousWeekInventory 'CurrentInventory'
,	#PGVisitTally.HealthConcern
,	CONVERT(VARCHAR,#PGVisitTally.LastVisit,101) 'LastVisit'
,	CONVERT(VARCHAR,#PGVisitTally.PreviousVisit,101) 'PreviousVisit'
/*   Number of deads since last contact/days since last contact*7/previous week's inventory*100   */
,	CASE WHEN (COALESCE(DeadsLastContact,0) = 0) OR (COALESCE(PreviousVisit,0) = 0) OR (COALESCE(PreviousWeekInventory,0) = 0)
	THEN
		NULL
	ELSE
		CAST(CAST((CAST(((CAST(COALESCE(DeadsLastContact,0) AS DECIMAL(18,6)) / CAST(ABS(DATEDIFF(DD,PreviousVisit,LastVisit)) AS DECIMAL(18,6))) * 7) AS DECIMAL(18,6))
		/ (PreviousWeekInventory)) AS NUMERIC (18,6)) * 100 AS NUMERIC(18,2))  
	END 'DeadsReportedLastContact'
/*   Sum of mortality reported in the week/previous week's inventory*100   */
,	CASE WHEN (COALESCE(PreviousWeekInventory,0) = 0)
	THEN
		NULL
	ELSE
		CAST((CAST(COALESCE(DeadsWeek,0) AS MONEY) 
		/ CAST(PreviousWeekInventory AS MONEY)) * 100 AS NUMERIC(18,2)) 
	END 'DeadsReportedLastWeek'
/*   Number of injections since last contact/days since last contact*7/previous week's inventory*1000   */
,	CASE WHEN (COALESCE(PreviousVisit,0) = 0) OR (COALESCE(PreviousWeekInventory,0) = 0)
	THEN
		NULL
	ELSE
		CAST(CAST((CAST(((CAST(COALESCE(InjectionsLastContact,0) AS DECIMAL(18,6)) / CAST(ABS(DATEDIFF(DD,PreviousVisit,LastVisit)) AS DECIMAL(18,6))) * 7) AS DECIMAL(18,6))
		/ (PreviousWeekInventory)) AS NUMERIC (18,6)) * 1000 AS NUMERIC(18,2))  
	END 'InjectionsReportedLastContact'

/*   Sum of injections reported in a week/previous week's inventory *1000   */
,	CASE WHEN (COALESCE(PreviousWeekInventory,0) = 0)
	THEN
		NULL
	ELSE
		CAST((CAST(COALESCE(InjectionsWeek,0) AS MONEY)
		/ CAST(PreviousWeekInventory AS MONEY)) * 1000 AS INT) 
	END 'InjectionsReportedLastWeek'
,	WaterMedsUsed
,	COALESCE(DeadsLastContact,0) 'DeadsLastContact'
,	COALESCE(DeadsWeek,0) 'DeadsWeek'
,	COALESCE(InjectionsLastContact,0) 'InjectionsLastContact'
,	COALESCE(InjectionsWeek,0) 'InjectionsWeek'

FROM #PGVisitTally
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigGroup cftPigGroup (NOLOCK)
	ON cftPigGroup.PigGroupID = #PGVisitTally.PigGroupID
WHERE RTRIM(cftPigGroup.PigProdPhaseID) IN ('TEF','FIN','NUR','WTF')
DROP TABLE #PGVisitTally
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_HEALTH_SELECT_BY_DATE] TO [db_sp_exec]
    AS [dbo];

