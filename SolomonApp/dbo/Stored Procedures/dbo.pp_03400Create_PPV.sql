 CREATE PROC pp_03400Create_PPV
	@PPV_Caption VARCHAR(30),
	@UserAddress VARCHAR(21),
	@Prog VARCHAR(8),
	@User VARCHAR(10),
	@result INT OUTPUT AS

DECLARE @BaseCuryId CHAR(4)
DECLARE @BaseCury INT
DECLARE @BatNbr CHAR(10)
DECLARE @CurrPerNbr Char(6)
DECLARE @Module CHAR(2)
DECLARE @PPVAcct CHAR(10)
DECLARE @PPVCount SmallInt
DECLARE @PPVSub CHAR(24)
DECLARE @PPVBatNbr CHAR(10)
DECLARE @PPVRefNbr CHAR(10)

DECLARE @FETCH_STATUS INT
DECLARE @RefNbr_Error INT

DECLARE @RefCount INT
DECLARE @RefNbrErr INT

-- Print 'Create PPV Started'

/***** Get Last Reference Number from Setup Record *****/
---SELECT @CurrPerNbr = CurrPerNbr
--- From APSetup (nolock)
---IF @@ERROR <> 0 GOTO ABORT

/***** Get Base Cury Id From Setup Record *****/
---SELECT @BaseCuryId = BaseCuryId
--- From GlSetup (nolock)
---IF @@ERROR <> 0 GOTO ABORT

/***** Get Currency Record for Base Cury Id *****/
---SELECT @BaseCury = DecPl
--- From Currncy C (nolock)
--- Where C.CuryId = @BaseCuryId
---IF @@ERROR <> 0 GOTO ABORT

/***** Get Last Reference Number from Setup Record *****/
SELECT @PPVAcct = DfltPPVAcct,
	@PPVSub = DfltPPVSub
From INSetup (nolock)
IF @@ERROR <> 0 GOTO ABORT

IF NULLIF(@PPVACCT,'') IS NULL
BEGIN
SELECT @PPVAcct = PPVAcct,
	@PPVSub = PPVSub
From POSetup (nolock)
IF @@ERROR <> 0 GOTO ABORT
END

IF NULLIF(@PPVACCT,'') IS NULL
BEGIN
SELECT @PPVAcct = PPVAcct,
	@PPVSub = PPVSub
From APSetup (nolock)
IF @@ERROR <> 0 GOTO ABORT
END

/***** IF No INSetup Record then Initialize Default PPVAccts *****/
IF @PPVACCT IS NULL
BEGIN
SELECT @PPVAcct = ''
SELECT @PPVSub = ''
END

/***** create aptran for PPV *****/
Insert APTran (Acct, AcctDist, AlternateID,  Applied_PPrefNbr, BatNbr, BOMLineRef, BoxNbr, Component,
	CostType, CostTypeWO, CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId,
	CuryMultDiv, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, CuryRate, CuryTaxAmt00, CuryTaxAmt01,
	CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03,
	CuryUnitPrice, DrCr, Employee, EmployeeId, Excpt, ExtRefNbr, FiscYr,
	InstallNbr, InvcTypeId, InvtID, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, LineRef, LineType, Lupd_DateTime, Lupd_Prog, Lupd_user, MasterDocNbr,
	NoteId, PC_Flag, PC_Id, PC_Status, PerEnt, PerPost, PmtMethod,
	POExtPrice, POLineRef, PONbr, POQty, POUnitPrice, PPV, ProjectId,
	Qty, QtyVar, RcptLineRef, RcptNbr, RcptQty, RefNbr, Rlsed,
	S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
	S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate, SiteId,
	SoLineRef, SOOrdNbr, SOTypeID, Sub, TaskId, TaxAmt00, TaxAmt01,
	TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01, TaxId02,
	TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType,
	TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc, UnitPrice, User1,
	User2, User3, User4, User5, User6, User7, User8,
	VendId, WONbr, WOStepNbr)
Select COALESCE(NULLIF(i.PPVAcct, ''), @PPVAcct), 1, '', '', t.BatNbr, '', '', '',
	'', '', min(d.CpnyId), GetDate(), @Prog, @User, min(D.CuryId),
	min(D.CuryMultDiv), 0,0, 0, min(D.CuryRate), 0, 0,
	0, 0, Sum((CONVERT(DEC(28,3),T.Curyppv)))* case when min(t.trantype) = 'AD' then -1 else 1 end, 0, 0, 0, 0,
	0, 'D' , '', '', 0, min(D.InvcNbr), SubString(min(D.PerPost), 1, 4),
	0, '','', 0, 'AP', '', 0,
	32767, '', 'P', GetDate(), @Prog, @User, '',
	0, '', '', '', min(D.PerEnt), min(D.PerPost), 'C',
	0,'', '', 0, 0, 0, t.ProjectID,
	min(t.qty), min(Abs(T.QtyVar)), '', '', 0, t.refnbr, 1,
	'', '', 0, 0, 0, 0, '01-01-1900',
	'01-01-1900', 0, 0, '', '', '01-01-1900', '',
	'','','',COALESCE(NULLIF(i.PPVSub, ''), @PPVSub), t.taskid, 0, 0,
	0, 0, '', '', '', '', '',
	'', '', sum((CONVERT(DEC(28,3),t.ppv)))* case when min(t.trantype) = 'AD' then -1 else 1 end, '', min(D.DocDate), min(@PPV_Caption + D.RefNbr), min(D.DocType),
	0, 0, 0, 0, '', 0, '',
	'', 0, 0, '', '', '01-01-1900', '01-01-1900',
	min(D.VendId), '', ''
From APTran t
	LEFT outer join Inventory i
		on 	i.Invtid = t.Invtid
	, WrkRelease W, APDoc D
Where t.BatNbr = W.BatNbr
	And 'AP' = W.Module
	And @UserAddress = W.UserAddress
	And t.RefNbr = D.RefNbr
	And d.Batnbr = t.batnbr
	And t.CuryPPV <> 0
	And t.s4future10 = 0 ---landed cost?
	---And T.CuryExtCostVar <> 0
group by t.batnbr, t.refnbr, t.projectid, t.taskid, i.PPVAcct, i.PPVSub

IF @@ERROR <> 0 GOTO ABORT

/***** create aptran for Accrued AP offset *****/
Insert APTran (Acct, AcctDist, AlternateID,  Applied_PPrefNbr, BatNbr, BOMLineRef, BoxNbr, Component,
	CostType, CostTypeWO, CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId,
	CuryMultDiv, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, CuryRate, CuryTaxAmt00, CuryTaxAmt01,
	CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03,
	CuryUnitPrice, DrCr, Employee, EmployeeId, Excpt, ExtRefNbr, FiscYr,
	InstallNbr, InvcTypeId, InvtID, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, LineRef, LineType, Lupd_DateTime, Lupd_Prog, Lupd_user, MasterDocNbr,
	NoteId, PC_Flag, PC_Id, PC_Status, PerEnt, PerPost, PmtMethod,
	POExtPrice, POLineRef, PONbr, POQty, POUnitPrice, PPV, ProjectId,
	Qty, QtyVar, RcptLineRef, RcptNbr, RcptQty, RefNbr, Rlsed,
	S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
	S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate, SiteId,
	SoLineRef, SOOrdNbr, SOTypeID, Sub, TaskId, TaxAmt00, TaxAmt01,
	TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01, TaxId02,
	TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType,
	TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc, UnitPrice, User1,
	User2, User3, User4, User5, User6, User7, User8,
	VendId, WONbr, WOStepNbr)
Select t.Acct, 1, '', '', t.BatNbr, '', '', '',
	'', '', min(d.CpnyId), GetDate(), @Prog, @User, min(D.CuryId),
	min(D.CuryMultDiv), 0,0, 0, min(D.CuryRate), 0, 0,
	0, 0, Sum((CONVERT(DEC(28,3),T.Curyppv* case when (t.trantype) = 'AD' then 1 else -1 end))), 0, 0, 0, 0,
	0, 'D', '', '', 0, min(D.InvcNbr), SubString(min(D.PerPost), 1, 4),
	0, '','', 0, 'AP', '', 0,
	32767, '', 'P', GetDate(), @Prog, @User, '',
	0, '', '', '', min(D.PerEnt), min(D.PerPost), 'C',
	0,'', '', 0, 0, 0, t.ProjectID,
	min(t.qty), min(Abs(T.QtyVar)), '', '', 0, t.refnbr, 1,
	'A', '', 0, 0, 0, 0, '01-01-1900',
	'01-01-1900', 0, 0, '', '', '01-01-1900', '',
	'','','', t.Sub, t.taskid, 0, 0,
	0, 0, '', '', '', '', '',
	'', '', sum((CONVERT(DEC(28,3),t.ppv *case when (t.trantype) = 'AD' then 1 else -1 end))), '', min(D.DocDate), min('Accrued AP Offset: ' + D.RefNbr), min(D.DocType),
	0, 0, 0, 0, '', 0, '',
	'', 0, 0, '', '', '01-01-1900', '01-01-1900',
	min(D.VendId), '', ''
From APTran t, WrkRelease W, APDoc D
Where t.BatNbr = W.BatNbr
	And 'AP' = W.Module
	And @UserAddress = W.UserAddress
	And t.RefNbr = D.RefNbr
	And d.Batnbr = t.batnbr
	And t.CuryPPV <> 0
	And t.s4future10 = 0 ---landed cost?
	---And T.CuryExtCostVar <> 0
group by t.batnbr, t.acct, t.sub, t.refnbr,t.trantype, t.projectid, t.taskid
IF @@ERROR <> 0 GOTO ABORT
-- Print 'Create PPV Ended'

SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0

FINISH:


