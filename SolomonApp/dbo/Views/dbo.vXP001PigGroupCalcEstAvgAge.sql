
--*************************************************************
--	Purpose: Pig Group Age Calculation
--	Author: Sue Matter
--	Date: 5/1/2005
--	Usage: XP001
--	Parms: @parm1 (CalcAvgAge), @parm2 (Pig GroupID)
--	2013-01-31 sripley  added convert(bigint to resolve a data quality issue       
--*************************************************************


CREATE VIEW [dbo].[vXP001PigGroupCalcEstAvgAge] (CalcAvgAge,PigGroupID,tstamp)
	AS
	SELECT AvgAge = Convert(float,SUM(convert(bigint,Qty * datediff(day,Trandate, DestMovementDate))) / Sum(Qty)),DestPigGroupID,
--	SELECT AvgAge = Convert(float,SUM((Qty * datediff(day,Trandate, DestMovementDate))) / Sum(Qty)),DestPigGroupID, 
	min(tstamp)
	FROM cftPGInvTranAlloc	
	WHERE DestPigGroupID Not In('','N/A')
	GROUP BY DestPigGroupID

 
