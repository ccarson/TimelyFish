/****** Object:  View dbo.cfvPigGroupRoom    Script Date: 12/8/2004 8:30:00 PM ******/


CREATE         View cfvPigGroupRoom
AS
Select pg.SiteContactID, pg.BarnNbr, pg.PigGroupID, pg.PGStatusID, rm.RoomNbr
  From cftPigGroup pg
  JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID




 