

--*************************************************************
--	Purpose:Display details of transactions for a Pig Group
--	Author: Sue Matter
--	Date: 8/25/2004
--	Usage: Pig Group Maintenance 
--	Parms: @parm1 (PigGroupID)
--	 20130311 added nolock hints     
--*************************************************************


CREATE   Procedure [dbo].[pCF511GroupInv]
	@parm1 varchar(10)

as
	Select tr.*, B.*, C.* 
	From cftPGInvTran tr (nolock) 
	LEFT JOIN cftPigGroup pg (nolock) on  tr.PigGroupID=pg.PigGroupID
	LEFT JOIN cftPGInvTType B (nolock) on  tr.TranTypeID=B.TranTypeID
	LEFT JOIN cftPGInvTSub C (nolock) on   tr.TranTypeID=C.TranTypeID AND tr.TranSubTypeID=C.SubTypeID 
	WHERE tr.Reversal<>'1' AND tr.PigGroupID LIKE @parm1
	Order by tr.TranDate





 
