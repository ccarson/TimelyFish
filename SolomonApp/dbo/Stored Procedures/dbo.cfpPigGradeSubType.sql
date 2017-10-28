--*************************************************************
--	Purpose:DBNav procedure for cftPigGradeSubType table
--	Author: Charity Anderson
--	Date: 7/28/2004
--	Usage: PigGradeSubType app
--	Parms:PigGradeSubTypeID
--*************************************************************

CREATE PROC dbo.cfpPigGradeSubType
	@parm1 as varchar(2)

AS
Select * 
From
cftPigGradeSubType
WHERE PigGradeSubTypeID like @parm1
ORDER BY PigGradeSubTypeID
