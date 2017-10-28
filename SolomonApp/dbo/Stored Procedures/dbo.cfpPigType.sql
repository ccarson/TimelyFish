--*************************************************************
--	Purpose:DBNav procedure for cftPigType table
--	Author: Charity Anderson
--	Date: 7/30/2004
--	Usage: Pig Type Maint app
--	Parms:PigTypeID
--*************************************************************

CREATE PROC dbo.cfpPigType
	@parm1 as varchar(6)

AS
Select * 
From
cftPigType
WHERE PigTypeID like @parm1
ORDER BY PigTypeID
