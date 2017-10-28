 Create Procedure SCM_10400_Setup
As

	SELECT	INSetup.ARClearingAcct, INSetup.ARClearingSub, Ledger.BalanceType, GLSetup.BaseCuryID,
		INSetup.BMICuryID, INSetup.BMIDfltRtTp, INSetup.BMIEnabled, INSetup.CPSOnOff,
		INSetup.DfltInvtAcct, INSetup.DfltInvtSub, INSetup.GLPostOpt, INSetup.INClearingAcct, INSetup.INClearingSub,
		GLSetup.LedgerID, INSetup.MatlOvhCalc, INSetup.MatlOvhOffAcct, INSetup.MatlOvhOffSub, INSetup.NegQty,
		INSetup.Pernbr, INSetup.S4Future10 As DebugMode, INSetup.UpdateGL, GLSetup.ValidateAcctSub,
		INSetup.DfltVarAcct, INSetup.DfltVarSub
		From	INSetup (NoLock), GLSetup (NoLock), Ledger (NoLock)
		Where	GLSetup.LedgerID = Ledger.LedgerID



