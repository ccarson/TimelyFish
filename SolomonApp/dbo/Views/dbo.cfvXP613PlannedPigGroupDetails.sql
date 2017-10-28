



/****** Object:  View dbo.cfvXP613PlannedPigGroupDetails    Script Date: 12/21/2012 7:44:57 PM ******/

CREATE    VIEW [dbo].[cfvXP613PlannedPigGroupDetails] 
--(ContactID, PigGroupID, Room, [Est Start], [Site/Barn/Room], Phase, [Est Start Wt], [Est Inv], [Feed Rep], [PFOS Site], [Est Inv])
 --     AS
 --     WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
      AS
      SELECT 
             pgp.ContactID
            ,pgp.PigGroupID
            ,pgp.Room
            ,CONVERT(varchar(10),pgp.EstStartDate,110) as 'Est Start'
            ,pgp.Task as 'Site/Barn/Room'
            ,pg.PigProdPhaseID as 'Phase'
            ,CASE when pg.PigSystemID = '00' then 'C' else 'M' end as 'Pig Sys'
            ,pg.EstStartWeight as 'Est Start Wt'
            ,pg.EstInventory as 'Est Inv'
            ,c.ContactName as 'Feed Rep'
            ,CASE when pfs.ContactID is null then 'N' else 'Y' end as 'PFOS Site'
            ,pfs.Expire_dateTime as 'Site Expired Date'
            ,pfs.ContactID as 'Pfos Contact ID'
            FROM SolomonApp.dbo.cfvPigGroupPlanned pgp 
            INNER JOIN SolomonApp.dbo.cftPigGroup pg(NOLOCK) ON pgp.PigGroupID = pg.PigGroupID
            INNER JOIN SolomonApp.dbo.cft_SITE_FEED_REPRESENTATIVE fr(NOLOCK) ON pgp.ContactID = fr.SolomonAppSiteContactID 
            INNER JOIN SolomonApp.dbo.cftContact c(NOLOCK) ON FeedRepresentativeContactID=c.ContactID
            INNER JOIN SolomonApp.dbo.cftPigSystem ps(NOLOCK) on pg.PigSystemID = ps.PigSystemID
            LEFT OUTER JOIN CentralData.dbo.cftPfosSite pfs(NOLOCK) on pgp.ContactID = pfs.ContactID and pfs.Expire_dateTime is null




