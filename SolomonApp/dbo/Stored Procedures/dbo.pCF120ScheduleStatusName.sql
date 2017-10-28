--*************************************************************
--	Purpose:Returns the Schedule Status for the specified ID
--	Author: Charity Anderson
--	Date: 3/8/2005
--	Usage: Internal Transportation
--	Parms: PMTypeID,PMStatusID
--	      
--*************************************************************

CREATE PROC dbo.pCF120ScheduleStatusName
	(@parm2 as varchar(2),@parm3 as varchar(2))
	
AS
Select * from cftPMStatus where 
PMTypeID=@parm2
and PMStatusID like @parm3
