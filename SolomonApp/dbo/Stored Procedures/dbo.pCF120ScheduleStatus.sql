--*************************************************************
--	Purpose:Returns the Schedule Status for the specified week
--	Author: Charity Anderson
--	Date: 3/8/2005
--	Usage: Internal Transportation
--	Parms: WeekOFDate,PigSystem,PMTYpeID
--	      
--*************************************************************

CREATE PROC dbo.pCF120ScheduleStatus
	(@parm1 as smalldatetime,@parm2 as varchar(2),@parm3 as varchar(2))
	
AS
Select * from cftWeekPMStatus where 
WeekOfDate=@parm1 
and PigSystemID=@parm2 
and PMTypeID=@parm3
