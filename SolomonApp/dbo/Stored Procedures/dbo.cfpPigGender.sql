--*************************************************************
--	Purpose:DBNav procedure for cftPigGenderType table
--	Author: Charity Anderson
--	Date: 7/28/2004
--	Usage: PigGenderMaint app
--	Parms:PigGenderTypeID
--*************************************************************

CREATE PROC dbo.cfpPigGender
	@parm1 as varchar(6)

AS
Select * 
From
cftPigGenderType
WHERE PigGenderTypeID like @parm1
ORDER BY PigGenderTypeID
