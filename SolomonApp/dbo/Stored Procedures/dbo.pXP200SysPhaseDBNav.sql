
--*************************************************************
--	Purpose:DBNav for Pig System Production Phases
--		and phase definition
--	Author: Charity Anderson
--	Date: 2/24/2005
--	Usage: 
--	Parms: PigSystemID,PigProdPhaseID
--*************************************************************

CREATE   PROC dbo.pXP200SysPhaseDBNav
	(@parm1 as varchar(2), @parm2 as varchar(3))
AS
Select * from cftPigPhaseSys s
	JOIN cftPigProdPhase ps on s.PigProdPhaseID=ps.PigProdPhaseID
	where s.PigSystemID=@parm1 and s.PigProdPhaseID like @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP200SysPhaseDBNav] TO [MSDSL]
    AS [dbo];

