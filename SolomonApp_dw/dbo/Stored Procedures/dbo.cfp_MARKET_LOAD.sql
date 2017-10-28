

-----------------------------------------------------------------------------
--Author:	mdawson (matt@dawsonland.com)
--Created:	Feb 2011
--Updated:  25Oct2011 by BMD
-----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[cfp_MARKET_LOAD]
AS

DECLARE @Snapshot datetime
DECLARE @LastSnapshot datetime
SET     @Snapshot     = CONVERT(VARCHAR,GETDATE(),101)
SET     @LastSnapshot = (SELECT CONVERT(VARCHAR,LastImportDate,101) LastImportDate from  dbo.cft_MARKET_LOAD_IMPORT_DATE (NOLOCK))

BEGIN TRANSACTION
-----------------------------------------------------------------------------
-- START: LOAD BUILD TABLE
--
-- load the build table with any records created between now and the last import date
-----------------------------------------------------------------------------
truncate table  dbo.cft_MARKET_LOAD_BUILDTABLE

--remove Loads that have been updated since our last import, so they can be recalced and loaded again
-- Modified 10/25/2011 - BMD - removed views from in comments and put view SQL
--   inline with the query.  This allowed the query to actually run after the conversion
--   to SQL Server 2008 R2 with 2000 compatibility enabled.
--   Removed other older delete statements to clean up procedure
DELETE ml
FROM  dbo.cft_MARKET_LOAD ml 
JOIN [$(SolomonApp)].dbo.cftPM pm (NOLOCK)
	ON pm.PMLoadID = ml.PMLoadID
LEFT JOIN (-- This was the "cfvPigOffLoad" view
           Select pm.PMID as OrigPMID, pm.TranSubTypeID, PMID=Case when right(rtrim(pm.TranSubTypeID),1)='O' then 
			o.DestPMID 			else 			pm.PMID end
		     From [$(SolomonApp)].dbo.cftPigSale ps (NOLOCK)
		     join [$(SolomonApp)].dbo.cftPM pm (NOLOCK) on ps.PMLoadID=pm.PMID
        LEFT JOIN [$(SolomonApp)].dbo.cftPigOffload o (NOLOCK) on cast(pm.PMID as Integer)=o.SrcPMID ) pol 
	ON pol.PMID = pm.PMID
inner JOIN [$(SolomonApp)].dbo.cfv_PIG_SALE_LOAD_STATS psd (NOLOCK)
	ON psd.PMLoadID = pol.OrigPMID
LEFT JOIN (-- This was the "cfvPIGSALEREV" view
           Select s.PMLoadID, s.Lupd_DateTime 
             From [$(SolomonApp)].dbo.cftPigSale s (NOLOCK)
        LEFT JOIN [$(SolomonApp)].dbo.cftPigSale AS reverse2 (NOLOCK) ON s.RefNbr=reverse2.OrigRefNbr
            Where s.ARRefNbr<>'' AND s.DocType<>'RE' AND ISNULL(reverse2.RefNbr,'')='') psr
	ON psr.PMLoadID = pol.OrigPMID
 WHERE (   (pm.Crtd_DateTime >= @LastSnapshot and pm.Crtd_DateTime < @SnapShot)
        OR (pm.Lupd_DateTime >= @LastSnapshot and pm.Lupd_DateTime < @SnapShot)
        OR (psr.Lupd_DateTime >= @LastSnapshot and psr.Lupd_DateTime < @SnapShot))
option (maxdop 4)


--get loads to insert
CREATE TABLE #LoadsToInsert
(	PMLoadID char(10))

-- Modified 10/25/2011 - BMD - removed views from in comments and put view SQL
--   inline with the query.  This allowed the query to actually run after the conversion
--   to SQL Server 2008 R2 with 2000 compatibility enabled. 
INSERT INTO #LoadsToInsert
SELECT distinct pm.PMLoadID
  FROM [$(SolomonApp)].dbo.cftPM pm (NOLOCK)
LEFT JOIN (-- This was the "cfvPigOffLoad" view
           Select pm.PMID as OrigPMID, pm.TranSubTypeID, PMID=Case when right(rtrim(pm.TranSubTypeID),1)='O' then 
			o.DestPMID 			else 			pm.PMID end
		     From [$(SolomonApp)].dbo.cftPigSale ps 
		     join [$(SolomonApp)].dbo.cftPM pm on ps.PMLoadID=pm.PMID
        LEFT JOIN [$(SolomonApp)].dbo.cftPigOffload o on cast(pm.PMID as Integer)=o.SrcPMID ) pol 
	ON pol.PMID = pm.PMID
inner JOIN [$(SolomonApp)].dbo.cfv_PIG_SALE_LOAD_STATS psd (NOLOCK)
	ON psd.PMLoadID = pol.OrigPMID
LEFT JOIN (-- This was the "cfvPIGSALEREV" view
           Select s.PMLoadID, s.Lupd_DateTime 
             From [$(SolomonApp)].dbo.cftPigSale s
        LEFT JOIN [$(SolomonApp)].dbo.cftPigSale AS reverse2 ON s.RefNbr=reverse2.OrigRefNbr
            Where s.ARRefNbr<>'' AND s.DocType<>'RE' AND ISNULL(reverse2.RefNbr,'')='') psr
	ON psr.PMLoadID = pol.OrigPMID
 WHERE (   (pm.Crtd_DateTime >= @LastSnapshot and pm.Crtd_DateTime < @SnapShot)
        OR (pm.Lupd_DateTime >= @LastSnapshot and pm.Lupd_DateTime < @SnapShot)
        OR (psr.Lupd_DateTime >= @LastSnapshot and psr.Lupd_DateTime < @SnapShot))
option (maxdop 4)


--load the build table with new/updated loads
insert into  dbo.cft_MARKET_LOAD_BUILDTABLE
SELECT	distinct
	pm.PMLoadID,
	pm.PMID,
	mst.Description, --MarketSaleType
	pm.SourceContactID,
	SourceContact.ContactName,
	pm.DestContactID,
	psd.PigGroupID,
	psd.PigQuantity,
	psd.LoadWeight LoadWeight,
	psd.Standards,
	psd.DeadOnArrival DoA,
	psd.DeadInYard DiY,
	psd.Condemns,
	psd.Boars,
	psd.Subjects,
	psd.Abcess,
	psd.BellyBust,
	psd.RearRupture,
	psd.Heavy,
	psd.Lites,
	psd.InsectBite,
	psd.TailBite,
	--CASE WHEN pg.EUPLSFP = 0 THEN '' ELSE 'Paylean' END AS Paylean,
	'',
	pm.MovementDate,
	PackerContact.ContactID PackerContactID,
	PackerContact.ContactName PackerName,
	lc.LoadCrewName,
	pm.TruckerContactID,
	TruckerContact.ContactName TruckerName,
	mm.OneWayMiles Distance,
	(Select Top 1 pf.PigFlowID From  dbo.cft_PIG_GROUP_CENSUS pf Where psd.PigGroupID = pf.PigGroupID Order By pf.CurrentInv Desc) As PigFlowID,
	[$(SolomonApp)].dbo.IsSplitLoad(pm.PMLoadID) SplitLoad,
	mgr.SvcContactID ServiceManagerContactID,
	mgr.SvcMgrName ServiceManager,
	mgr.SrSvcContactID SrServiceManagerContactID,
	mgr.SrSvcName SrServiceManager,
	0 --removed flag
FROM	[$(SolomonApp)].dbo.cftPM pm (NOLOCK)
INNER JOIN #LoadsToInsert lti
	ON lti.PMLoadID = pm.PMLoadID
LEFT JOIN [$(SolomonApp)].dbo.cfvCurrentSrSvcMgr mgr (NOLOCK)
	ON mgr.ContactID = pm.SourceContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK)
	ON TruckerContact.ContactID = pm.TruckerContactID

LEFT JOIN [$(SolomonApp)].dbo.cfvPigOffLoad pol (NOLOCK)
	ON pol.PMID = pm.PMID

inner JOIN [$(SolomonApp)].dbo.cfv_PIG_SALE_LOAD_STATS psd
	ON psd.PMLoadID = pol.OrigPMID

LEFT JOIN [$(SolomonApp)].dbo.cfvPIGSALEREV psr
	ON psr.PMLoadID = pol.OrigPMID

LEFT JOIN [$(SolomonApp)].dbo.cftPigGroup pg (NOLOCK)
	ON pg.PigGroupID = psd.PigGroupID

LEFT JOIN [$(SolomonApp)].dbo.cftContact PackerContact (NOLOCK)
	ON PackerContact.ContactID = psd.PkrContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK)
	ON SourceContact.ContactID = pm.SourceContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContactAddress SourceContactAddress (NOLOCK)
	ON SourceContactAddress.ContactID = pm.SourceContactID
	AND SourceContactAddress.AddressTypeID = '01' --physical
LEFT JOIN [$(SolomonApp)].dbo.cftContactAddress DestContactAddress (NOLOCK)
	ON DestContactAddress.ContactID = pm.DestContactID
	AND DestContactAddress.AddressTypeID = '01' --physical
LEFT JOIN [$(SolomonApp)].dbo.cftMilesMatrix mm (NOLOCK)
	ON mm.AddressIDFrom = SourceContactAddress.AddressID
	AND mm.AddressIDTo = DestContactAddress.AddressID
LEFT JOIN [$(SolomonApp)].dbo.cfv_SITE_LOAD_CREW lc
	ON lc.SiteContactID = pm.SourceContactID
	AND pm.MovementDate BETWEEN lc.AssignedFromDate AND lc.AssignedToDate
LEFT JOIN [$(SolomonApp)].dbo.cftMarketSaleType mst (NOLOCK)
	ON mst.MarketSaleTypeID = pm.MarketSaleTypeID


drop table #LoadsToInsert

-----------------------------------------------------------------------------
-- END: LOAD BUILD TABLE
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Set Paylean Value
-----------------------------------------------------------------------------
update  dbo.cft_MARKET_LOAD_BUILDTABLE
SET  dbo.cft_MARKET_LOAD_BUILDTABLE.Paylean = 'Paylean'
from  dbo.cft_MARKET_LOAD_BUILDTABLE mlb 
INNER JOIN [$(SolomonApp)].[dbo].[cftFeedOrder] fo ON mlb.piggroupID = fo.piggroupID and fo.[DateDel] <= mlb.MovementDate
where fo.InvtIdDel like '075%' and mlb.piggroupID <> ''

-----------------------------------------------------------------------------
-- END: Set Paylean Value
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- LOAD NEW RECORDS
-----------------------------------------------------------------------------
INSERT INTO  dbo.cft_MARKET_LOAD
(	PMLoadID
,	PigQuantity
,	LoadWeight

,	Standards
,	DoA
,	DiY
,	Condemns
,	Boars
,	Subjects
,	Abcess
,	BellyBust
,	RearRupture
,	Heavy
,	Lites
,	InsectBite
,	TailBite
,	ImportDate)
SELECT	PMLoadID
,		SUM(ISNULL(PigQuantity,0))
,		CASE WHEN 
			(SUM(ISNULL(Standards,0))
			+		SUM(ISNULL(DoA,0))
			+		SUM(ISNULL(DiY,0))
			+		SUM(ISNULL(Condemns,0))
			+		SUM(ISNULL(Boars,0))
			+		SUM(ISNULL(Subjects,0))
			+		SUM(ISNULL(Abcess,0))
			+		SUM(ISNULL(BellyBust,0))
			+		SUM(ISNULL(RearRupture,0))
			+		SUM(ISNULL(Heavy,0))
			+		SUM(ISNULL(Lites,0))
			+		SUM(ISNULL(InsectBite,0))
			+		SUM(ISNULL(TailBite,0))) = 0

		THEN 0
		ELSE
			SUM(ISNULL(LoadWeight,0))
			/
					(SUM(ISNULL(Standards,0))
			+		SUM(ISNULL(DoA,0))
			+		SUM(ISNULL(DiY,0))
			+		SUM(ISNULL(Condemns,0))
			+		SUM(ISNULL(Boars,0))
			+		SUM(ISNULL(Subjects,0))
			+		SUM(ISNULL(Abcess,0))
			+		SUM(ISNULL(BellyBust,0))
			+		SUM(ISNULL(RearRupture,0))
			+		SUM(ISNULL(Heavy,0))
			+		SUM(ISNULL(Lites,0))
			+		SUM(ISNULL(InsectBite,0))
			+		SUM(ISNULL(TailBite,0)))
		END
,		SUM(ISNULL(Standards,0))
,		SUM(ISNULL(DoA,0))
,		SUM(ISNULL(DiY,0))
,		SUM(ISNULL(Condemns,0))
,		SUM(ISNULL(Boars,0))
,		SUM(ISNULL(Subjects,0))
,		SUM(ISNULL(Abcess,0))
,		SUM(ISNULL(BellyBust,0))
,		SUM(ISNULL(RearRupture,0))
,		SUM(ISNULL(Heavy,0))
,		SUM(ISNULL(Lites,0))
,		SUM(ISNULL(InsectBite,0))
,		SUM(ISNULL(TailBite,0))
,		@SnapShot

FROM  dbo.cft_MARKET_LOAD_BUILDTABLE (NOLOCK)
GROUP BY PMLoadID

-----------------------------------------------------------------------------
-- START: MAJORITY OF PIGS
--
-- this is where we find out the source of where the majority of the pigs are
-- to help us build our table so there are no dupe PMLoadID's
-----------------------------------------------------------------------------
create table #MultLoads
(	MarketLoadID bigint
,	PMLoadID char(10)
,	SourceContactID char(10)
,	PigGroupID char(10)
,	PigQuantity smallint)

DECLARE @PMLoadID char(10)
DECLARE LoadCursor CURSOR FOR
select PMLoadID from  dbo.cft_MARKET_LOAD_BUILDTABLE group by PMLoadID having count(PMLoadID) > 1

OPEN LoadCursor

FETCH NEXT FROM LoadCursor
INTO @PMLoadID

WHILE (@@FETCH_STATUS <> -1)
BEGIN

	INSERT INTO #MultLoads
	SELECT	TOP 1 
			MarketLoadID,
			PMLoadID,
			SourceContactID,
			isnull(PigGroupID,'9999999999') PigGroupID,
			PigQuantity
	FROM  dbo.cft_MARKET_LOAD_BUILDTABLE (NOLOCK)
	WHERE PMLoadID = @PMLoadID
	ORDER BY PigQuantity DESC, PigGroupID

	FETCH NEXT FROM LoadCursor
	INTO @PMLoadID
END

CLOSE LoadCursor
DEALLOCATE LoadCursor

--remove load dupes that are not majority
UPDATE bt
SET Removed = 1
FROM  dbo.cft_MARKET_LOAD_BUILDTABLE bt
JOIN #MultLoads ml
	ON ml.PMLoadID = bt.PMLoadID
	AND ml.MarketLoadID <> bt.MarketLoadID

drop table #MultLoads
-----------------------------------------------------------------------------
-- END: MAJORITY OF PIGS
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- POPULATE cft_MARKET_LOAD
-----------------------------------------------------------------------------
UPDATE ml
SET	OriginSiteContactID = bt.SourceContactID
,	OriginSiteName = bt.OriginSiteName
,	DestContactID = bt.DestContactID
,	PigGroupID = bt.PigGroupID
,	Paylean = bt.Paylean
,	MovementDate = bt.MovementDate
,	PackerContactID = bt.PackerContactID
,	PackerName = bt.PackerName
,	LoadCrewName = bt.LoadCrewName
,	TruckerContactID = bt.TruckerContactID
,	TruckerName = bt.TruckerName
,	Distance = bt.Distance
,	PigFlowID = bt.PigFlowID
,	SplitLoad = bt.SplitLoad
,	ServiceManagerContactID = bt.ServiceManagerContactID
,	ServiceManagerName = bt.ServiceManagerName
,	SrServiceManagerContactID = bt.SrServiceManagerContactID
,	SrServiceManagerName = bt.SrServiceManagerName
,	MarketSaleType = bt.MarketSaleType
FROM  dbo.cft_MARKET_LOAD ml
JOIN  dbo.cft_MARKET_LOAD_BUILDTABLE bt
	ON bt.PMLoadID = ml.PMLoadID
	AND Removed <> 1


-----------------------------------------------------------------------------
-- RECORD LAST IMPORT
-----------------------------------------------------------------------------
UPDATE  dbo.cft_MARKET_LOAD_IMPORT_DATE
SET LastImportDate = @Snapshot

COMMIT TRANSACTION
