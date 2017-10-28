--*************************************************************
--	Purpose:DBNav procedure for cftPigProdPhase table
--	Author: Charity Anderson
--	Date: 7/28/2004
--	Usage: PigProdPhaseMaint app
--	Parms:PigProdPhaseID
--*************************************************************

CREATE  PROC dbo.cfpPMGraderType
	@parm1 as varchar(6)

AS
Select * 
From
cftPMGraderType
WHERE PMGraderTypeID like @parm1
ORDER BY PMGraderTypeID

