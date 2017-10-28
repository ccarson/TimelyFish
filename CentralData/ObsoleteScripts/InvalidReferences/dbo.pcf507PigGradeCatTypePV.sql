--*************************************************************
--	Purpose:PV procedure for cftPigGradeCatType table
--	Author: Charity Anderson
--	Date: 7/28/2004
--	Usage: PigTransportRecord app
--	Parms:PigGradeCatTypeID
--*************************************************************

CREATE PROC dbo.pcf507PigGradeCatTypePV
	@parm1 as varchar(2)

AS
Select * From cftPigGradeCatType WHERE PigGradeCatTypeID like @parm1 ORDER BY PigGradeCatTypeID
