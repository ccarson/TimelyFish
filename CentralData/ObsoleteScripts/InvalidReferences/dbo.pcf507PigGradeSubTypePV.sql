--*************************************************************
--	Purpose:PV procedure for cftPigGradeSubType table
--	Author: Charity Anderson
--	Date: 7/28/2004
--	Usage: PigTransportRecord app
--	Parms:PigGradeSubTypeID
--*************************************************************

CREATE PROC dbo.pcf507PigGradeSubTypePV
	@parm1 as varchar(2)

AS
Select * From cftPigGradeSubType WHERE PigGradeSubTypeID like @parm1 ORDER BY PigGradeSubTypeID
