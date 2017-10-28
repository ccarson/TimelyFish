--*************************************************************
--	Purpose: Calculates the Pig Group's pig days baaed
--			on the Flow Board scheduling
--	Author: Charity Anderson
--	Date:  6/30/2005
--	Usage: XTFlowBoardPigDays report
--	Parms:
--*************************************************************
CREATE VIEW dbo.vXT100FlowPigDays
AS

SELECT  pg.PigGroupID, pg.Description,
min(pm.MovementDate) as FirstEmptyDate,pg.EstStartDate,
pp.PhaseDesc as Phase,pg.PigSystemID
from cftPigGroup pg
LEFT JOIN cftPM pm on pg.PigGroupID=pm.SourcePigGroupID
LEFT JOIN cftPigProdPhase pp on pg.PigProdPhaseID=pp.PigProdPhaseID
where pg.PGStatusID in ('A','P') and pg.PigProdPhaseID in ('NUR','FIN')
Group by pg.PigGroupID, pg.Description,pg.EstStartDate,pg.PigSystemID,
pp.PhaseDesc
