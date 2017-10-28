
Create Procedure CF300p_cftPigGroup_CBRCnt @parm1 varchar (10), @parm2 varchar (6), @parm3 varchar (10) as 
    Select Count(*) from cftPigGroup p Left Join cftPigGroupRoom r on p.PigGroupId = r.PigGroupId 
	Where SiteContactId = @parm1 and BarnNbr = @parm2 and (RoomNbr = @parm3 or RoomNbr Is Null)
	and Exists (Select * from cftPGStatus Where p.PGStatusId = PGStatusId and
	Status_PA = 'A' and Status_IN = 'A')

 