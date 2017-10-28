--*************************************************************
--	Purpose:DBNav procedure for cftPGStatus table
--	Author: Charity Anderson
--	Date: 8/9/2004
--	Usage: Pig Group Status Maint0 app
--	Parms:PGStatus ID
--*************************************************************

CREATE PROC dbo.cfpPGStatus
	@parm1 as varchar(6)

AS
Select * 
From
cftPGStatus
WHERE PGStatusID like @parm1
ORDER BY PGStatusID
