CREATE PROCEDURE [dbo].[cfp_REPORT_PIGGROUP_CLOSEOUTS]
(@StartDate datetime,
@EndDate datetime)
AS

select  distinct c.contactname as FeedOrderRep,
            pg.piggroupID as OpenGroup, 
            pg.description,
            pg.pigprodphaseID,
            Case when pg.pgstatusID in ('a','t') then min(pm.movementdate) else '' end as FirstCloseOutDate,
            Case when pg.pgstatusID in ('a','t') then max(pm.movementdate) else '' end as LastCloseOutDate,
            pg2.piggroupID as NextGroup,
            pg2.eststartdate as SubEstStartDate
            
from [$(SolomonApp)].dbo.cftpiggroup pg (nolock)
left join [$(SolomonApp)].dbo.cftpm pm (nolock) 
	on pg.piggroupID = pm.sourcepiggroupID
left join [$(SolomonApp)].dbo.cftpiggroup pg2 (nolock) 
	on pg.sitecontactID = pg2.sitecontactID 
	and pg.barnNbr = pg2.barnNbr 
	and pg2.pgstatusid in ('p', 'f', '') --planned(no pigs no feed), FOD active (no pigs yet)
left join [$(SolomonApp)].dbo.cft_SITE_FEED_REPRESENTATIVE fr (nolock) 
	on pg.sitecontactID = fr.solomonappsitecontactID
left join [$(SolomonApp)].dbo.cftcontact c (nolock) 
	on fr.feedrepresentativecontactID = c.contactID
 
where  pg.pgstatusID in ('a','t') --active, tentative close

group by pg.piggroupID, 
            pg.description,
            pg.pgstatusID,
            pg2.EstStartDate,
            pg.pigprodphaseID,
            pg2.pgstatusID,
            pg2.piggroupID,
            c.contactname, 
            pm.MarketSaleTypeID,
			pm.transubtypeid

having      (pm.MarketSaleTypeID in ('30') --Closeout
			or (pm.transubtypeid not in ('OW','PW','SW','IN','ON','PN','SN') and pg.pigprodphaseid = 'NUR'))
			and (max(convert(varchar,pm.movementdate,101)) between @StartDate and @EndDate) 

order by c.contactname, pg.description

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PIGGROUP_CLOSEOUTS] TO [db_sp_exec]
    AS [dbo];

