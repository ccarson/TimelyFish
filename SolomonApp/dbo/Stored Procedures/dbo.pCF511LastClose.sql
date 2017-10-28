CREATE   PROCEDURE pCF511LastClose
		@parm1 varchar (6),
		@parm2 varchar(6),
		@parm3 varchar(10),
		@parm4 varchar(6)
AS

Select pg.PigGroupID, Max(ActCloseDate) As PGClose
FROM cftPigGroup pg
LEFT JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID
Where pg.SiteContactID=@parm1
AND pg.BarnNbr=@parm2
AND rm.RoomNbr Like @parm3
AND pg.PigGroupID <> @parm4
Group by pg.PigGroupID



 