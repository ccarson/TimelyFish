CREATE  Procedure pXF135_FeedPlanInd_FPPR @parm1 varchar (4), @parm2 varchar (10), @parm3 varchar (10) as 
    Select * from cftFeedPlanInd Where FeedPlanId = @parm1 and PigGroupId = @parm2 
	and (RoomNbr = @parm3 or RoomNbr = '') Order by FeedPlanId, PigGroupId, RoomNbr, Stage


--****************************************************************
--	Purpose:Get feed plan stage
--	Author: Sue Matter
--	Date: 8/8/2005
--	Program Usage: XF135
--	Parms: plan id, group, room 
--****************************************************************
if exists (select * from sysobjects where id = object_id('dbo.pXF135_cftFeedOrder_CalcQty') and sysstat & 0xf = 4)
	DROP    Proc pXF135_cftFeedOrder_CalcQty

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF135_FeedPlanInd_FPPR] TO [MSDSL]
    AS [dbo];

