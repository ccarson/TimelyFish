--*************************************************************
--	Purpose:Retrieve next Pig Group Status record
--	Author: Charity Anderson
--	Date: 10/6/2004
--	Usage: Pig Group Batch Release 
--	Parms: PGStatusID
--*************************************************************

CREATE PROC dbo.pXP135GetNextPGStatus
	@parm1 as varchar(2)
AS
Select * from cftPGStatus
where Precedence=(Select Precedence+1 from cftPGStatus where PGStatusID=@parm1)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135GetNextPGStatus] TO [MSDSL]
    AS [dbo];

