Create Procedure CF518p_cftPigGroup_CPigGroupId @parm1 varchar (10), @parm2 varchar (6), @parm3 varchar (10) as 
    Select pg.* from cftPigGroup pg
	LEFT JOIN cftPigGroupRoom pgr on pg.PigGroupId=pgr.PigGroupID
	Where SiteContactId = @parm1 and (pg.BarnNbr = @parm2 or pgr.RoomNbr =@parm2) 
        and pg.PigGroupId Like @parm3 and PGStatusID<>'I' and PGStatusID<>'X'
	and Exists (Select * from cftPGStatus Where pg.PGStatusId = PGStatusId and Status_PA = 'A' 
	and Status_AR = 'A')
	Order by pg.PigGroupId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF518p_cftPigGroup_CPigGroupId] TO [MSDSL]
    AS [dbo];

