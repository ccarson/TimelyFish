--*************************************************************
--	Purpose: Find the first date of a move in
--	Author: Sue Matter
--	Date: 1/19/2005
--	Usage: Pig Group Close
--	Parms: @parm1 (Pig Group ID), @parm2 (Transaction Date)
--	       
--*************************************************************


CREATE   PROCEDURE pCF522MoveStart
		  @parm1 varchar(10),
		  @parm2 smalldatetime

	AS
	SELECT sum(t.Qty * t.InvEffect)
	from cftPGInvTran t
	Where t.Reversal<>'1' AND t.TranTypeID='MI' AND t.PigGroupID=@parm1 AND t.TranDate<=@parm2

 