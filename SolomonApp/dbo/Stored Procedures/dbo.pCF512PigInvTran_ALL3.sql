--*************************************************************
--	Purpose:All transactions for Pig Group
--	Author: Sue Matter
--	Date: 8/19/2004
--	Usage: Pig Group Inventory Adjustment 
--	Parms: @parm1 (Batch Number), @parm2min (first line number)
--	       @parm2max (last line number)
--*************************************************************
CREATE       Procedure pCF512PigInvTran_ALL3 
	@parm1 varchar (10),
	@parm2min smallint,
	@parm2max smallint
As
Select *
From cftPGInvTran as A
LEFT JOIN cftPGInvTType B on A.TranTypeID=B.TranTypeID
LEFT JOIN cftPGInvTSub C on A.TranTypeID=C.TranTypeID AND A.TranSubTypeID=C.SubTypeID 
Where A.BatNbr=@parm1 AND A.LineNbr BETWEEN @parm2min AND @parm2max
Order By A.BatNbr, A.LineNbr 



 