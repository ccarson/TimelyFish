--*************************************************************
--	Purpose:DBNav procedure for cftPigProdPhase table
--	Author: Charity Anderson
--	Date: 7/28/2004
--	Usage: PigProdPhaseMaint app
--	Parms:PigProdPhaseID
--*************************************************************

CREATE  PROC dbo.cfpPigProdPhase
	@parm1 as varchar(6)

AS
Select * 
From
cftPigProdPhase
WHERE PigProdPhaseID like @parm1
ORDER BY PigProdPhaseID

