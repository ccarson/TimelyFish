--*************************************************************
--	Purpose:Inserts a record for a nonexisting weekofdate
--		and assigns the first status for the PMType
--	Author: Charity Anderson
--	Date: 3/8/2005
--	Usage: Internal Transportation
--	Parms: WeekOfDate,PigSystemID,PMTypeID,User
--	      
--*************************************************************

CREATE PROC dbo.pXT200NewWeekStatus
	(@parm1 as smalldatetime,@parm2 as varchar(2),@parm3 as varchar(2)
	,@parm4 as varchar(10), @parm5 as varchar(3))
	
AS

Insert into cftPMWeekStatus
(CpnyID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PigSystemID,PMStatusID,PMTypeID,
WeekOfDate
)
Select 
@parm5,
getdate(),'XT20000',@parm4,
getdate(),'XT20000',@parm4,
@parm2,
PMStatusID=(Select min(PMStatusID) from cftPMStatus 
		where PMTypeID=@parm3 group by PMTypeID),
@parm3,
@parm1

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT200NewWeekStatus] TO [SOLOMON]
    AS [dbo];

