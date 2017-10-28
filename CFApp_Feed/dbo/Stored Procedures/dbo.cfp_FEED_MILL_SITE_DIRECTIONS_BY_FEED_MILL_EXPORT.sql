-- =============================================
-- Author:		Matt Dawson
-- Create date: 11/11/2008
-- Description:	
-- =============================================
CREATE Procedure [dbo].[cfp_FEED_MILL_SITE_DIRECTIONS_BY_FEED_MILL_EXPORT]
	@FeedMillID CHAR(10)
,	@Manual bit
AS
BEGIN

-- Process records if there have been any changes in the last 15 minutes
DECLARE @recs INT
select @recs = count(*) from dbo.cft_FEED_MILL_SITE_DIRECTIONS (nolock)
	where RTRIM(FeedMillID) = RTRIM(@FeedMillID)
	and (CreatedDateTime >= DATEADD(n,-15,GETDATE()) or UpdatedDateTime >= DATEADD(n,-15,GETDATE()))
select @recs = @recs + count(*) from dbo.cft_FEED_MILL_ROAD_RESTRICTIONS (nolock)
	where RTRIM(FeedMillID) = RTRIM(@FeedMillID)
	and (UpdatedDateTime >= DATEADD(n,-15,GETDATE()))

if (@recs > 0 or @Manual > 0)
BEGIN
	SELECT 
		cast(REPLICATE('0',6 - LEN(fmsd.ContactID)) + cast(fmsd.ContactID as varchar) as char(6)) 'ContactID'
	,	cast([$(SolomonApp)].dbo.RemoveCSVChars(RTRIM(c.ContactName)) as varchar(50)) 'ContactName'
	,	cast('' as varchar(1)) 'Filler1'
	,	cast('' as varchar(1)) 'Filler2'
	,	cast([$(SolomonApp)].dbo.RemoveCSVChars(RTRIM(ISNULL(a.Address1,''))) as varchar(30)) 'Address1'
	,	cast([$(SolomonApp)].dbo.RemoveCSVChars(RTRIM(ISNULL(a.Address2,''))) as varchar(30)) 'Address2'
	,	RTRIM(ISNULL(a.City,'')) 'City'
	,	RTRIM(ISNULL(a.State,'')) 'State'
	,	cast('' as varchar(1)) 'Filler3'
	,	cast('' as varchar(1)) 'Filler4'
	,	cast('' as varchar(1)) 'Filler5'
	,	cast('' as varchar(1)) 'Filler6'
	,	'0' 'Filler7'
	,	'0' 'Filler8'
	,	'0' 'Filler9'
	,	'0' 'Filler10'
	,	cast('' as varchar(1)) 'Filler11'
	,	cast('' as varchar(1)) 'Filler12'
	,	cast('' as varchar(1)) 'Filler13'
	,	cast('' as varchar(1)) 'Filler14'
	,	cast([$(SolomonApp)].dbo.RemoveCSVChars(RTRIM(ISNULL(fmsd.Directions,''))) as varchar(4000)) 'Directions'
	FROM	dbo.cft_FEED_MILL_SITE_DIRECTIONS fmsd (NOLOCK)
	INNER JOIN	dbo.cft_FEED_MILL_ROAD_RESTRICTIONS fmrr (NOLOCK)
		ON	RTRIM(fmrr.FeedMillID) = RTRIM(fmsd.FeedMillID)
		AND	fmrr.RoadRestrictions = fmsd.RoadRestrictions
	INNER JOIN	[$(SolomonApp)].dbo.cftContact c (NOLOCK)
		ON	c.ContactID = fmsd.ContactID
	INNER JOIN	[$(SolomonApp)].dbo.cftContactAddress ca (NOLOCK)
		ON	ca.ContactID = c.ContactID
		AND	ca.AddressTypeID = '01'
	INNER JOIN	[$(SolomonApp)].dbo.cftAddress a (NOLOCK)
		ON	a.AddressID = ca.AddressID
	WHERE	c.StatusTypeID = '1'
	AND	fmsd.Active = 1
	AND	RTRIM(fmsd.FeedMillID) = RTRIM(@FeedMillID)
END
ELSE
BEGIN
	--show blank result set, no feedmillid's exist as 'XXX'
	SELECT 
		cast('' as varchar(1)) 'ContactID'
	,	cast('' as varchar(1)) 'ContactName'
	,	cast('' as varchar(1)) 'Filler1'
	,	cast('' as varchar(1)) 'Filler2'
	,	cast('' as varchar(1)) 'Address1'
	,	cast('' as varchar(1)) 'Address2'
	,	cast('' as varchar(1)) 'City'
	,	cast('' as varchar(1)) 'State'
	,	cast('' as varchar(1)) 'Filler3'
	,	cast('' as varchar(1)) 'Filler4'
	,	cast('' as varchar(1)) 'Filler5'
	,	cast('' as varchar(1)) 'Filler6'
	,	cast('' as varchar(1)) 'Filler7'
	,	cast('' as varchar(1)) 'Filler8'
	,	cast('' as varchar(1)) 'Filler9'
	,	cast('' as varchar(1)) 'Filler10'
	,	cast('' as varchar(1)) 'Filler11'
	,	cast('' as varchar(1)) 'Filler12'
	,	cast('' as varchar(1)) 'Filler13'
	,	cast('' as varchar(1)) 'Filler14'
	,	cast('' as varchar(1)) 'Directions'
	FROM	dbo.cft_FEED_MILL_SITE_DIRECTIONS fmsd (NOLOCK)
	WHERE	RTRIM(fmsd.FeedMillID) = 'XXX' END

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FEED_MILL_SITE_DIRECTIONS_BY_FEED_MILL_EXPORT] TO [db_sp_exec]
    AS [dbo];

