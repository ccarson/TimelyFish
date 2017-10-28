Create Procedure CF518p_cftPigGroup_CBT @parm1 varchar (6), @parm2 varchar (6), @parm3 varchar (32) as 
    Select * from cftPigGroup Where SiteContactId = @parm1 and BarnNbr = @parm2 and TaskId = @parm3
	and Exists (Select * from cftPGStatus Where cftPigGroup.PGStatusId = PGStatusId and 
	Status_PA = 'A' and Status_AR = 'A')
