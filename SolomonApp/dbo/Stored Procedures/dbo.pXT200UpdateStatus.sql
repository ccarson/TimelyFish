--*************************************************************
--	Purpose:Updates specified date's schedule status
--	Author: Charity Anderson
--	Date: 3/8/2005
--	Usage: Internal Transportation
--	Parms: WeekOfDate,NewPMStatusID,User,Cpny,System,PMType
--	      
--*************************************************************

CREATE PROC dbo.pXT200UpdateStatus
	(@parm1 as smalldatetime, @parm2 as varchar(2),@parm3 as varchar(10),@parm4 as varchar(3),@parm5 as varchar(2),@parm6 as varchar(2))
	
AS
Update cftPMWeekStatus set PMStatusID=@parm2,Lupd_User=@parm3 
where WeekOfDate=@parm1 and PigSystemID=@parm5
and PMTypeID=@parm6 --and CpnyID=@parm4

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT200UpdateStatus] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT200UpdateStatus] TO [MSDSL]
    AS [dbo];

