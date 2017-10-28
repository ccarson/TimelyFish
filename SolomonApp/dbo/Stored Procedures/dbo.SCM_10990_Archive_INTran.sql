 Create	Procedure SCM_10990_Archive_INTran
As
	Set	NoCount On
	Declare	@ErrorNo	Integer
	Set	@ErrorNo = 0
	Begin	Transaction

	Insert	Into INArchTran
		(Acct, AcctDist, ARLineId, ARLineRef, BatNbr,
		BMICuryID, BMIEffDate, BMIExtCost, BMIMultDiv, BMIRate,
		BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct, CnvFact,
		COGSAcct, COGSSub, CostType, CpnyID, Crtd_DateTime,
		Crtd_Prog, Crtd_User, DrCr, Excpt, ExtCost,
		ExtRefNbr, FiscYr, ID, InsuffQty, InvtAcct,
		InvtID, InvtMult, InvtSub, JrnlType, KitID,
		KitStdQty, LayerType, LineId, LineNbr, LineRef,
		LotSerCntr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID,
		OrigBatNbr, OrigJrnlType, OrigLineRef, OrigRefNbr, OvrhdAmt,
		OvrhdFlag, PC_Flag, PC_ID, PC_Status, PerEnt,
		PerPost, PostingOption, ProjectID, Qty, QtyUnCosted,
		RcptDate, RcptNbr, ReasonCd, RecordID, RefNbr,
		Retired, Rlsed, S4Future01, S4Future02, S4Future03,
		S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12, ShortQty,
		SiteID, SlsperID, SpecificCostID, StdTotalQty, Sub,
		TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate,
		TranDesc, TranType, UnitCost, UnitDesc, UnitMultDiv,
		UnitPrice, User1, User2, User3, User4,
		User5, User6, User7, User8, UseTranCost, WhseLoc,
		FlatRateLineNbr, IRProcessed, ServiceCallID, SvcContractID, SvcLineNbr) /* New Fields in R4.51 */
	Select	Acct, AcctDist, ARLineId, ARLineRef, BatNbr,
		BMICuryID, BMIEffDate, BMIExtCost, BMIMultDiv, BMIRate,
		BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct, CnvFact,
		COGSAcct, COGSSub, CostType, CpnyID, Crtd_DateTime,
		Crtd_Prog, Crtd_User, DrCr, Excpt, ExtCost,
		ExtRefNbr, FiscYr, ID, InsuffQty, InvtAcct,
		InvtID, InvtMult, InvtSub, JrnlType, KitID,
		KitStdQty, LayerType, LineId, LineNbr, LineRef,
		LotSerCntr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID,
		OrigBatNbr, OrigJrnlType, OrigLineRef, OrigRefNbr, OvrhdAmt,
		OvrhdFlag, PC_Flag, PC_ID, PC_Status, PerEnt,
		PerPost, PostingOption, ProjectID, Qty, QtyUnCosted,
		RcptDate, RcptNbr, ReasonCd, RecordID, RefNbr,
		Retired, Rlsed, S4Future01, S4Future02, S4Future03,
		S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12, ShortQty,
		SiteID, SlsperID, SpecificCostID, StdTotalQty, Sub,
		TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate,
		TranDesc, TranType, UnitCost, UnitDesc, UnitMultDiv,
		UnitPrice, User1, User2, User3, User4,
		User5, User6, User7, User8, UseTranCost, WhseLoc,
		FlatRateLineNbr, IRProcessed, ServiceCallID, SvcContractID, SvcLineNbr	/* New Fields in R4.51 */
		From	INTran
		Where	S4Future05 = 1
	Set	@ErrorNo = @@Error
	If	(@ErrorNo = 0)
		Commit Transaction
	Else
		Rollback Transaction



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10990_Archive_INTran] TO [MSDSL]
    AS [dbo];

