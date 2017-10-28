--*************************************************************
--	Purpose:Returns the Schedule Status for the specified ID
--	Author: Charity Anderson
--	Date: 3/8/2005
--	Usage: Internal Transportation
--	Parms: PMTypeID,PMStatusID
--	      
--*************************************************************

CREATE PROC dbo.pXT200ScheduleStatusName
	(@parm2 as varchar(2),@parm3 as varchar(2))
	
AS
Select * from cftPMStatus WITH (NOLOCK)  where 
PMTypeID=@parm2
and PMStatusID like @parm3

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT200ScheduleStatusName] TO [SOLOMON]
    AS [dbo];

