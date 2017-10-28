--*************************************************************
--	Purpose:DBNav for Pig Transaction Production System	
--		and phase definition
--	Author: Charity Anderson
--	Date: 2/24/2005
--	Usage: 
--	Parms: TranTypeID,PigSystemID
--*************************************************************

CREATE  PROC dbo.CF525TranSysDBNav
	(@parm1 as varchar(2), @parm2 as varchar(2))
AS
Select * from cftPigTranSys s
	JOIN cftPigProdPhase ps on s.SrcProdPhaseID=ps.PigProdPhaseID
	JOIN cftPigProdPhase pd on s.DestProdPhaseID=pd.PigProdPhaseID
	where s.TranTypeID=@parm1 and s.PigSystemID like @parm2

