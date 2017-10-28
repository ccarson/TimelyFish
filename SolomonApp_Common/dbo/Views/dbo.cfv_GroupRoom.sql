/****** Object:  View dbo.cfv_GroupRoom    Script Date: 12/8/2004 8:26:22 PM ******/


/****** Object:  View dbo.cfvPigGroupRoom    Script Date: 11/16/2004 3:40:01 PM ******/


CREATE   View cfv_GroupRoom
AS
Select pg.SiteContactID, pg.BarnNbr, pg.PigGroupID, pg.PGStatusID, rm.RoomNbr, rm.PigGenderTypeID
  From cftPigGroup pg
  JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID








 