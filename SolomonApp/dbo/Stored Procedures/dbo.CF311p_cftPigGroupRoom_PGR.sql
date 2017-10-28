CREATE  Procedure CF311p_cftPigGroupRoom_PGR @parm1 varchar (4), @parm2 varchar (10), @parm3 varchar (10) as 
    Select * from cftPigGroupRoom Where FeedPlanId = @parm1 and PigGroupId = @parm2 and RoomNbr Like @parm3
	Order by FeedPlanId, PigGroupId, RoomNbr

 

 