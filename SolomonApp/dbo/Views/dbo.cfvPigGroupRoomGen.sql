/****** Object:  View dbo.cfvPigGroupRoomGen    Script Date: 12/8/2004 8:30:06 PM ******/

/****** Object:  View dbo.cfvPigGroupRoom    Script Date: 11/19/2004 1:59:22 PM ******/


CREATE  View cfvPigGroupRoomGen
AS
Select pg.SiteContactID, pg.BarnNbr, pg.PigGroupID, pg.PGStatusID, rm.RoomNbr, pn.Description
  From cftPigGroup pg
  JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID
  LEFT JOIN cftPigGenderType pn ON rm.PigGenderTypeID=pn.PigGenderTypeID








 