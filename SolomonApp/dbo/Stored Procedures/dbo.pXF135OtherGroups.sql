Create Procedure pXF135OtherGroups
		@parm1 varchar (6),
		@parm2 varchar(6),
		@parm3 varchar(10),
		@parm4 varchar(6)

AS

Select pg.*
FROM cftPigGroup pg
LEFT JOIN cftPigGroupRoom rm ON pg.PigGroupID=rm.PigGroupID
Where pg.SiteContactID=@parm1
AND pg.BarnNbr=@parm2
AND pg.PGStatusID IN ('F','A','T') 
AND pg.PigGroupID <> @parm4
AND (rm.RoomNbr = @parm3 or rm.RoomNbr IS NULL)




 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF135OtherGroups] TO [MSDSL]
    AS [dbo];

