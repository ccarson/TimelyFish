Create Procedure pXF100_cftPigGroup_PigGroupR @parm1 varchar (10), @parm2 varchar (10) as 
    Select p.* from cftPigGroup p Left Join cftPigGroupRoom r on p.PigGroupId = r.PigGroupId 
	Where p.PigGroupId = @parm1 and (RoomNbr = @parm2 or RoomNbr Is Null)
	Order by p.PigGroupId

 