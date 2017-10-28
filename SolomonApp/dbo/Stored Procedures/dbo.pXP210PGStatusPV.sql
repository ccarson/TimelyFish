--*************************************************************
--	Purpose:PV for PGStatus		
--	Author: Charity Anderson
--	Date: 2/28/2006	
--	Usage: Pig Group Date Exception 
--	Parms: @parm1 (PGStatusID)
--*************************************************************

CREATE PROC dbo.pXP210PGStatusPV
	@parm1 as varchar(1)
AS
Select * from cftPGStatus where PGStatusID like @parm1 order by PGStatusID
