
CREATE view [dbo].[cfv_UnallocatedPGInvTrans_PG] as

	SELECT t.acct,t.BatNbr,t.LineNbr, t.Module,t.NoteID,t.PC_Stat,t.PerPost
	,t.PigGroupID,t.TranDate,t.TranSubTypeID,t.TranTypeID,
	Qty = t.Qty - IsNull((SELECT Sum(Qty) FROM cftPGInvTranAlloc WHERE 
	Module = t.Module AND BatNbr = t.BatNbr AND LineNbr = t.LineNbr),0)
	FROM cftPGInvTran t	WHERE 
	 t.Reversal = 0 -- NOT a reversal
	AND t.Rlsed = 1  -- IS released
	AND t.TranTypeID In('TI','MI','PP')
	AND t.TranDate <= (Select Min(TranDate) FROM cftPGInvTran WHERE PigGroupID = t.PigGroupID AND TranTypeID In('TI','MI','PP'))+7
	
	

