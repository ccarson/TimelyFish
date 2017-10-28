Create Procedure pXF100_cftPigGroup_PigGroup @parm1 varchar (10), @parm2 varchar (10) as 
    Select p.* from cftPigGroup p Left Join cftPigGroupRoom r on p.PigGroupId = r.PigGroupId 
	Where p.PigGroupId = @parm1 and (RoomNbr = @parm2 or RoomNbr Is Null)
	and Exists (Select * from cftPGStatus Where p.PGStatusId = PGStatusId and
	Status_PA = 'A' and Status_IN = 'A')
	Order by p.PigGroupId

 