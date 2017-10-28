CREATE PROCEDURE [dbo].[cfp_REPORT_MARKET_PREVIEW_FEED_HISTORY]
	@SiteContactID		char(6),
	@BarnID				varchar(8000)
AS

create table #Barns (BarnID char(5))
insert into #Barns select * from [$(SolomonApp)].dbo.cffn_SPLIT_STRING(@BarnID,',')

SELECT 
cftFeedOrder.PigGroupId, 
cftPigGroup.Description, 
cftPigGroup.PigGenderTypeID,
cftFeedOrder.PGQty,
cftOrderType.Descr, 
cftFeedLoad.LoadNbr, 
cftFeedOrder.OrdNbr, 
cftFeedOrder.BinNbr,
(cftFeedOrder.QtyOrd * 2000) QtyOrd,
cftFeedOrder.DateSched,
cftFeedOrder.DateDel, 
cftFeedOrder.InvtIdDel, 
cftFeedOrder.QtyDel,
cftFeedLoad.Rlsed_DateTime
FROM [$(SolomonApp)].dbo.cftContact cftContact (nolock)
INNER JOIN [$(SolomonApp)].dbo.cftSite cftSite (nolock)
	ON cftSite.ContactID = cftContact.ContactID
INNER JOIN [$(SolomonApp)].dbo.cftBarn cftBarn (nolock)
	ON cftBarn.SiteID = cftSite.SiteID
INNER JOIN	#Barns Barns
	ON	Barns.BarnID = cast(cftBarn.BarnID as int)
INNER JOIN [$(SolomonApp)].dbo.cftFeedOrder cftFeedOrder (nolock)
	ON cftFeedOrder.ContactId = cftContact.ContactID
	AND cftFeedOrder.BarnNbr = cftBarn.BarnNbr
LEFT JOIN [$(SolomonApp)].dbo.cftFeedLoad cftFeedLoad (nolock)
	ON cftFeedOrder.OrdNbr = cftFeedLoad.OrdNbr
INNER JOIN [$(SolomonApp)].dbo.cftPigGroup cftPigGroup (nolock)
	ON cftFeedOrder.PigGroupId = cftPigGroup.PigGroupID
INNER JOIN [$(SolomonApp)].dbo.cftOrderType cftOrderType (nolock)
	ON cftFeedOrder.OrdType = cftOrderType.OrdType
WHERE cast(cftContact.ContactID as int) = @SiteContactID
AND cftPigGroup.PGStatusID = 'A'
ORDER BY cftPigGroup.Description, cftFeedOrder.DateDel

drop table #Barns

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MARKET_PREVIEW_FEED_HISTORY] TO [db_sp_exec]
    AS [dbo];

