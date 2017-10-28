Create   View dbo.vXF686PayleanUsage

 

AS

Select fo.*,c.ContactName,

SvcMgr=(Select TOP 1 c.ContactName 

                        from cftSiteSvcMgrAsn sa JOIN cftContact c on sa.SvcMgrContactID=c.ContactID

                        where SiteContactID=fo.ContactID and sa.EffectiveDate<=fo.DateOrd order by sa.EffectiveDate DESC)

FROM cftFeedOrder fo WITH (NOLOCK)

JOIN cftContact c on fo.ContactID=c.ContactID

where fo.InvtIdDel in ('075b', '075c', '075d', '075m', '075M-t', '075m-ty100') 

   or fo.InvtIdOrd in ('075b', '075c', '075d', '075m', '075M-t', '075m-ty100')

