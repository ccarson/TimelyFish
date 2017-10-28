
CREATE  Procedure pCFCheckGroupStatus

as 
    Select pg.SiteContactID, pg.BarnNbr, pg.PigGroupID, pg2.PigGroupID, pg.RoomNbr,pg.PGStatusID 
	from cfvPigGroupRoom pg
	JOIN cfvPigGroupRoom pg2 ON pg.SiteCOntactID=pg2.SiteContactID AND pg.BarnNbr=pg2.BarnNbr AND pg.RoomNbr=pg2.RoomNbr
	Where pg.PigGroupID<>pg2.PigGroupID AND pg.PGStatusID=pg2.PGStatusID AND pg.PGStatusID <> 'T' 


