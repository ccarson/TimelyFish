Create Procedure pXF100_cftPigGroup_CBPGId @parm1 varchar (10), @parm2 varchar (6), @parm3 varchar (10), @parm4 varchar (10) as 
    Select p.* from cftPigGroup p Left Join cftPigGroupRoom r on p.PigGroupId = r.PigGroupId
	Where p.SiteContactId = @parm1 and p.BarnNbr = @parm2 and p.PigGroupId Like @parm4
	and (r.RoomNbr = @parm3 or r.RoomNbr Is Null)
	and Exists (Select * from cftPGStatus Where p.PGStatusId = PGStatusId and
	Status_PA = 'A' and Status_IN = 'A')
	Order by p.PigGroupId

 