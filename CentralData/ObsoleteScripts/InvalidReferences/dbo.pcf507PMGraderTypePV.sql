--*************************************************************
--	Purpose:PV procedure for cftPMGraderType table
--	Author: Charity Anderson
--	Date: 8/8/2004
--	Usage: PigTransportRecord app
--	Parms:PMGraderTypeID
--*************************************************************
Create Procedure  dbo.pcf507PMGraderTypePV
	@parm1 varchar (3)

As
Select * From cftPMGraderType WHERE PMGraderTypeID like @parm1 ORDER BY PMGraderTypeID
