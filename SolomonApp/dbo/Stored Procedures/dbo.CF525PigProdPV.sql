--*************************************************************
--	Purpose:PV for Pig Prod Phase
--		
--	Author: Charity Anderson
--	Date: 2/28/2005
--	Usage: 
--	Parms: PigProdPhaseID
--*************************************************************

CREATE  PROC dbo.CF525PigProdPV
	(@parm1 as varchar(3))
AS

Select * from cftPigProdPhase where PigProdPhaseID like @parm1 order by PigProdPhaseID

