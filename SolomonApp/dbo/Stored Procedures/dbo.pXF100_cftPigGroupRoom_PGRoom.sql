Create Procedure pXF100_cftPigGroupRoom_PGRoom @parm1 varchar (10), @parm2 varchar (10) as 
    Select * from cftPigGroupRoom Where PigGroupId = @parm1 and RoomNbr = @parm2
	Order by PigGroupId, RoomNbr

 