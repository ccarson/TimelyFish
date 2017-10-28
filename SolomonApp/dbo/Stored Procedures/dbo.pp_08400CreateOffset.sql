 CREATE PROCEDURE pp_08400CreateOffset @UserAddress VARCHAR(21), @Sol_User VARCHAR(10),
                                      @EditScrnNbr VARCHAR(5),  @CRResult INT OUTPUT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

/***** 08400 AR Release Create Offset Entries *****/

DECLARE @Debug INT
SELECT @Debug = CASE WHEN @UserAddress = 'ARDebug' THEN 1
                     ELSE 0
                END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-100:  Declarations and variables are set'

  END

DECLARE @TranDescDflt CHAR(1), @PerNbr CHAR(6), @DecPl Int
DECLARE @Acct CHAR(10)
DECLARE @Sub CHAR(24)
DECLARE @ChkAcct CHAR(10), @ChkSub CHAR(24), @DiscAcct CHAR(10), @DiscSub CHAR(24)
DECLARE @PPAcct CHAR(10), @PPSub CHAR(24)
DECLARE @DfltNSFAcct Char(10), @DfltNSFSub Char(24)
DECLARE @DfltSBWOAcct Char(10), @DfltSBWOSub Char(24)
DECLARE @DfltSCWOAcct Char(10), @DfltSCWOSub Char(24)
DECLARE @ProgID char (8)
Declare @CurrPerNbr Char (6), @Result INT
 DECLARE @AdjdTranDescDflt CHAR(1), @AdjdAcct CHAR(10), @AdjdSub CHAR(24)

SELECT @TranDescDflt = TranDescDflt, @Acct =ArAcct, @Sub = ARSub, @ChkAcct =ChkAcct,@ChkSub=ChkSub,
	 @DiscAcct = DiscAcct, @DiscSub = DiscSub,@PPAcct =PrePayAcct,@PPSub = PrePaySub,
       @PerNbr =PerNbr, @DfltNSFAcct = DfltNSFAcct,@DfltNSFSub = DfltNSFSub,	@DfltSBWOAcct= dfltSBWOAcct,
       @DfltSCWOAcct = dfltSCWOAcct ,@DfltSBWOSub= DfltSBWOSub,@DfltSCWOSub=	DfltSCWOSub,
	@AdjdAcct = ARAcct, @AdjdSub = ARSub , @AdjdTranDescDflt=  TranDescDflt, @CurrPerNbr = CurrPerNbr
 from ARSetup (nolock)

SELECT @DecPl = c.DecPl,
       @ProgID = '08400'
          FROM GLSetup s (nolock), Currncy c (nolock) WHERE s.BaseCuryID = c.CuryID

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-200:  Offset for 08010'

  END

/***** Offsetting AR Entry - 08010 *****/
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificCostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT d.BankAcct , 1, b.BatNbr, 0, 0, ' ', '', d.CpnyID, GETDATE(), @ProgID, d.Crtd_User, 0,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, d.CuryOrigDocAmt, 0, 0, 0, 0, 0, d.CustID,
	CASE WHEN d.DocType IN ('DM','IN','CS','NC', 'AD') THEN 'D' ELSE 'C' END, 0, 0, RIGHT(RTRIM(d.CustOrdNbr),15), SUBSTRING(b.PerPost,1,4), 0,
	0, '', 0, CASE WHEN b.EditScrnNbr <> '05610' THEN 'AR' ELSE 'OI' END, 0, 32767, '', GETDATE(), @ProgID, d.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, d.RefNbr, 1, '', '', 0, 0, 0, 0, '', '',0, 0, '', '', ' ', 0, '', '', '', '', '',
	'', '', d.BankSub, '', 0, 0, 0, 0, '', '', '', '', '', '','',
	d.OrigDocAmt, 'N', d.DocDate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
        WHEN 'N' THEN
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	ELSE d.DocDesc
	END), 1, 30), d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '01'
  FROM Batch b, ARDoc d, Customer c, WrkRelease w
 WHERE d.CustID = c.CustID AND b.BatNbr = w.BatNbr AND  w.BatNbr = d.BatNbr
   AND w.Module = 'AR' AND b.module = 'AR' and
	w.UserAddress = @UserAddress AND (b.EditScrnNbr = '08010' OR b.EditScrnNbr = '05610')
IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '01', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '01'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-300:  Debit cash for payments coming from 08030'

  END

/***** Debit Cash for Credit Memo/Payment/PrePayment *****/
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT d.BankAcct, 1, b.BatNbr, 0, 0, ' ', '', d.CpnyID, GETDATE(), @ProgID, d.Crtd_User, 0,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, d.CuryOrigDocAmt, 0, 0, 0, 0, 0, d.CustID,
	'D', 0, 0, RIGHT(RTRIM(d.CustOrdNbr),15), SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(),  @ProgID, d.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, d.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '', d.BankSub, '', 0, 0, 0, 0, '', '', '', '', '', '', '', d.OrigDocAmt, '', d.DocDate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
        WHEN 'N' THEN
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	ELSE d.DocDesc
	END), 1, 30), d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '*02'
FROM Batch b, ARDoc d, Customer c (nolock), WrkRelease w (nolock)
WHERE w.useraddress = @useraddress and b.module = 'AR' and b.batnbr = w.batnbr and w.module = 'AR' and
d.batnbr = b.batnbr and d.custid = c.custid AND d.DocType IN ('CM', 'PA', 'PP')
and b.editscrnnbr = '08030'

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '*02', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '*02'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-400:  Debit for SB/SC types'

  END

/***** Debit for Small Balance Write Off *****/
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT 	t.acct, 1, b.BatNbr, 0, 0, ' ', '', t.CpnyID, GETDATE(), @ProgID, b.Crtd_User, 0,
	b.CuryId, b.CuryMultDiv, b.CuryRate, 0, 0, 0, 0, t.CuryTranAmt, 0, 0, 0, 0, 0, t.CustID,
	Case when t.trantype = 'SC' then 'C' else 'D' end, 0, 0, '', SUBSTRING(b.PerPost,1,4), 0,
	0, '', 0, 'AR', 0, 32767, '', GETDATE(), @ProgID, b.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, t.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '', t.Sub, '', 0, 0, 0, 0, '', '', '', '', '', '', '', t.TranAmt, '', t.trandate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(t.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	WHEN 'I' THEN RTRIM(t.CustID)
        WHEN 'N' THEN
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	ELSE ''
	END), 1, 30), t.trantype, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '03'
  FROM Batch b (nolock), Customer c (nolock), WrkRelease w (nolock), ARTran t
 WHERE t.CustID = c.CustID AND b.BatNbr = w.BatNbr AND w.Module = 'AR' AND
	b.Module = 'AR' AND b.batnbr = t.BatNbr AND w.UserAddress = @UserAddress AND b.EditScrnNbr in ('08030', '08450') AND
	t.TranType IN ('SB', 'SC') AND t.DrCr = 'U'

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '03', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '03'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-500:  Credit for SB/SC types'

  END

/***** Credit AR for Small Balance Write Off *****/
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,

	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT 	CASE WHEN t.trantype = 'SC'
             THEN CASE WHEN t.costtype = 'PP'
                        THEN c.PrePayAcct
                        ELSE c.ARAcct
                   END
             ELSE t.s4future01
        END, 1, b.BatNbr, 0, 0, ' ', '', t.CpnyID,
	GETDATE(), @ProgID, b.Crtd_User, 0, b.CuryId, b.CuryMultDiv, b.CuryRate, 0, 0, 0, 0, t.CuryTranAmt,
	0, 0, 0, 0, 0, t.CustID, Case when t.trantype = 'SC' then 'D' else 'C' end, 0, 0, '', SUBSTRING(b.PerPost,1,4), 0,
	0, '', 0, 'AR', 0, 32767, '', GETDATE(),  @ProgID, b.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, t.RefNbr, 1, 'SBC', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '',
        CASE WHEN t.trantype = 'SC'
             THEN CASE WHEN t.costtype = 'PP'
                        THEN c.PrePaySub
                        ELSE c.ARSub
                  END
             ELSE t.s4future02 END,
	'', 0, 0, 0, 0, '', '', '', '', '', '', '',
        t.TranAmt, '', t.TranDate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(t.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	WHEN 'I' THEN RTRIM(t.CustID)
        WHEN 'N' THEN
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	ELSE ''
	END), 1, 30), t.trantype, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '04'
FROM Batch b (nolock), Customer c (nolock), WrkRelease w (nolock), ARTran t
WHERE t.CustID = c.CustID AND b.BatNbr = w.BatNbr AND w.BatNbr = t.BatNbr AND w.Module = 'AR' AND
	b.Module = 'AR' AND w.UserAddress = @UserAddress AND b.EditScrnNbr IN ('08030', '08450') AND
	t.TranType IN ('SB', 'SC') AND t.DrCr = 'U'

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '04', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '04'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-600:  Call pp_08400ApplyAllDocs for autoapply customers'

  END

/***** Auto Apply Customers *****/
/***** Create 'U' Records in ARTran - Payment Entry *****/
DECLARE @aCpnyID VARCHAR(10), @aBatNbr CHAR(10), @aCustID CHAR(15), @aTranType CHAR(2), @aCuryTranAmt Float,
        @aTranamt float, @aRefNbr CHAR(10),
        @aTranDate SmallDateTime, @aCuryID CHAR(4), @aCuryRate Float,
        @aCuryMultDiv CHAR(1), @aCuryRateType CHAR(6), @aCuryEffDate SmallDateTime,
        @aFinChgFirst INT, @AdjgBal float, @CuryAdjgBal float

/***** Adjusting Docs *****/
DECLARE TranCursor Insensitive  CURSOR FOR
	SELECT d.CpnyID, b.BatNbr, d.CustID, d.DocType, d.CuryDocBal, d.docbal, d.RefNbr, d.CuryID,
	       d.CuryRate, d.CuryMultDiv, b.CuryRateType,
               b.CuryEffDate, d.DocDate
	  FROM Batch b (nolock), ARDoc d, WrkRelease w (nolock), Customer c (nolock)
	 WHERE b.BatNbr = d.BatNbr AND d.BatNbr = w.BatNbr AND w.UserAddress = @UserAddress
           AND w.Module = 'AR' AND b.Module = 'AR'
           AND d.DocType IN ('CM', 'PA', 'PP')
           AND c.CustID = d.CustID AND c.AutoApply = 1
           AND d.crtd_prog <> '40690'   --Auto Apply does not affect OM, becaue OM is allowed
                                        --to apply the payment even if it is an Autoapply customer

OPEN TranCursor
FETCH NEXT FROM TranCursor
           INTO @aCpnyID, @aBatNbr, @aCustID, @aTranType, @aCuryTranAmt, @aTranamt, @aRefNbr,
	        @aCuryID, @aCuryRate, @aCuryMultDiv, @aCuryRateType,
                @aCuryEffDate, @aTranDate

WHILE (@@FETCH_STATUS <> -1) AND @aCuryTranAmt > 0
BEGIN
	IF @@FETCH_STATUS <> -2
	BEGIN
		DECLARE @AutoADResult INT
		EXEC pp_08400ApplyAllDocs @aCpnyID, @aBatNbr, @aCustID, @aTranType, @aCuryTranAmt, @aTranamt, @aRefNbr,
					  @aCuryID, @aCuryRate,
					  @aCuryMultDiv, @aCuryRateType,
	 				  @aTranDate, @aTranDate, @UserAddress,
					  @AdjdTranDescDflt , @AdjdAcct , @AdjdSub , @Sol_User,
                                          @AdjgBal OUTPUT, @CuryAdjgBal OUTPUT, @AutoADResult OUTPUT
		IF @AutoADResult = 0 GOTO ABORT
		/***  If we successfully created the U tran, update appl info for ardoc *****/
		Update d set d.applbatnbr = @abatnbr, d.curyapplamt = @CuryAdjgBal, d.ApplAmt = @AdjgBal
                  from wrkrelease w (nolock),
                       ardoc d Left outer join artran t on t.trantype = d.doctype
                                           AND t.custid = d.custid
                                           AND t.refnbr = d.refnbr
                                           AND t.batnbr = d.batnbr
                                           AND t.drcr = 'U'
		 where w.useraddress = @useraddress
                   and w.module = 'AR'
                   and w.batnbr = d.batnbr
                   and d.custid = @aCustid
                   and d.doctype = @aTrantype
	           and d.refnbr = @aRefNbr
 	END

        IF (@Debug = 1)
        BEGIN
          PRINT CONVERT(varchar(30), GETDATE(), 113)
          PRINT 'Display U trans as they are created.'
          SELECT t.Batnbr,t.Custid,t.Trantype,t.Refnbr,t.Drcr,t.Cpnyid,t.Costtype,t.SiteID,
                 t.TranAmt,t.CuryTranamt,t.Sub,t.*
            FROM artran t, wrkrelease w where t.batnbr = w.batnbr and w.module = 'AR' and
               w.useraddress = @useraddress and  t.custid = @aCustID and t.trantype = @aTranType
               and t.refnbr = @aRefNbr
        END

        FETCH NEXT
         FROM TranCursor
         INTO @aCpnyID, @aBatNbr, @aCustID, @aTranType, @aCuryTranAmt, @aTranamt, @aRefNbr, @aCuryID,
	      @aCuryRate, @aCuryMultDiv, @aCuryRateType,
              @aCuryEffDate, @aTranDate /*, @UserAddress*/
END

CLOSE TranCursor
DEALLOCATE TranCursor
IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-700:  Credit AR for unapplied amount if payment coming from 08030'

  END

INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
       CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
       Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
       PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
       S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
       ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
       SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
       TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
       TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT CASE d.DocType WHEN 'PP' THEN ISNULL(NULLIF(c.PrePayAcct, ''), @PPAcct) ELSE c.ARAcct END,
	1, b.BatNbr, 0, 0, ' ', '', d.CpnyID, GETDATE(), @ProgID, d.Crtd_User, 0,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, (d.Curyapplamt), 0, 0, 0, 0, 0, d.CustID,
	'C', 0, 0, RIGHT(RTRIM(d.CustOrdNbr),15), SUBSTRING(b.PerPost,1,4), 0,
	0, '', 0, 'AR', 0, 32767, '', GETDATE(),  @ProgID, d.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, d.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '',
	CASE d.DocType WHEN 'PP' THEN ISNULL(NULLIF(c.PrePaySub, ''), @PPSub) ELSE c.ARSub END,
	'', 0, 0, 0, 0, '', '', '', '', '', '', '', (d.applamt), '', d.DocDate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
        WHEN 'N' THEN
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	ELSE d.DocDesc
	END), 1, 30), d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '05'
FROM Batch b, ARDoc d, Customer c, WrkRelease w
WHERE d.CustID = c.CustID AND b.BatNbr = w.BatNbr AND  w.BatNbr = d.BatNbr AND w.Module = 'AR' AND
	b.Module = 'AR'  AND w.UserAddress = @UserAddress AND b.EditScrnNbr = '08030' AND
	(d.applamt > 0 OR d.curyapplamt > 0) AND rtrim(d.ApplBatNbr) = rtrim(d.BatNbr) AND d.Rlsed = 0
IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '05', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '05'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-800:  update u trans for trans that have no third currency information'

  END

update t set t.unitprice = d.curyrate,
	     t.curytxblamt00 = 1,
	     t.curytxblamt01 = 1,
	     t.unitdesc = d.perpost
from wrkrelease w, artran t, ardoc d
where w.useraddress = @useraddress and w.batnbr = t.batnbr and w.module = 'AR' and
t.custid = d.custid and t.costtype = d.doctype and t.siteid = d.refnbr and t.drcr = 'U' and t.unitprice = 0
IF @@ERROR < > 0 GOTO ABORT

update t set t.unitprice = d.curyrate,
	     t.curytxblamt00 = 1,
	     t.curytxblamt01 = 1,
	     t.unitdesc = d.perpost
from wrkrelease w, artran t, ardoc d
where w.useraddress = @useraddress and w.batnbr = t.batnbr and w.module = 'AR' and
t.custid = d.custid and t.costtype = d.doctype and t.siteid = d.refnbr and t.drcr = 'U' and
t.trantype in ('SB', 'SC', 'RP')
IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.drcr = 'U'
  END

--
-- Reversing batch aradjust records are handled in separate procs. For all others
-- call Insert ArAdjust
--
IF @EditScrnNbr <> '08240'
  BEGIN
    IF (@Debug = 1)
      BEGIN
        PRINT CONVERT(varchar(30), GETDATE(), 113)
        PRINT 'Debug...Step 1200-900:  Execute pp_08400InsertARAdjust'

      END

      EXEC pp_08400InsertARAdjust @Useraddress, @DecPl, @CurrPerNbr, @Sol_User,@Result OUTPUT

    IF @@ERROR < > 0 GOTO ABORT
    IF @Result <> 0 GOTO ABORT
  END

/************************************************************************/
/***** Process AR Entry for Payments Created on the 08030 Screen    *****/
/************************************************************************/

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-1000:  Credit trans for payments coming from 08030, built from ARAdjust rec.'

  END

INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
       CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
       CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
       Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
       LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
       PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
       S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
       ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
       SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
       TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
       TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT t.Acct, 1, t.BatNbr, 0, 0, ' ', '', t.CpnyID, GETDATE(), @ProgID, b.Crtd_User, 0,
       b.CuryId, b.CuryMultDiv, b.CuryRate, 0, 0, 0, 0,
       t.CuryTranAmt, 0, 0, 0, 0, 0, t.CustID,
       'C', 0, 0, t.ExtRefNbr, SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(),  @ProgID, b.LUpd_User,
       '', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, t.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
       '', ' ', 0, '', '', '', '', '', '', '', t.Sub, '', 0, 0, 0, 0, '', '', '', '', '', '', '',
       t.tranamt, '', t.TranDate,
       substring((CASE @TranDescDflt
       WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
       WHEN 'I' THEN RTRIM(d.CustID)
       WHEN 'N' THEN
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
       ELSE d.DocDesc
       END), 1, 30),
       t.TranType, 0, 0, 0, 0, '', 0, t.User1, t.User2, T.user3, T.User4, T.user5,
       t.user6, t.User7, t.User8, '07'
  FROM Batch b (nolock), WrkRelease w (nolock), ARTran t, Customer c, ARDoc d (nolock)
 WHERE 	d.CustID = c.CustID and w.batnbr = b.batnbr and w.module = 'AR' and b.module = 'AR'
   and w.useraddress = @useraddress and	b.batnbr = t.batnbr
   and t.drcr = 'U' and t.trantype in ('CM', 'PA', 'PP')
   and b.editscrnnbr IN('08030','08050') and t.batnbr = d.batnbr and t.custid = d.custid
   and t.trantype = d.doctype and t.refnbr = d.refnbr

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '07', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '07'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-1100:  Reversing trans for payments against INs with acct overrides'

  END

/***** Credit AR for Credit Memo/Payment/PrePayment that was previously            *****/
/***** entered and A/R account was overridden then Debit to the previous AR account *****/
/***** Also reversing if 'invoice' company differs from credit document company  ******/

INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  t.Acct, 1, t.BatNbr, 0, 0, ' ', '', t.CpnyID, GETDATE(), @ProgID, b.Crtd_User, 0,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0,
        CASE WHEN t.CuryTranAmt < 0 Then t.CuryTranAmt * -1 ELSE t.CuryTranAmt END, -- AVOID MAKING NEGATIVE TRANAMTS FOR REVERSALS.
        0, 0, 0, 0, 0, t.CustID,
	CASE WHEN t.CuryTranAmt < 0 Then 'D' ELSE 'C' END, -- AVOID MAKING NEGATIVE TRANAMTS FOR REVERSALS.
        0, 0, t.ExtRefNbr, SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(),  @ProgID, b.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, t.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '', t.Sub, '', 0, 0, 0, 0, '', '', '', '', '', '', '',
	CASE WHEN t.CuryTranAmt < 0 Then t.tranamt * -1 ELSE t.tranamt END, -- AVOID MAKING NEGATIVE TRANAMTS FOR REVERSALS.
        '', t.TranDate, t.TranDesc, t.TranType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '08'
  FROM (WrkRelease w INNER LOOP JOIN Batch b
                      ON w.batnbr = b.batnbr AND w.module = b.module
                    JOIN ARTran t
                      ON w.batnbr = t.batnbr
                    JOIN ARDoc d
                      ON d.custid = t.custid and d.doctype = t.trantype
                     AND d.refnbr = t.refnbr
                    JOIN Customer c
                      ON d.custid = c.custid)
                    CROSS JOIN ArSetup s (nolock)
 WHERE w.module = 'AR' AND w.useraddress = @UserAddress
   AND b.editscrnnbr IN ('08030','08240')
   AND t.drcr = 'U'
   AND d.batnbr <> d.applbatnbr
   AND (t.trantype = 'CM' AND (t.acct <> d.bankacct OR t.sub <> d.banksub OR d.cpnyid <> t.cpnyid)
        OR t.trantype = 'PA' AND (c.aracct <> '' AND t.acct <> c.aracct OR c.aracct = '' AND t.acct <> s.aracct
                                  OR c.arsub <> '' AND t.sub <> c.arsub OR c.arsub = '' AND t.sub <> s.arsub
                                  OR d.cpnyid <> t.cpnyid))

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '08', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '08'
  END

INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  CASE t.TranType WHEN 'CM' THEN d.BankAcct ELSE
            CASE c.aracct
                 WHEN ''
                 THEN s.aracct
                 ELSE c.aracct
                 END
        END,
        1, t.BatNbr, 0, 0, ' ', '', d.CpnyID, GETDATE(), @ProgID, b.Crtd_User, 0,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0,
        CASE WHEN t.CuryTranAmt < 0 Then t.CuryTranAmt * -1 ELSE t.CuryTranAmt END, -- AVOID MAKING NEGATIVE TRANAMTS FOR REVERSALS.
        0, 0, 0, 0, 0, t.CustID,
	CASE WHEN t.CuryTranAmt < 0 Then 'C' ELSE 'D' END, -- AVOID MAKING NEGATIVE TRANAMTS FOR REVERSALS.
        0, 0, t.ExtRefNbr, SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(), @ProgID, b.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, t.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '',
        CASE t.TranType WHEN 'CM' THEN d.BankSub ELSE
            CASE WHEN c.arsub = '' THEN s.arsub ELSE c.arsub END
        END,
        '', 0, 0, 0, 0, '', '', '', '', '', '', '',
	CASE WHEN t.CuryTranAmt < 0 Then t.tranamt * -1 ELSE t.tranamt END, -- AVOID MAKING NEGATIVE TRANAMTS FOR REVERSALS.
        '', t.TranDate, t.TranDesc, t.TranType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '09'
  FROM (WrkRelease w INNER LOOP JOIN Batch b
                      ON w.batnbr = b.batnbr AND w.module = b.module
                    JOIN ARTran t
                      ON w.batnbr = t.batnbr
                    JOIN ARDoc d
                      ON d.custid = t.custid and d.doctype = t.trantype
                     AND d.refnbr = t.refnbr
                    JOIN Customer c
                      ON d.custid = c.custid)
                    CROSS JOIN ArSetup s (nolock)
 WHERE w.module = 'AR' AND w.useraddress = @UserAddress
   AND b.editscrnnbr IN ('08030','08240')
   AND t.drcr = 'U'
   AND d.batnbr <> d.applbatnbr
   AND (t.trantype = 'CM' AND (t.acct <> d.bankacct OR t.sub <> d.banksub OR d.cpnyid <> t.cpnyid)
        OR t.trantype = 'PA' AND (c.aracct <> '' AND t.acct <> c.aracct OR c.aracct = '' AND t.acct <> s.aracct
                                  OR c.arsub <> '' AND t.sub <> c.arsub OR c.arsub = '' AND t.sub <> s.arsub
                                  OR d.cpnyid <> t.cpnyid))

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '09', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '09'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-1200:  Creating RGOL trans'

  END

/***** Create AR Tran for RGOL Amount *****/
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  CASE WHEN t.curytaxamt00 > 0
             THEN CASE WHEN @EditScrnNbr = '08240' THEN COALESCE(c.RealGainAcct, cp.RealGainAcct)
                  ELSE COALESCE(c.RealLossAcct, cp.RealLossAcct) END
             ELSE CASE WHEN @EditScrnNbr = '08240' THEN COALESCE(c.RealLossAcct, cp.RealLossAcct)
                  ELSE COALESCE(c.RealGainAcct, cp.RealGainAcct) END
        END, 1, t.BatNbr, 0, 0, ' ','',
        t.CpnyID, GETDATE(), @ProgID, t.Crtd_User, 0,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, d.CustID,
	CASE WHEN t.curytaxamt00 > 0
             THEN 'D'
             ELSE 'C'
        END,
        0, 0, '', SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR',
	0, 32767, '', GETDATE(),  @ProgID, @Sol_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, d.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '',
        (CASE  WHEN t.curytaxamt00 > 0
               THEN CASE WHEN @EditScrnNbr = '08240' THEN COALESCE(c.RealGainSub, cp.RealGainSub)
                    ELSE COALESCE(c.RealLossSub, cp.RealLossSub) END
               ELSE CASE WHEN @EditScrnNbr = '08240' THEN COALESCE(c.RealLossSub, cp.RealLossSub)
                    ELSE COALESCE(c.RealGainSub, cp.RealGainSub) END
         END), '', 0, 0, 0, 0, '', '', '', '', '', '', '',
        abs(Round(t.curytaxamt00, @decpl)),
        'N',
        d.DocDate,
        CASE WHEN t.curytaxamt00 > 0
	     THEN CASE WHEN @EditScrnNbr = '08240'
                       THEN 'Realized Gain' + ' ' + COALESCE(c.CuryID, cp.CuryID)
                       ELSE 'Realized Loss' + ' ' + COALESCE(c.CuryID, cp.CuryID)
                  END
	     ELSE
                 CASE WHEN @EditScrnNbr = '08240'
                       THEN 'Realized Loss' + ' ' + COALESCE(c.CuryID, cp.CuryID)
                       ELSE 'Realized Gain' + ' ' + COALESCE(c.CuryID, cp.CuryID)
                 END
        END,
        d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '10'
  FROM WrkRelease w (nolock) JOIN Batch b
                               ON w.batnbr = b.batnbr AND w.module = b.module
                             JOIN ARTran t
                               ON w.BatNbr = t.BatNbr
                             JOIN ARDoc d (nolock)
                               ON d.custid = t.custid AND d.DocType = t.TranType
                              AND d.RefNbr = t.RefNbr
                             JOIN GLSetup g (nolock)
                         ON g.SetupID = 'GL'
                             LEFT JOIN currncy c (nolock)
                               ON c.curyid = t.curyid
                              AND c.curyid <> g.basecuryid
                             JOIN currncy cp (nolock)
                               ON cp.curyid = d.curyid
 WHERE w.Module = 'AR' AND w.UserAddress = @UserAddress
   AND d.DocType IN ('CM', 'PA', 'PP', 'OI') AND t.curytaxamt00 <> 0
   AND t.drcr = 'U'
IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '10', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '10'
  END

/***** Create A/R Offset to Tran for RGOL Amount for Payment application from a previous entry *****/
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  t.acct, 1, t.BatNbr, 0, 0, ' ', '', t.CpnyID, GETDATE(), @ProgID, t.Crtd_User, 0,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, d.CustID,
	CASE WHEN t.curytaxamt00 > 0
             THEN 'C'
             ELSE 'D'
        END,
        0, 0, '', SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR',
	0, 32767, '', GETDATE(),  @ProgID, t.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, d.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '',
        t.sub, '', 0, 0, 0, 0, '', '', '', '', '', '', '',
        abs(round(t.curytaxamt00, @decpl)),
        'N',
        d.DocDate,
        substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
	WHEN 'N' THEN
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	ELSE d.DocDesc
	END), 1, 30),
        d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '11'
  FROM WrkRelease w (nolock) JOIN Batch b
                              ON w.batnbr = b.batnbr AND w.module = b.module
                            JOIN ARTran t
                              ON w.BatNbr = t.BatNbr
                            JOIN ARDoc d (nolock)
                              ON d.custid = t.custid AND d.DocType = t.TranType
                             AND d.RefNbr = t.RefNbr
                            JOIN customer c (nolock)
                              ON c.custid = t.custid
 WHERE w.Module = 'AR' AND w.UserAddress = @UserAddress
   AND d.DocType IN ('CM', 'PA', 'PP', 'OI') AND t.curytaxamt00 <> 0
   AND t.drcr = 'U'

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '11', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '11'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-1300:  Create discount trans'

  END

/***** Debit Discount (Credit For Reversals)*****/
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificCostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT @DiscAcct, 1, b.BatNbr, 0, 0, ' ', '', case when ARSetup.DiscCpnyFromInvc = 1 then t.CpnyID else p.CpnyID end, GETDATE(), @ProgID, t.Crtd_User, 0,
	b.CuryId, b.CuryMultDiv, b.CuryRate, 0, 0, 0, 0,
	ABS(Case        -- Make Discount positive whether payment or reversal
        WHEN b.curyid = t.curyid
          THEN t.CuryUnitPrice
        ELSE
	  Case when b.curymultdiv = 'M' then
	    round(j.adjdiscamt/b.curyrate, c.decpl)
	  else
	    round(j.adjdiscamt*b.curyrate, c.decpl)
	  end
	end),
	0, 0, 0, 0, 0, t.CustID,
	CASE SIGN(CURYUNITPRICE)  -- If curydiscount is negative it is a reversal
            WHEN 1 THEN 'D'       -- Payment
            ELSE 'C'              -- Reversal
            END,
         0, 0, '', SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(),  @ProgID, t.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, t.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0,'', '', '', '', '', '', '', @DiscSub, '', 0, 0, 0, 0, '', '', '', '', '', '', '',
        ABS(j.adjdiscamt), -- Make Discount positive whether payment or reversal
        'D', t.TranDate,
	t.TranDesc, t.TranType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '12'
FROM Batch b (nolock), WrkRelease w (nolock), ARTran t, ARAdjust j (nolock), currncy c (nolock),
     ARdoc p, ARSetup
WHERE b.BatNbr = w.BatNbr AND  w.BatNbr = t.BatNbr AND w.Module = 'AR' AND
	w.UserAddress = @UserAddress AND t.CuryUnitPrice <> 0 AND t.TranType IN ('PA', 'PP', 'CM')
  AND b.EditScrnNbr IN ('08030','08050','08240')
	AND t.DrCr = 'U' and j.custid = t.custid and j.adjgdoctype = t.trantype and j.adjgrefnbr = t.refnbr and
	j.adjddoctype = t.costtype and j.adjdrefnbr = t.siteid and c.curyid = b.curyid and j.adjbatnbr = w.batnbr
  AND t.custid = p.custid and t.trantype = p.doctype and t.refnbr = p.refnbr

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '12', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '12'
  END

/***** Credit A/R for Discount Amounts (Debit for Reversals) *****/
INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificCostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  t.Acct, 1, b.BatNbr, 0, 0, ' ', '', t.CpnyID, GETDATE(), @ProgID, t.Crtd_User, 0,
	b.CuryId, b.CuryMultDiv, b.CuryRate, 0, 0, 0, 0,
	ABS(CASE        -- Make Discount positive whether payment or reversal
        WHEN b.curyid = t.curyid
          THEN t.CuryUnitPrice
        ELSE
	  CASE WHEN b.curymultdiv = 'M' THEN
	    ROUND(j.adjdiscamt/b.curyrate, c.decpl)
	  ELSE
	    ROUND(j.adjdiscamt*b.curyrate, c.decpl)
	  END
	END),
	0, 0, 0, 0, 0, t.CustID,
	CASE SIGN(CURYUNITPRICE)  -- If curydiscount is negative it is a reversal
          WHEN 1 THEN 'C'         -- Payment
          ELSE 'D'                -- Reversal
        END,
        0, 0, '', SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(),  @ProgID, t.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, t.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0,'', '', '', '', '', '', '', t.Sub, '', 0, 0, 0, 0, '', '', '', '', '', '', '',
        ABS(j.adjdiscamt),       -- Make Discount positive whether payment or reversal
        'D', t.TranDate, t.TranDesc, t.TranType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '13'
FROM Batch b (nolock), WrkRelease w (nolock), ARTran t, aradjust j (nolock), currncy c (nolock)
WHERE b.BatNbr = w.BatNbr AND  w.BatNbr = t.BatNbr AND w.Module = 'AR' AND
	w.UserAddress = @UserAddress AND t.CuryUnitPrice <> 0 AND t.TranType IN ('PA', 'PP', 'CM') AND
	b.EditScrnNbr IN ('08030','08050','08240') AND t.DrCr = 'U' AND j.custid = t.custid AND j.adjgdoctype = t.trantype AND
	j.adjgrefnbr = t.refnbr and j.adjddoctype = t.costtype and j.adjdrefnbr = t.siteid and c.curyid = b.curyid AND
        j.adjbatnbr = w.batnbr

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '13', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '13'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-1400:  Offsetting AR Entry for Payments - 08050'

  END

INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  Case when d.doctype = 'PP' Then (Case when c.prepayAcct = '' then @PPAcct Else c.prepayAcct End) Else (Case when c.ARAcct = '' then @Acct Else c.ARAcct End) End,
        1, b.BatNbr, 0, 0, ' ', '', d.CpnyID, GETDATE(), @ProgID, d.Crtd_User, 0,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0,
	CASE d.ApplBatNbr WHEN '' THEN d.CuryOrigDocAmt ELSE d.CuryApplAmt END,
	0, 0, 0, 0, 0, d.CustID,
	'C', 0, 0, RIGHT(RTRIM(d.CustOrdNbr),15), SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(), @ProgID, d.Lupd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, d.RefNbr, 1, '', '', 0, 0, 0, 0, '', '',0, 0, '', '', ' ', 0,'', '', '', '', '',
	'', '', Case when d.doctype = 'PP' Then (Case when c.prepaySub = '' then @PPSub Else c.prepaySub End) Else (Case when c.ARSub = '' then @Sub Else c.ARSub End) End, '', 0, 0, 0, 0, '', '', '', '', '', '','',
	CASE d.ApplBatNbr WHEN '' THEN d.OrigDocAmt ELSE d.ApplAmt END,
	'', d.DocDate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
	WHEN 'N' THEN
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	ELSE d.DocDesc
	END), 1, 30), d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '14'
FROM Batch b (nolock), ARDoc d (nolock), Customer c (nolock), WrkRelease w (nolock)
WHERE d.CustID = c.CustID AND d.CpnyID = b.CpnyID AND b.BatNbr = w.BatNbr AND  w.BatNbr = d.BatNbr AND w.Module = 'AR' AND
	b.module = 'AR' and w.UserAddress = @UserAddress AND b.EditScrnNbr = '08050' AND d.DocType IN ('CM', 'PA', 'PP')
	AND (d.ApplBatNbr = '' OR d.ApplAmt <> 0)
ORDER BY d.BatNbr, d.CustID, d.Doctype, d.RefNbr

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '14', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '14'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-1500:  Create trans for NSF Charge'

  END

INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT @DfltNSFAcct,
       1, b.BatNbr, 0, 0, ' ', '', d.CpnyID, GETDATE(), '08240', d.Crtd_User, 0,
       d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, d.CuryOrigDocAmt,
       0, 0, 0, 0, 0, d.CustID,
       'C', 0, 0, RIGHT(RTRIM(d.CustOrdNbr),15), SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32766,
       '', GETDATE(), @ProgID, @Sol_User,
       '', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, d.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
       '', ' ', 0, '', '', '', '', '', '', '',
       @DfltNSFSub,
       '', 0, 0, 0, 0, '', '', '', '', '', '', '', d.OrigDocAmt, '', d.DocDate,
       substring((CASE @TranDescDflt
       WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
	WHEN 'N' THEN
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	ELSE d.DocDesc
	END), 1, 30), d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '15'
FROM Batch b (nolock), ARDoc d (nolock), Customer c (nolock), WrkRelease w (nolock)
WHERE b.batnbr = w.batnbr and w.module = 'AR' and b.module = 'AR' and w.useraddress = @useraddress
  and d.batnbr = b.batnbr and d.doctype = 'NC' and c.custid = d.custid

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '15', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '15'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-1600:  Offsetting AR Entry - 08520'

  END

INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT CASE WHEN c.ARAcct <> '' THEN c.ARAcct ELSE @Acct END, 1, b.BatNbr, 0, 0, ' ', '', d.CpnyID, GETDATE(), @ProgID, d.Crtd_User , 0,
	d.CuryId, d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, d.CuryOrigDocAmt, 0, 0, 0, 0, 0, d.CustID,
	'D', 0, 0, RIGHT(RTRIM(d.CustOrdNbr),15), SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(), @ProgID, d.Lupd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, d.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '', CASE WHEN c.ARSub <> '' THEN c.ARSub ELSE @Sub END, '', 0, 0, 0, 0, '', '', '', '', '', '',
	'', d.OrigDocAmt, '', d.DocDate,
	substring((CASE @TranDescDflt
	WHEN 'C' THEN RTRIM(d.CustID) + ' ' +
		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	WHEN 'I' THEN RTRIM(d.CustID)
	WHEN 'N' THEN
 		CASE
		WHEN CHARINDEX('~', c.Name) > 0
		THEN LTRIM(RTRIM(RIGHT(c.Name, DATALENGTH(RTRIM(c.Name)) - CHARINDEX('~', c.Name)))) + ' ' + SUBSTRING(c.Name, 1, (CHARINDEX('~', c.Name) - 1))
		ELSE c.Name
		END
	ELSE d.DocDesc
	END), 1, 30), d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '17'
FROM Batch b (nolock), ARDoc d (nolock), Customer c (nolock), WrkRelease w (nolock)
WHERE d.CustID = c.CustID AND b.BatNbr = w.BatNbr AND  w.BatNbr = d.BatNbr AND w.Module = 'AR' AND
	b.module = 'AR' and w.UserAddress = @UserAddress AND b.EditScrnNbr = '08520'

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '17', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '17'
  END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(varchar(30), GETDATE(), 113)
    PRINT 'Debug...Step 1200-1700:  Reversing entries for prepayments applied in 08030'

  END
/**** This will do the reversing entries for the prepayment when it is applied in 08030 ****/

INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  t.Acct, 1, t.BatNbr, 0, 0, ' ', '', t.CpnyID, GETDATE(), @ProgID, b.Crtd_User, 0,
	b.CuryId, b.CuryMultDiv, b.CuryRate, 0, 0, 0, 0,
        case when b.editscrnnbr = '08240' then -t.CuryTranAmt else t.CuryTranAmt end, 0, 0, 0, 0, 0, t.CustID,
	case when b.editscrnnbr = '08240' then 'D' else 'C' end, 0, 0, t.ExtRefNbr, SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(),  @ProgID, b.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, t.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '', t.Sub, '', 0, 0, 0, 0, '', '', '', '', '', '', '',
	case when b.editscrnnbr = '08240' then -t.TranAmt else t.TranAmt end, '', t.TranDate,
	t.TranDesc, t.TranType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '18'
FROM Batch b (nolock), WrkRelease w (nolock), ARTran t
WHERE 	w.batnbr = b.batnbr and w.module = 'AR' and b.module = 'AR' and w.useraddress = @useraddress and
	b.batnbr = t.batnbr and t.drcr = 'U' and t.trantype in ('PP')
	and b.editscrnnbr in ('08030', '08240')

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '18', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '18'
  END

INSERT ARTran (Acct, AcctDist, BatNbr, CmmnPct, CnvFact, ContractID, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
	CuryExtCost, CuryId, CuryMultDiv, CuryRate, CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03,
	CuryTranAmt, CuryTxblAmt00, CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, CustId, DrCr,
	Excpt, ExtCost, ExtRefNbr, FiscYr, FlatRateLineNbr, InstallNbr, InvtId, JobRate, JrnlType, LineId, LineNbr, LineRef,
	LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, NoteId, OrdNbr, PC_Flag, PC_ID, PC_Status, PerEnt,
	PerPost, ProjectID, Qty, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
	S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ServiceCallLineNbr, ServiceDate,
	ShipperCpnyID, ShipperID, ShipperLineRef, SiteId, SlsperId,
	SpecificcostID, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced, TaxCat, TaxId00, TaxId01,
	TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass, TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02,
	TxblAmt03, UnitDesc, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
SELECT  Case when c.prepayAcct = '' then @PPAcct Else c.prepayAcct End, 1, t.BatNbr, 0, 0, ' ', '', d.CpnyID, GETDATE(), @ProgID, b.Crtd_User, 0,
	b.CuryId, b.CuryMultDiv, b.CuryRate, 0, 0, 0, 0,
        case when b.editscrnnbr = '08240' then -t.CuryTranAmt else t.CuryTranAmt end, 0, 0, 0, 0, 0, t.CustID,
	case when b.editscrnnbr = '08240' then 'C' else 'D' end, 0, 0, t.ExtRefNbr, SUBSTRING(b.PerPost,1,4), 0, 0, '', 0, 'AR', 0, 32767, '', GETDATE(), @ProgID, b.LUpd_User,
	'', 0, '', '', '', '', b.PerEnt, b.PerPost, '', 0, t.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '',
	'', ' ', 0, '', '', '', '', '', '', '', Case when c.prepaySub = '' then @PPSub Else c.prepaySub End, '', 0, 0, 0, 0, '', '', '', '', '', '', '',
	case when b.editscrnnbr = '08240' then -t.TranAmt else t.TranAmt end, '', t.TranDate,
	t.TranDesc, t.TranType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', '19'
FROM Batch b (nolock), WrkRelease w (nolock), ARTran t, customer c (nolock), ARDoc d
WHERE 	w.batnbr = b.batnbr and w.module = 'AR' and b.module = 'AR' and w.useraddress = @useraddress and
	b.batnbr = t.batnbr and t.drcr = 'U' and t.trantype in ('PP')
	and b.editscrnnbr in ('08030', '08240') and t.custid = c.custid
        AND d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND d.CustID = t.CustID

IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    select '19', t.batnbr, t.custid, t.trantype, t.refnbr, t.curytranamt, t.tranamt, t.drcr,
    t.tranclass, t.WhseLoc, t.*
    from artran t, wrkrelease w where w.batnbr = t.batnbr and w.module = 'AR' and
    w.useraddress = @useraddress and t.WhseLoc = '19'
  END

SELECT @CRResult = 1
GOTO FINISH

ABORT:
SELECT @CRResult = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400CreateOffset] TO [MSDSL]
    AS [dbo];

