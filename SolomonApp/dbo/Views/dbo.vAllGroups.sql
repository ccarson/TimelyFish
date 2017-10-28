CREATE VIEW vAllGroups
AS
select pg.PigGroupID, pg.SiteContactID, c.ContactName, pg.BarnNbr, RoomNbr = IsNull(Min(pgr.RoomNbr),''),
	EstStartDate, EstCloseDate
	from cftPigGroup pg
	LEFT JOIN cftPigGroupRoom pgr ON pg.PigGroupID = pgr.PigGroupID
	JOIN cftContact c ON pg.SiteContactID = c.ContactID
	GROUP BY pg.PigGroupID, pg.SiteContactID, c.ContactName, pg.BarnNbr, EstStartDate, EstCloseDate




 