CREATE     PROCEDURE pCF511OtherGroupDate
		@parm1 varchar (6),	--site
		@parm2 varchar(6),  --barn
		@parm3 varchar(10), --room
		@parm4 varchar(6),  --pig group
		@parm5 smalldatetime,--startdate
		@parm6 smalldatetime --end date
AS

Select pg.*
FROM cftPigGroup pg
LEFT JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID
Where pg.SiteContactID=@parm1
AND pg.BarnNbr=@parm2
AND pg.PGStatusID<>'X'
AND pg.PigGroupID <> @parm4
AND (rm.RoomNbr = @parm3 or rm.RoomNbr IS NULL)
AND pg.EstStartDate between @parm5 and @parm6



 