CREATE  VIEW dbo.cfvSitesOnARation
AS
SELECT     MIN(InvtIdOrd) AS InvtId, fo.PigGroupId, MIN(DateSched) AS Date, c.ContactId, c.ContactName, pg.BarnNbr, fo.BinNbr, pg.EstStartDate, 
                      pg.EstStartWeight, pg.FeedPlanId
FROM         cftFeedOrder fo JOIN
                      cftPigGroup pg ON fo.PigGroupId = pg.PigGroupId JOIN
                      cftContact c ON pg.SiteContactId = c.ContactId
WHERE     fo.Status NOT IN ('C', 'X') AND pg.PGStatusID IN ('A', 'F') AND fo.DateSched =
                          (SELECT     MIN(DateSched)
                            FROM          cftFeedOrder
                            WHERE      InvtIdOrd LIKE LEFT(fo.InvtIdOrd, 3) + '%' AND Status NOT IN ('C', 'X') AND PigGroupId = fo.PigGroupId)
GROUP BY fo.PigGroupId, c.ContactId, c.ContactName, pg.BarnNbr, fo.BinNbr, pg.EstStartDate, pg.EstStartWeight, pg.FeedPlanId, LEFT(fo.InvtIdOrd, 3)
UNION
SELECT     MIN(fo.InvtIdDel), fo.PigGroupID, fo.DateDel, c.ContactId, c.ContactName, pg.BarnNbr, fo.BinNbr, pg.EstStartDate, pg.EstStartWeight, 
                      pg.FeedPlanID
FROM         cftPigGroup pg JOIN
                      cftFeedOrder fo ON pg.PigGroupId = fo.PigGroupId JOIN
                      cftContact c ON pg.SiteContactId = c.ContactId
WHERE     pg.PGStatusID IN ('A', 'F') AND pg.PigGroupId NOT IN
                          (SELECT DISTINCT PigGroupId
                            FROM          cftFeedOrder
                            WHERE      Status NOT IN ('C')) AND fo.DateDel =
                          (SELECT     MAX(DateDel)
                            FROM          cftFeedOrder
                            WHERE      PigGroupId = pg.PigGroupId)
GROUP BY fo.PigGroupId, c.ContactId, c.ContactName, pg.BarnNbr, fo.BinNbr, pg.EstStartDate, pg.EstStartWeight, pg.FeedPlanId, fo.DateDel, LEFT(fo.InvtIdOrd, 
                      3)

 

 