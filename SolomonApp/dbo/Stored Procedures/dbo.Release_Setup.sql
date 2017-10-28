 Create Procedure Release_Setup
As

	SELECT	INSetup.ARClearingAcct, INSetup.ARClearingSub, Ledger.BalanceType, GLSetup.BaseCuryID,
		BaseDecPl = COALESCE((Select DecPl From Currncy Where CuryID = GLSetup.BaseCuryID), INSetup.DecPlPrcCst),
		INSetup.BMICuryID, BMIDecPl = COALESCE((Select DecPl From Currncy Where CuryID = INSetup.BMICuryID),
			(Select DecPl From Currncy Where CuryID = GLSetup.BaseCuryID), INSetup.DecPlPrcCst),
		INSetup.BMIDfltRtTp, INSetup.BMIEnabled, INSetup.DecPlPrcCst,
		INSetup.DecPlQty, INSetup.DfltInvtAcct, INSetup.DfltInvtSub, INSetup.GLPostOpt, GLSetup.LedgerID,
		INSetup.MatlOvhCalc, INSetup.MatlOvhOffAcct, INSetup.MatlOvhOffSub, INSetup.NegQty, INSetup.Pernbr,
		INSetup.S4Future10 As TableByPass, INSetup.UpdateGL, GLSetup.ValidateAcctSub, INSetup.DfltVarAcct, INSetup.DfltVarSub
		From	INSetup, GLSetup, Ledger
		Where	GLSetup.LedgerID = Ledger.LedgerID




GO
GRANT CONTROL
    ON OBJECT::[dbo].[Release_Setup] TO [MSDSL]
    AS [dbo];

