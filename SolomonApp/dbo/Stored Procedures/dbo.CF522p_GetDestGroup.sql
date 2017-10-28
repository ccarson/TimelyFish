--*************************************************************
--	Purpose: Find the destination group
--	Author: Sue Matter
--	Date: 1/19/2005
--	Usage: Pig Group Close
--	Parms: @parm1 (Source Pig Group ID)
--	       
--*************************************************************


CREATE      Procedure CF522p_GetDestGroup @parm1 varchar (10) as 
    Select pg.projectid, pg.TaskID, Sum(tr.Qty) 
    From cftPGInvTran tr
    JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
    Where tr.SourcePigGroupID=@parm1 AND tr.acct='PIG TRANSFER IN' AND tr.Reversal<>'1'
    Group by pg.projectid, pg.taskid



 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF522p_GetDestGroup] TO [MSDSL]
    AS [dbo];

