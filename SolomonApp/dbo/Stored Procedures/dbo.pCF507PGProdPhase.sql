
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
--*************************************************************
--	Purpose:Look up for PigGroup production phase
--	Author: Charity Anderson
--	Date: 1/10/2005
--	Usage: PigTransportRecord app 
--	Parms:Project,TaskID
--*************************************************************

CREATE  PROC dbo.pCF507PGProdPhase
	@parm1 as varchar(16), @parm2 as varchar(32)
AS
Select pp.* from cftPigProdPhase pp
JOIN cftPigGroup pg on pg.PigProdPhaseID=pp.PigProdPhaseID
where pg.ProjectId=@parm1 and pg.TaskID=@parm2


 