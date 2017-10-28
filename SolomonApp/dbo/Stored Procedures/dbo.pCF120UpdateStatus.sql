--*************************************************************
--	Purpose:Updates specified date's schedule status
--	Author: Charity Anderson
--	Date: 3/8/2005
--	Usage: Internal Transportation
--	Parms: WeekOfDate,NewPMStatusID
--	      
--*************************************************************

CREATE PROC dbo.pCF120UpdateStatus
	(@parm1 as smalldatetime, @parm2 as varchar(2))
	
AS
Update cftWeekPMStatus set PMStatusID=@parm2 where WeekOfDate=@parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF120UpdateStatus] TO [MSDSL]
    AS [dbo];

