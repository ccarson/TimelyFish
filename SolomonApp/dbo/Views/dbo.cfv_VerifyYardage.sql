/****** Object:  View dbo.cfv_VerifyYardage    Script Date: 4/12/2005 12:13:48 PM ******/


CREATE  View cfv_VerifyYardage (SiteContactID, SiteName, PigGroupID, BarnNbr, RoomNbr, GrpDesc, Capacity, DayIn, Rate, Project, Task, Acct, Dollars, Units)
AS

Select pg.SiteContactID, ct.SiteName, pg.PigGroupID, pg.BarnNbr, pgr.RoomNbr, 
pg.Description, cp.Capacity, DateDiff(day, pg.ActStartDate, pg.ActCloseDate) As DaysIn, sc.Rate,
pjs.project, pjs.pjt_entity, pjs.acct, sum(pjs.amount), sum(pjs.units)
From cftPigGroup pg 
LEFT JOIN cfv_PigGroup_Capacity cp ON pg.PigGroupID=cp.PigGroupID
LEFT JOIN pjtran pjs ON pg.projectID=pjs.project AND pg.TaskID=pjs.pjt_entity
LEFT JOIN cfvSiteDetail ct ON pg.SiteContactID=ct.SiteContactID AND pg.PigGroupID=ct.PigGroupID
LEFT JOIN cftSCRate sc ON pg.SiteContactID=sc.SubType AND sc.Type='SITE YARDAGE' AND sc.AcctCat='PIG SITE CHG'
LEFT JOIN cftPigGroupRoom pgr ON pg.PigGroupID=pgr.PigGroupID
Where pg.CostFlag='2' AND pjs.acct='PIG SITE CHG'
Group by pg.SiteContactID, ct.SiteName, pg.PigGroupID, pg.BarnNbr, pgr.RoomNbr, pg.Description, cp.Capacity, pg.ActStartDate, pg.ActCloseDate, sc.Rate, pjs.project, pjs.pjt_entity, pjs.acct





 