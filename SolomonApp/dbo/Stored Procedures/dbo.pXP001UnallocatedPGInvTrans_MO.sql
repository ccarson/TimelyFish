

--*************************************************************
--	Purpose: Find unallocated charges for this group- Move outs
--	Author: Sue Matter
--	Date: 1/19/2005
--	Usage: Pig Group Calculator
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


CREATE   PROC pXP001UnallocatedPGInvTrans_MO
	@PigGroupID varchar(10)
	AS
	SELECT t.acct,t.BatNbr,t.CF01,t.CF02,t.CF03,t.CF04,t.CF05,t.CF06,
	t.CF07,t.CF08,t.CF09,t.CF10,t.CF11,t.CF12,
	t.Crtd_DateTime,t.Crtd_Prog,t.Crtd_User,IndWgt,t.InvEffect,t.LineNbr,	t.LUpd_DateTime,t.LUpd_Prog,t.LUpd_User,t.Module,t.NoteID,t.PC_Stat,t.PerPost,t.PigGroupID,
	t.ProjChgBatch,t.ProjChgLine,	Qty = t.Qty - IsNull((SELECT Sum(Qty) FROM cftPGInvTranAlloc 
					WHERE MoveOutModule = t.Module AND MoveOutBatNbr = t.BatNbr 
					AND MoveOutLineNbr = t.LineNbr),0),
	t.Reversal,t.Rlsed,t.SourceBatNbr,t.SourceLineNbr,t.SourcePigGroupID,t.SourceProg,t.SourceProject,	t.SourceRefNbr,t.TotalWgt,t.TranDate,t.TranSubTypeID,t.TranTypeID

	FROM cftPGInvTran t  -- Move Out Transactions
	WHERE 
	t.PigGroupID = @PigGroupID
	AND t.Reversal = 0 -- NOT a reversal
	AND t.Rlsed = 1  -- IS released
--	AND ta.PigGroupID IS NULL  --Filter out lines previously allocated
	AND t.TranTypeID='MO'
--	AND t.TranDate <= (Select Min(TranDate) FROM cftPGInvTran WHERE PigGroupID = t.PigGroupID AND t.TranTypeID In('TI','MI'))+7
	ORDER BY TranDate

 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP001UnallocatedPGInvTrans_MO] TO [MSDSL]
    AS [dbo];

