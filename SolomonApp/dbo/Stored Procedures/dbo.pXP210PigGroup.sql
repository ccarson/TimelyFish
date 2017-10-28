
--*************************************************************
--	Purpose:Selects PigGroups with specific est. Close Date
--	Author: Charity Anderson
--	Date: 1/25/2005
--	Usage: PGException 
--	Parms: @parm1 (Option)
--	       @parm2 (StartDate)
--	       @parm3 (EndDate)
--	       @parm4 (PigGroupID)
--*************************************************************

CREATE PROC dbo.pXP210PigGroup
	@parm1 as smallint,
	@parm2 as smalldatetime,
	@parm3 as smalldatetime,
	@parm4 as varchar(10)

AS

Select * from cftPigGroup 
where ((EstCloseDate between @parm2 and @parm3 and @parm1=0)
or (EstStartDate between @parm2 and @parm3 and @parm1=1))
and PGStatusID<>'I'
and PigGroupID like @parm4


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP210PigGroup] TO [MSDSL]
    AS [dbo];

