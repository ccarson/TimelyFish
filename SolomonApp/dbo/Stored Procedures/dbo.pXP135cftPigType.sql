--*************************************************************
--	Purpose:Pig Type PV		
--	Author: Charity Anderson
--	Date: 8/4/2005
--	Usage: PigTransportRecord 
--	Parms: PigTypeID
--*************************************************************

CREATE PROC dbo.pXP135cftPigType
	(@parm1 as varchar(2))
AS
Select * from cftPigType where PigTypeID like @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135cftPigType] TO [MSDSL]
    AS [dbo];

