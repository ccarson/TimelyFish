--*************************************************************
--	Purpose:Inserts a record for a nonexisting weekofdate
--		and assigns the first status for the PMType
--	Author: Charity Anderson
--	Date: 3/8/2005
--	Usage: Internal Transportation
--	Parms: WeekOfDate,PigSystemID,PMTypeID,User
--	      
--*************************************************************

CREATE PROC dbo.pCF120NewWeekStatus
	(@parm1 as smalldatetime,@parm2 as varchar(2),@parm3 as varchar(2),@parm4 as varchar(10))
	
AS

Insert into cftWeekPMStatus
(CpnyID,
Crtd_DateTime,Crtd_Prog,Crtd_User,
Lupd_DateTime,Lupd_Prog,Lupd_User,
PigSystemID,PMStatusID,PMTypeID,
WeekOfDate
)
Select 
'',
getdate(),'CF12000',@parm4,
getdate(),'CF12000',@parm4,
@parm2,
PMStatusID=(Select min(PMStatusID) from cftPMStatus 
		where PMTypeID=@parm3 group by PMTypeID),
@parm3,
@parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF120NewWeekStatus] TO [MSDSL]
    AS [dbo];

