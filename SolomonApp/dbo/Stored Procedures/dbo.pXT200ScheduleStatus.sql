--*************************************************************
--	Purpose:Returns the Schedule Status for the specified week
--	Author: Charity Anderson
--	Date: 3/8/2005
--	Usage: Internal Transportation
--	Parms: WeekOFDate,PigSystem,PMTYpeID,CpnyID
--	      
--*************************************************************

CREATE PROC dbo.pXT200ScheduleStatus
	(@parm1 as smalldatetime,@parm2 as varchar(2)
	,@parm3 as varchar(2), @parm4 as varchar(3))
	
AS
Select * from cftPMWeekStatus WITH (NOLOCK)  where 
WeekOfDate=@parm1 
and (PigSystemID  = @parm2) 
and PMTypeID=@parm3
--and CpnyID=@parm4

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT200ScheduleStatus] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT200ScheduleStatus] TO [MSDSL]
    AS [dbo];

