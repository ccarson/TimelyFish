
CREATE View cfv_VerifyCharge
AS
Select pg.SiteContactID, ct.SiteName, pg.PigGroupID, pg.BarnNbr, pg.Description, pg.InitialPigValue As StartValue, sc.Rate AS MoveValue, DateDiff(day, pg.ActStartDate, pg.ActCloseDate) AS DayIn, pjs.project As Project, pjs.pjt_entity As Task, pjs.acct, 
pjs.trans_date, pjs.amount, pjs.units
From cftPigGroup pg 
LEFT JOIN pjtran pjs ON pg.projectID=pjs.project AND pg.TaskID=pjs.pjt_entity
LEFT JOIN cfvSiteDetail ct ON pg.SiteContactID=ct.SiteContactID AND pg.PigGroupID=ct.PigGroupID
LEFT JOIN cftSCRate sc ON pg.PigProdPhaseID=sc.SubType AND sc.Type='PRODUCTION PHASE' AND sc.AcctCat='PIG MOVE OUT'
Where pg.CostFlag='2'

 