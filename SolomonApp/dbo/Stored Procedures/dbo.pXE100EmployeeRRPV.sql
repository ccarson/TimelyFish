--*************************************************************
--	Purpose:PV for EmployeeRR record 
--		
--	Author: Charity Anderson
--	Date: 7/8/2005
--	Usage: XE100 Screen
--	Parms: EmpNbr
--*************************************************************

CREATE PROC dbo.pXE100EmployeeRRPV
		(@Parm1 as varchar(4))
AS
Select * from cftEmployeeRR where EmpNbr like @parm1 order by EmpNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXE100EmployeeRRPV] TO [MSDSL]
    AS [dbo];

