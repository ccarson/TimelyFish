--*************************************************************
--	Purpose:DBNav procedure for cftPigGradeCatType table
--	Author: Charity Anderson
--	Date: 7/28/2004
--	Usage: PigGradeCategoryType app
--	Parms:PigGradeCatTypeID
--*************************************************************

CREATE PROC dbo.cfpPigGradeCatType
	@parm1 as varchar(2)

AS
Select * 
From
cftPigGradeCatType
WHERE PigGradeCatTypeID like @parm1
ORDER BY PigGradeCatTypeID
