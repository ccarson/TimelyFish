/****** Object:  Stored Procedure dbo.pCF511OtherGroups    Script Date: 1/21/2005 9:12:10 AM ******/

CREATE    PROCEDURE pCF511OtherGroups
		@parm1 varchar (6),
		@parm2 varchar(6),
		@parm3 varchar(10),
		@parm4 varchar(6),
		@parm5 varchar(2)
AS

Select pg.*
FROM cftPigGroup pg
LEFT JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID
Where pg.SiteContactID=@parm1
AND pg.BarnNbr=@parm2
AND pg.PGStatusID=@parm5 AND pg.PGStatusID<>'I'
AND pg.PigGroupID <> @parm4
AND (rm.RoomNbr = @parm3 or rm.RoomNbr IS NULL)




 