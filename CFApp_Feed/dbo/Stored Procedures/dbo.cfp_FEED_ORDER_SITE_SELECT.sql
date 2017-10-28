-- =============================================
-- Author:		Matt Dawson
-- Create date: 02/09/2009
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FEED_ORDER_SITE_SELECT]
	@FeedMillID CHAR(10)
AS
BEGIN

	SELECT  sbrb.ContactID
	,       sbrb.ContactName
	,     cfv_CURRENT_SITE_SERVICE_MANAGER.ServiceManagerName
	,     sbrb.FacilityTypeID
	,     sbrb.barnid
	,     sbrb.barnnbr
	,     sbrb.BarnType
	,     sbrb.binnbr
	,     sbrb.bintypedescription
	,     sbrb.LastBinReadingDate
	,     sbrb.CurrentBinQuantity
	,     sbrb.roomnbr
	,     cftPigGroup.PigProdPhaseID
	,     cftPigProdPhase.PhaseDesc
	,     cftPigGroup.PigGroupID
	,     CASE WHEN (sbrb.FacilityTypeID = 1)
		  THEN sbrb.StdCap
		  ELSE [$(SolomonApp)].dbo.PGGetInventory(cftPigGroup.PigGroupID)
		  END 'InventoryGroup'
	,     CASE WHEN (sbrb.FacilityTypeID = 1)
		  THEN sbrb.StdCap
		  ELSE [$(SolomonApp)].dbo.PGGetInventory(cftPigGroup.PigGroupID) * sbrb.BarnCapPercentage 
		  END 'InventoryBin'
	,     cftFeedOrder.QtyOrd
	,     cftFeedOrder.InvtIdOrd
	,     cftFeedOrder.DateSched
	,     '' 'DaysOfFeedRemaining'
	,     '' 'FeederType'
	,     cftFeedOrder.LoadNbr
	from  [$(CentralData)].dbo.cfv_SITE_BARN_ROOM_BIN sbrb
	left join [$(CentralData)].dbo.cfv_CURRENT_SITE_SERVICE_MANAGER cfv_CURRENT_SITE_SERVICE_MANAGER
		  on cfv_CURRENT_SITE_SERVICE_MANAGER.SiteContactID = sbrb.ContactID
	left join [$(SolomonApp)].dbo.cftContact ContactSvcMgr (nolock)
		  on ContactSvcMgr.ContactID = cfv_CURRENT_SITE_SERVICE_MANAGER.ServiceManagerContactID
	left join   [$(CentralData)].dbo.Site Site (nolock)
		  on    Site.ContactID = sbrb.ContactID
	left join   [$(SolomonApp)].dbo.cftPigGroup cftPigGroup (nolock)
		  on    cast(cftPigGroup.SiteContactID as int) = sbrb.ContactID
		  and   cftPigGroup.BarnNbr = sbrb.BarnNbr
	--      and   sbrb.FacilityTypeID <> 1 -- not sow farms
		  and   cftPigGroup.PigProdPhaseID IN ('TEF','FIN','NUR','WTF')
		  and   cftPigGroup.PGStatusID IN ('F', 'A', 'T')
	left join   [$(SolomonApp)].dbo.cftPigProdPhase cftPigProdPhase (nolock)
		  ON    cftPigProdPhase.PigProdPhaseID = cftPigGroup.PigProdPhaseID
	left join   [$(SolomonApp)].dbo.cftFeedOrder cftFeedOrder WITH (INDEX(cftFeedOrder_piggroup))
		  on    cftFeedOrder.PigGroupID = cftPigGroup.PigGroupID
		  and   cftFeedOrder.BarnNbr = sbrb.BarnNbr
		  and   cftFeedOrder.BinNbr = sbrb.BinNbr
		  and   rtrim(cftFeedOrder.RoomNbr) = ISNULL(sbrb.RoomNbr,'')
		  and   cast(cftFeedOrder.ContactID as int) = sbrb.ContactID
		  and cftFeedOrder.Status <> 'C'
		  and cftFeedOrder.Status <> 'X'
	left join   [$(SolomonApp)].dbo.cftMillSite cftMillSite (nolock)
		  on    cast(cftMillSite.MillID as int) = cast(COALESCE(cftFeedOrder.MillID, cftPigGroup.FeedMillContactID, Site.FeedMillContactID) as int)
	where cftMillSite.SiteID = @FeedMillID
	group by sbrb.ContactID, sbrb.ContactName, cfv_CURRENT_SITE_SERVICE_MANAGER.ServiceManagerName, sbrb.FacilityTypeID, sbrb.barnid, sbrb.barnnbr, sbrb.BarnType, sbrb.StdCap,
	sbrb.binnbr, sbrb.bintypedescription, sbrb.LastBinReadingDate, sbrb.CurrentBinQuantity, sbrb.roomnbr
	,     cftPigGroup.PigProdPhaseID
	,     cftPigProdPhase.PhaseDesc
	,     cftPigGroup.PigGroupID
	,     sbrb.BarnCapPercentage
	,     cftFeedOrder.QtyOrd
	,     cftFeedOrder.InvtIdOrd
	,     cftFeedOrder.DateSched
	,     cftFeedOrder.LoadNbr
	Order by sbrb.ContactName, sbrb.barnnbr, sbrb.bintypedescription, sbrb.roomnbr, sbrb.binnbr, sbrb.FacilityTypeID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_ORDER_SITE_SELECT] TO [db_sp_exec]
    AS [dbo];

