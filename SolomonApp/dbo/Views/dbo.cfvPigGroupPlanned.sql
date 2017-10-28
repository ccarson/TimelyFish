
/****** Object:  View dbo.cfvPigGroupPlanned    Script Date: 12/8/2004 8:29:56 PM ******/

/****** Object:  View dbo.cfvPigGroupPlanned    Script Date: 11/5/2004 1:51:24 PM ******/

/****** Object:  View dbo.cfvPigGroupPlanned    Script Date: 11/5/2004 1:44:46 PM ******/

CREATE    VIEW [dbo].[cfvPigGroupPlanned] (Company, PigGroupID, EstStartDate, Crtd_Datetime, Task, ContactID, GroupGender, Room)
	AS
	SELECT pj.pe_id05, pg.PigGroupID, pg.EstStartDate, pg.Crtd_DateTime, pj.pjt_entity_desc, pg.SiteContactID, pgen.Description, prm.RoomNbr
 		from cftPigGroup pg (NOLOCK)
		JOIN pjpent pj (NOLOCK) ON pg.TaskID=pj.pjt_entity
		LEFT JOIN cftPigGenderType pgen (NOLOCK) ON pg.PigGenderTypeID=pgen.PigGenderTypeID
		Left JOIN cftPigGroupRoom prm (NOLOCK) ON pg.PigGroupID=prm.PigGroupID
		WHERE pg.PGStatusID='P'








 
