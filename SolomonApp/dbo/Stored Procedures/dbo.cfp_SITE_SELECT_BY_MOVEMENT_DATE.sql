
create procedure [dbo].[cfp_SITE_SELECT_BY_MOVEMENT_DATE]
(	@StartDate datetime
,	@EndDate datetime)
as

SELECT   Distinct 
	RTRIM(pm.SourceContactID) as SourceContactID
,	RTRIM(cs.ContactName) as SourceFarm
FROM         dbo.cftPM pm (nolock)
		LEFT JOIN cftSite s (nolock) on pm.SourceContactID=s.ContactID
		LEFT JOIN cftContact cs (nolock) ON pm.SourceContactID=cs.ContactID
		LEFT JOIN dbo.cftPigOffload o (nolock) on pm.PMID=o.SrcPMID
		LEFT JOIN cftPM op (nolock) on o.DestPMID=op.PMID

WHERE (pm.TattooFlag<>0 or op.TattooFlag<>0)
and pm.Highlight<>255
and left(pm.TranSubTypeID,1)<>'O'
and pm.MovementDate between @StartDate and @EndDate
ORDER BY RTRIM(cs.ContactName)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_SITE_SELECT_BY_MOVEMENT_DATE] TO [MSDSL]
    AS [dbo];

