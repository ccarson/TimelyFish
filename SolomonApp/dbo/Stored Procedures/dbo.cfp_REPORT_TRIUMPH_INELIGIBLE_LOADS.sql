-- =============================================
-- Author:		Matt Brandt
-- Create date: 01/26/2011
-- Description:	This procedure creates the dataset for the Triumph Ineligible Loads Report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_TRIUMPH_INELIGIBLE_LOADS 

AS
BEGIN

SET NOCOUNT ON;
    
Select RTrim(pm.PMLoadID) As PMLoadID
, ntpg.ContactName As Site
, pm.EstimatedQty
, pm.EstimatedWgt
, pm.MovementDate
, RTrim(ntpg.PigGroupID) As PigGroupID
, RTrim(c.ContactName) As Destination

From SolomonApp.dbo.cftPM pm with (nolock)
	Left Join (
		SELECT distinct fo.PigGroupID, pc.ContactName
		FROM SolomonApp.dbo.cftFeedOrder fo with (NOLOCK)
			Inner Join SolomonApp.dbo.cftPigGroup pg On fo.PigGroupID = pg.PigGroupID
			Inner Join SolomonApp.dbo.cftContact pc On pg.SiteContactID = pc.ContactID
		WHERE fo.InvtIdDel in ('053M-NT','054M-NT','055M-NT')
			and fo.Reversal='0'
			and fo.DateDel >= '01/01/2011') 
		ntpg on ntpg.PigGroupID=pm.SourcePigGroupID
	Left Join SolomonApp.dbo.cftContact c On c.ContactID = pm.DestContactID
	
Where pm.MovementDate >= GetDate()
	AND Right(pm.TranSubTypeID,1)='M'
	AND pm.SuppressFlg<>'-1'
	AND pm.Highlight not in ('255','-65536')
	and pm.MarketSaleTypeID in ('10','20','25','30')
	and ntpg.PigGroupID is not null
	and c.ContactName Like('%Triumph%')
	
Order By pm.PMLoadID

END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_TRIUMPH_INELIGIBLE_LOADS] TO [MSDSL]
    AS [dbo];

