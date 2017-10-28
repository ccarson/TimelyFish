 CREATE PROC scm_10990_Status_tables_Rebuild @InvtID varchar(30), @SiteID varchar(10), @FiscYr varchar(4), @rebuild int, @rebuildhist int, @user varchar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS

SET nocount on

if object_id('tempdb..#IN10990_Errorlog') is null begin
	create table #IN10990_Errorlog
        (MsgNbr smallint,
	Parm0 varchar(30),
	Parm1 varchar(30),
	recordid int,
	Parm3 varchar(30),
	Parm4 varchar(30),
	Parm5 varchar(30),
	Parm6 varchar(30))
--indexes
end else begin
	delete from #IN10990_Errorlog
end

if object_id('tempdb..#IN10990_InTran') IS NULL BEGIN
	SELECT BatNbr,
        BMIExtCost = CONVERT(dec(28,3),BMIExtCost),
        BMITranAmt = CONVERT(dec(28,3),BMITranAmt),
        CnvFact,CpnyID,Crtd_Prog,
	ExtCost = CONVERT(dec(28,3),BMIExtCost),
	FiscYr,
	InsuffQty = CONVERT(dec(28,9),InsuffQty),
        InvtID,InvtMult,JrnlType,/*LayerType,*/LineId,LineRef,LineNbr,LotSerCntr,LUpd_DateTime,NoteID,
        OvrhdAmt = CONVERT(dec(28,3),OvrhdAmt),
	OvrhdFlag,
        PerPost,
        Qty = CONVERT(dec(28,9),Qty),
        QtyUnCosted = CONVERT(dec(28,9),QtyUnCosted),
        RcptDate,RcptNbr,
        recordid = CONVERT (int,recordid),RefNbr,/*Retired,*/Rlsed,
	S4Future05,S4Future09,ShipperID,SiteID,SpecificCostID, ToSiteID = convert(int,0),
	tranamt = CONVERT(dec(28,3),TranAmt),
	TrANDate,TranDesc,TranType,Unitdesc,UnitMultDiv,/*USETranCost,*/WhseLoc
	INTO #IN10990_InTran FROM intran WHERE 1 = 0
	CREATE INDEX #IN10990_InTran01 on #IN10990_InTran (BatNbr,LineRef,recordid)
	CREATE INDEX #IN10990_InTran02 on #IN10990_InTran (Perpost,S4Future09, trantype)
END ELSE BEGIN
	DELETE FROM #IN10990_InTran
END

if object_id('tempdb..#IN10990_Lotsert') IS NULL BEGIN
	SELECT BatNbr,INTranLineRef,InvtID,LineNbr,LotSerNbr,
        LUpd_DateTime,LUpd_Prog,
        Qty = CONVERT(dec(28,9),Qty),
        RcptNbr,
        recordid = CONVERT(int,recordid),
	RefNbr,/*Retired,*/Rlsed,SiteID,TranType,WhseLoc
	INTO #IN10990_Lotsert FROM lotsert WHERE 1 = 0
	CREATE INDEX #IN10990_Lotsert01 on #IN10990_Lotsert (batnbr, INTranLineRef, TranType)
END ELSE BEGIN
	DELETE FROM #IN10990_Lotsert
END

if object_id('tempdb..#layers') IS NULL BEGIN
	CREATE TABLE #layers
	(SpecificCostID varchar(30),
	rcptnbr varchar(15),
	rcptdate smalldatetime,
	Qty dec(28,9),
	totcost dec(28,3),
	bmitotcost dec(28,3)
	)
	CREATE INDEX #layer01 on #layers (rcptdate)
END ELSE BEGIN
	DELETE FROM #layers
END

if object_id('tempdb..#layers1') IS NULL BEGIN
	CREATE TABLE #layers1
	(SpecificCostID varchar(30),
	rcptnbr varchar(15),
	rcptdate smalldatetime,
	Qty dec(28,9),
	totcost dec(28,3),
	bmitotcost dec(28,3)
	)
	CREATE INDEX #layer101 on #layers1 (rcptdate)
--	create unique index #layer102 on #layers1 (SpecificCostID, rcptnbr, rcptdate)
END ELSE BEGIN
	DELETE FROM #layers1
END

if object_id('tempdb..#templot') IS NULL BEGIN
	CREATE TABLE #templot
	(tbatnbr varchar(10),
	 tlineref varchar(5),
	 ttrantype char(2),
	 tqty dec(28,9))
END ELSE BEGIN
	DELETE FROM #templot
END

DECLARE @valmthd char(1)
DECLARE @lotsertrack char(2)
DECLARE @lotserissmthd char(1)
DECLARE @decpl int
DECLARE @BMIDecPl int
DECLARE @DecPlQty int
DECLARE @DecPlPrcCst int
DECLARE @permin varchar(6)
DECLARE @perstart varchar(6)
DECLARE @recordid int
DECLARE @qty dec(28,9)
DECLARE @totcost dec(28,3)
DECLARE @bmitotcost dec(28,3)
DECLARE @tqty dec(28,9)
DECLARE @ttotcost dec(28,3)
DECLARE @lqty dec(28,9)
DECLARE @tbmitotcost dec(28,3)
DECLARE @rcptdate smalldatetime
DECLARE @tbatnbr varchar(10)
DECLARE @tlineref varchar(5)
DECLARE @ttrantype varchar(2)
DECLARE @MinYr int
DECLARE @MaxYr int
DECLARE @NextYr int
DECLARE @CurrYear varchar(4)

SELECT	@valmthd = valmthd, @lotsertrack = lotsertrack, @lotserissmthd = serassign
FROM	Inventory (NOLOCK) WHERE InvtID = @InvtID

SELECT	@DecPl = c.DecPl
FROM	GLSETup s (NOLOCK), Currncy c (NOLOCK) WHERE s.BaseCuryID = c.CuryID
SELECT	@BMIDecPl = c.DecPl
FROM	INSETup s (NOLOCK), Currncy c (NOLOCK) WHERE s.BMICuryID = c.CuryID

SELECT	@DecPlQty = DecPlQty, @DecPlPrcCst = DecPlPrcCst, @CurrYear = LEFT(CurrPerNbr,4) FROM INSETup (NOLOCK)

BEGIN TRANSACTION

--lock ItemSite
UPDATE ItemSite SET ABCcode = ABCcode FROM ItemSite WHERE InvtID = @invtID AND SiteID = @siteID
IF @@ERROR <> 0 GOTO Err

INSERT	INTO #IN10990_InTran
SELECT	BatNbr,CONVERT(dec(28,3), COALESCE(ROUND(BMIExtCost,@BMIDecPl),0)),
	CONVERT(dec(28,3), COALESCE(ROUND(BMITranAmt,@BMIDecPl), 0)), CnvFact, CpnyID, Crtd_Prog,
	CONVERT(dec(28,3), ROUND(ExtCost,@decpl)), FiscYr,
	CONVERT(dec(28,9), ROUND(CASE WHEN UnitMultDiv = 'D' THEN 1/CnvFact ELSE CnvFact END * InsuffQty, @DecPlQty)),
	InvtID,
	CASE WHEN TranType = 'CT' AND TranDesc = 'Standard Cost Variance' THEN -InvtMult ELSE InvtMult END,
	JrnlType,/*LayerType,*/LineId, Lineref, Linenbr, LotSerCntr,
	LUpd_DateTime, NoteID, CONVERT(dec(28,3), ROUND(OvrhdAmt,@decpl)), OvrhdFlag, PerPost,
	CONVERT(dec(28,9), ROUND(CASE WHEN UnitMultDiv = 'D' THEN 1/CnvFact ELSE CnvFact END * Qty, @DecPlQty)),
	CONVERT(dec(28,9), ROUND(CASE WHEN UnitMultDiv = 'D' THEN 1/CnvFact ELSE CnvFact END * QtyUnCosted, @DecPlQty)),
	RcptDate,RcptNbr,recordid,RefNbr,/*Retired,*/
	CASE WHEN TranType NOT IN('CT','CG') OR TranDesc <> 'Overhead Entry' THEN Rlsed ELSE 0 END,
	S4Future05,S4Future09,ShipperID,SiteID,
	SpecificCostID,0,CONVERT(dec(28,3),ROUND(TranAmt,@decpl)),
	TrANDate,TranDesc,TranType,UnitDesc,UnitMultDiv,/*USETranCost,*/WhseLoc
FROM	intran WHERE InvtID = @InvtID AND SiteID = @SiteID
IF @@ERROR <> 0 GOTO Err

Update t set TositeID = 1 from #IN10990_InTran t
inner join TrnsfrDoc d on t.batnbr = d.batnbr and t.refnbr = d.refnbr and d.transfertype = 1 and d.SiteID = d.ToSiteID
IF @@ERROR <> 0 GOTO Err

If @BMIDecPl IS NULL SET @BMIDecPl = 0

DELETE FROM #IN10990_InTran WHERE rlsed = 0 OR S4Future05 = 1

-- SELECT the period the itemhist have to be rebuild AND eliminate duplicated 'AB' transactions
-- SELECT @permin = min(perpost) FROM #IN10990_InTran
-- SELECT @perstart = coalesce(max(perpost), @permin, '190001'), @recordid = max(recordid) FROM #IN10990_InTran WHERE trantype = 'AB'

/*	INTran records cannot have fields */
        INSERT INTO #IN10990_Errorlog
        SELECT MsgNbr = Cast(16376 As SmallInt),
		Parm0 = Cast(t.BatNbr As VarChar(30)),
		Parm1 = Cast(t.LineRef As VarChar(30)),
		recordid = Cast(t.recordid As VarChar(30)),
		Parm3 =   CASE WHEN t.trantype <>'AB' AND b.batnbr IS NULL THEN 'A' ELSE '' END
			+ CASE WHEN t.CnvFact = 0 THEN 'B' ELSE '' END
			+ CASE WHEN c.CpnyID IS NULL THEN 'C' ELSE '' END
			+ CASE WHEN len(rtrim(t.FiscYr)) <> 4 OR isnumeric(t.FiscYr) = 0 /*OR (b.perpost is not null AND left(b.perpost,4) <> t.fiscYr) */  THEN 'D' ELSE '' END
			+ CASE WHEN t.InvtMult not in (1, -1) THEN 'E' ELSE '' END
			+ CASE WHEN len(rtrim(t.JrnlType)) <> 2 THEN 'F' ELSE '' END
			+ CASE WHEN t.trantype <>'AB' AND rtrim(t.Lineref) = '' THEN 'G' ELSE '' END
			+ CASE WHEN len(rtrim(t.perpost)) <> 6 OR isnumeric(t.perpost) = 0 /*OR (b.perpost is not null AND b.perpost <> t.perpost)*/ THEN 'H' ELSE '' END
			+ CASE WHEN t.trantype not in ('AS','RC','TR','IN','II','CM','DM','RI','PI','AJ','AC','CT','CG','AB') THEN 'I' ELSE '' END
			+ CASE WHEN (t.trantype in ('AJ','PI','RC','CM','RI') AND t.invtMult <> 1) OR (t.trantype in ('IN','II','DM') AND t.Invtmult <> -1 ) THEN 'J' ELSE '' END
			+ CASE WHEN t.trantype not in ('AJ','PI', 'AC') AND  t.Qty < 0 THEN 'K' ELSE '' END
			+ CASE WHEN t.trantype not in ('AJ','PI', 'AC') AND t.extcost < 0 THEN 'L' ELSE '' END
			+ CASE WHEN t.trantype not in ('AJ','PI', 'AC') AND t.tranamt < 0 THEN 'M' ELSE '' END
			+ CASE WHEN s.SiteID IS NULL THEN 'N' ELSE '' END
			+ CASE WHEN w.WhseLoc IS NULL AND i.stkitem = 1 AND trantype not in ('AC','CG','CT') and t.S4Future09 = 0 THEN 'O' ELSE '' END
			+ CASE WHEN t.unitdesc = '' THEN 'P' ELSE '' END
			+ CASE WHEN @valmthd = 'S' AND rtrim(t.SpecificCostID) = '' AND t.S4Future09 <> 2 THEN 'Q' ELSE '' END ,
		Parm4 = '',
		Parm5 = '',
		Parm6 = '0'
		FROM	#IN10990_InTran t
			--intran t
		INNER JOIN Inventory i on t.InvtID = i.InvtID
		LEFT JOIN vs_company c on t.cpnyid = c.cpnyid
		LEFT JOIN site s on t.SiteID = s.SiteID AND t.cpnyID = s.cpnyID
		LEFT JOIN loctable w on t.SiteID = w.SiteID AND t.WhseLoc = w.WhseLoc
		LEFT JOIN batch b on t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END
		WHERE
		   (t.trantype <>'AB' AND b.batnbr IS NULL)
		OR (t.CnvFact = 0)
		OR (c.CpnyID IS NULL)
		OR (len(rtrim(t.FiscYr)) <> 4 OR isnumeric(t.FiscYr) = 0 /*OR (b.perpost is not null AND left(b.perpost,4) <> t.fiscYr)*/)
		OR (t.InvtMult not in (1, -1))
		OR (len(t.JrnlType) <> 2)
		OR (t.trantype <>'AB' AND rtrim(t.Lineref) = '')
		OR (len(rtrim(t.perpost)) <> 6 OR isnumeric(t.perpost) = 0 /*OR (b.perpost is not null AND b.perpost <> t.perpost)*/)
		OR (t.trantype not in ('AS','RC','TR','IN','II','CM','DM','RI','PI','AJ','AC','CT','CG','AB'))
		OR ((t.trantype in ('AJ','PI','RC','CM','RI') AND t.invtMult <> 1) OR (t.trantype in ('IN','II','DM') AND t.Invtmult <> -1 ))
		OR (t.trantype not in ('AJ','PI', 'AC') AND  t.Qty < 0)
		OR (t.trantype not in ('AJ','PI', 'AC') AND t.extcost < 0)
		OR (t.trantype not in ('AJ','PI', 'AC') AND t.tranamt < 0)
		OR (s.SiteID IS NULL)
		OR (w.WhseLoc IS NULL AND i.stkitem = 1 AND trantype not in ('AC','CG','CT') AND t.S4Future09 = 0)
		OR (t.unitdesc = '')
		OR (@valmthd = 'S' AND rtrim(t.SpecificCostID) = '')

-- CASE A
INSERT	INTO #IN10990_Errorlog
SELECT	16376, parm0, parm1, recordid, 'Batch was deleted or BatNbr', '', '', '2'
FROM	#IN10990_Errorlog WHERE CHARINDEX('A',Parm3) > 0  AND parm6 = '0'
-- CASE B
INSERT	INTO #IN10990_Errorlog
SELECT	16376, parm0, parm1, recordid, 'CnvFact', '', '', '1'
FROM 	#IN10990_Errorlog WHERE CHARINDEX('B',Parm3) > 0  AND parm6 = '0'
-- CASE C
UPDATE	#IN10990_Errorlog SET msgnbr = 16376, parm4 = '', parm5 = '' WHERE CHARINDEX('C',Parm3) > 0 AND parm6 = '0'

IF @rebuild + @rebuildhist > 0  BEGIN
	UPDATE	l SET msgnbr = 16377, parm4 = t.cpnyID, parm5 = b.cpnyID
	FROM	#IN10990_Errorlog l
		INNER JOIN #IN10990_InTran t ON l.recordid = t.recordid AND CHARINDEX('C',Parm3)>0 AND parm6 = '0'
		INNER JOIN batch b ON t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END
		INNER JOIN vs_company c ON b.cpnyid = c.cpnyid

	UPDATE t SET cpnyID = b.cpnyID
	FROM #IN10990_Errorlog l
	INNER JOIN intran t on l.recordid = t.recordid AND CHARINDEX('C',Parm3)>0 AND parm6 = '0'
	INNER JOIN batch b on t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END
	INNER JOIN vs_company c on b.cpnyid = c.cpnyid

	UPDATE t SET cpnyID = b.cpnyID
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('C',Parm3)>0 AND parm6 = '0'
	INNER JOIN batch b on t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END
	INNER JOIN vs_company c on b.cpnyid = c.cpnyid
END
INSERT INTO #IN10990_Errorlog SELECT msgnbr, parm0, parm1, recordid,'CpnyId',parm4,parm5,CASE WHEN rtrim(parm4 + parm5) = '' THEN '1' ELSE '2' END
FROM #IN10990_Errorlog WHERE CHARINDEX('C',Parm3) > 0 AND parm6 = '0'
--CASE D
UPDATE #IN10990_Errorlog SET msgnbr = 16376, parm4 = '', parm5 = '' WHERE CHARINDEX('D',Parm3) > 0 AND parm6 = '0'
if @rebuild + @rebuildhist > 0 BEGIN
	UPDATE l SET msgnbr = 16377, parm4 = t.fiscYr, parm5 = left(b.perpost,4)
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('D',Parm3)>0 AND parm6 = '0'
	INNER JOIN batch b on t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END

	UPDATE t SET FiscYr = left(b.perpost,4)
	FROM #IN10990_Errorlog l
	INNER JOIN intran t on l.recordid = t.recordid AND CHARINDEX('D',Parm3)>0 AND parm6 = '0'
	INNER JOIN batch b on t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END

	UPDATE t SET FiscYr = left(b.perpost,4)
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('D',Parm3)>0 AND parm6 = '0'
	INNER JOIN batch b on t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END
END
INSERT INTO #IN10990_Errorlog SELECT '16376', parm0, parm1, recordid, 'FiscYr',parm4,parm5,CASE WHEN rtrim(parm4 + parm5) = '' THEN '1' ELSE '2' END
FROM #IN10990_Errorlog WHERE CHARINDEX('D',Parm3) > 0 AND parm6 = '0'
--CASE E
INSERT INTO #IN10990_Errorlog SELECT '16376', parm0, parm1, recordid, 'InvtMult', '','','1' FROM
#IN10990_Errorlog WHERE CHARINDEX('E',Parm3) > 0  AND parm6 = '0'
--CASE F
INSERT INTO #IN10990_Errorlog SELECT '16376', parm0, parm1, recordid, 'JrnlType', '','','1' FROM
#IN10990_Errorlog WHERE CHARINDEX('F',Parm3) > 0  AND parm6 = '0'
--CASE G
UPDATE #IN10990_Errorlog SET msgnbr = 16376, parm4 = '', parm5 = '' WHERE CHARINDEX('G',Parm3) > 0 AND parm6 = '0'
if @rebuild + @rebuildhist > 0 AND @lotsertrack = 'NN' BEGIN

	UPDATE l SET msgnbr = 16375, parm4 = t.Lineref, parm5 = replicate('0',5-Len(CONVERT(char,LineID))) + CONVERT(char,LineID)
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('G',Parm3)>0 AND parm6 = '0'

	UPDATE t SET Lineref = replicate('0',5-Len(CONVERT(char,LineID))) + CONVERT(char,LineID)
	FROM #IN10990_Errorlog l
	INNER JOIN intran t on l.recordid = t.recordid AND CHARINDEX('G',Parm3)>0 AND parm6 = '0'

	UPDATE t SET Lineref = replicate('0',5-Len(CONVERT(char,LineID))) + CONVERT(char,LineID)
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('G',Parm3)>0 AND parm6 = '0'
END
INSERT INTO #IN10990_Errorlog SELECT msgnbr, parm0, parm1, recordid, 'LineRef',parm4,parm5,CASE WHEN rtrim(parm4 + parm5) = '' THEN '1' ELSE '2' END
FROM #IN10990_Errorlog WHERE CHARINDEX('G',Parm3) > 0 AND parm6 = '0'
--CASE H
UPDATE #IN10990_Errorlog SET msgnbr = 16376, parm4 = '', parm5 = '' WHERE CHARINDEX('H',Parm3) > 0 AND parm6 = '0'
if @rebuild + @rebuildhist > 0 BEGIN
	UPDATE l SET msgnbr = 16377, parm4 = t.Perpost, parm5 = b.perpost
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('H',Parm3)>0 AND parm6 = '0'
	INNER JOIN batch b on t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END

	UPDATE t SET perpost = b.perpost
	FROM #IN10990_Errorlog l
	INNER JOIN intran t on l.recordid = t.recordid AND CHARINDEX('H',Parm3)>0 AND parm6 = '0'
	INNER JOIN batch b on t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END

	UPDATE t SET perpost = b.perpost
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('H',Parm3)>0 AND parm6 = '0'
	INNER JOIN batch b on t.batnbr = b.batnbr AND b.module = CASE WHEN t.JrnlType = 'PO' THEN 'PO' ELSE 'IN' END
END
INSERT INTO #IN10990_Errorlog SELECT msgnbr, parm0, parm1, recordid, 'PerPost',parm4,parm5,CASE WHEN rtrim(parm4 + parm5) = '' THEN '1' ELSE '2' END
FROM #IN10990_Errorlog WHERE CHARINDEX('H',Parm3) > 0 AND parm6 = '0'
--CASE I
INSERT INTO #IN10990_Errorlog SELECT '16376', parm0, parm1, recordid, 'TranType', '','','1' FROM
#IN10990_Errorlog WHERE CHARINDEX('I',Parm3) > 0  AND parm6 = '0'
--CASE J
UPDATE #IN10990_Errorlog SET msgnbr = 16376, parm4 = '', parm5 = '' WHERE CHARINDEX('J',Parm3) > 0 AND parm6 = '0'
if @rebuild + @rebuildhist > 0 BEGIN
	UPDATE l SET msgnbr = 16377, parm4 = str(t.invtmult), parm5 = CONVERT(char,CASE WHEN t.trantype in ('AJ','PI', 'AC','RC','CM','RI') THEN 1 ELSE -1 END)
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('J',Parm3)>0 AND parm6 = '0'

	UPDATE t SET InvtMult = CASE WHEN t.trantype in ('AJ','PI', 'AC','RC','CM','RI') THEN 1 ELSE -1 END,
		     tranamt = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.tranamt) = 0 THEN sign(t.tranamt) ELSE sign(t.invtmult*t.tranamt) END END * abs(t.tranamt),
		     extcost = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.extcost) = 0 THEN sign(t.extcost) ELSE sign(t.invtmult*t.extcost) END END * abs(t.extcost),
	     	     bmitranamt = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.tranamt) = 0 THEN sign(t.tranamt) ELSE sign(t.invtmult*t.tranamt) END END * abs(t.bmitranamt),
		     bmiextcost = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.extcost) = 0 THEN sign(t.extcost) ELSE sign(t.invtmult*t.extcost) END END * abs(t.bmiextcost),
		     Qty = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.Qty) = 0 THEN sign(t.Qty) ELSE sign(t.invtmult*t.Qty) END END * abs(t.Qty)
	FROM #IN10990_Errorlog l
	INNER JOIN intran t on l.recordid = t.recordid AND CHARINDEX('J',Parm3)>0 AND parm6 = '0'

	UPDATE t SET InvtMult = CASE WHEN t.trantype in ('AJ','PI', 'AC','RC','CM','RI') THEN 1 ELSE -1 END,
		     tranamt = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.tranamt) = 0 THEN sign(t.tranamt) ELSE sign(t.invtmult*t.tranamt) END END * abs(t.tranamt),
		     extcost = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.extcost) = 0 THEN sign(t.extcost) ELSE sign(t.invtmult*t.extcost) END END * abs(t.extcost),
		     bmitranamt = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.tranamt) = 0 THEN sign(t.tranamt) ELSE sign(t.invtmult*t.tranamt) END END * abs(t.bmitranamt),
		     bmiextcost = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.extcost) = 0 THEN sign(t.extcost) ELSE sign(t.invtmult*t.extcost) END END * abs(t.bmiextcost),
		     Qty = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.Qty) = 0 THEN sign(t.Qty) ELSE sign(t.invtmult*t.Qty) END END * abs(t.Qty)
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('J',Parm3)>0 AND parm6 = '0'
END
INSERT INTO #IN10990_Errorlog SELECT msgnbr, parm0, parm1, recordid, 'InvtMult',parm4,parm5,CASE WHEN rtrim(parm4 + parm5) = '' THEN '1' ELSE '2' END
FROM #IN10990_Errorlog WHERE CHARINDEX('J',Parm3) > 0 AND parm6 = '0'
--CASE KLM
UPDATE #IN10990_Errorlog SET msgnbr = 16376, parm4 = '', parm5 = '' WHERE (CHARINDEX('K',Parm3)>0 OR CHARINDEX('L',Parm3)>0 OR CHARINDEX('M',Parm3)>0) AND CHARINDEX('J',Parm3)= 0 AND parm6 = '0'
if @rebuild + @rebuildhist > 0 BEGIN
	UPDATE l SET msgnbr = 16378, parm4 = str(t.invtmult), parm5 = CONVERT(char,CASE WHEN t.trantype in ('AJ','PI', 'AC','RC','CM','RI') THEN 1 ELSE -1 END)
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND (CHARINDEX('K',Parm3)>0 OR CHARINDEX('L',Parm3)>0 OR CHARINDEX('M',Parm3)>0) AND CHARINDEX('J',Parm3)= 0 AND parm6 = '0'
		UPDATE t SET InvtMult = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN CASE WHEN sign(t.invtmult*t.Qty) = 0 THEN CASE WHEN sign(t.Qty) = 0 THEN 1 ELSE sign(t.Qty) END ELSE sign(t.invtmult*t.Qty) END ELSE 1 END,
		     tranamt = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.tranamt) = 0 THEN sign(t.tranamt) ELSE sign(t.invtmult*t.tranamt) END END * abs(t.tranamt),
		     extcost = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.extcost) = 0 THEN sign(t.extcost) ELSE sign(t.invtmult*t.extcost) END END * abs(t.extcost),
		     bmitranamt = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.tranamt) = 0 THEN sign(t.tranamt) ELSE sign(t.invtmult*t.tranamt) END END * abs(t.bmitranamt),
		     bmiextcost = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.extcost) = 0 THEN sign(t.extcost) ELSE sign(t.invtmult*t.extcost) END END * abs(t.bmiextcost),
		     Qty = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.Qty) = 0 THEN sign(t.Qty) ELSE sign(t.invtmult*t.Qty) END END * abs(t.Qty)
	FROM #IN10990_Errorlog l
	INNER JOIN intran t on l.recordid = t.recordid AND (CHARINDEX('K',Parm3)>0 OR CHARINDEX('L',Parm3)>0 OR CHARINDEX('M',Parm3)>0) AND CHARINDEX('J',Parm3)= 0 AND parm6 = '0'

	UPDATE t SET InvtMult = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN CASE WHEN sign(t.invtmult*t.Qty) = 0 THEN CASE WHEN sign(t.Qty) = 0 THEN 1 ELSE sign(t.Qty) END ELSE sign(t.invtmult*t.Qty) END ELSE 1 END,
		     tranamt = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.tranamt) = 0 THEN sign(t.tranamt) ELSE sign(t.invtmult*t.tranamt) END END * abs(t.tranamt),
		     extcost = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.extcost) = 0 THEN sign(t.extcost) ELSE sign(t.invtmult*t.extcost) END END * abs(t.extcost),
		     bmitranamt = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.tranamt) = 0 THEN sign(t.tranamt) ELSE sign(t.invtmult*t.tranamt) END END * abs(t.bmitranamt),
		     bmiextcost = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.extcost) = 0 THEN sign(t.extcost) ELSE sign(t.invtmult*t.extcost) END END * abs(t.bmiextcost),
		     Qty = CASE WHEN t.trantype not in ('AJ','PI', 'AC') THEN 1 ELSE CASE WHEN sign(t.invtmult*t.Qty) = 0 THEN sign(t.Qty) ELSE sign(t.invtmult*t.Qty) END END * abs(t.Qty)
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND (CHARINDEX('K',Parm3)>0 OR CHARINDEX('L',Parm3)>0 OR CHARINDEX('M',Parm3)>0) AND CHARINDEX('J',Parm3)= 0 AND parm6 = '0'
END
INSERT INTO #IN10990_Errorlog SELECT msgnbr, parm0, parm1, recordid, 'Qty, Tranamt, Extcost',parm4,parm5,CASE WHEN rtrim(parm4 + parm5) = '' THEN '1' ELSE '2' END
FROM #IN10990_Errorlog WHERE (CHARINDEX('K',Parm3)>0 OR CHARINDEX('L',Parm3)>0 OR CHARINDEX('M',Parm3)>0) AND CHARINDEX('J',Parm3)= 0 AND parm6 = '0'
-- CASE N
INSERT INTO #IN10990_Errorlog SELECT 16376, parm0, parm1, recordid, 'SiteID', '','','1' FROM
#IN10990_Errorlog WHERE CHARINDEX('N',Parm3) > 0  AND parm6 = '0'
-- CASE O
INSERT INTO #IN10990_Errorlog SELECT 16376, parm0, parm1, recordid, 'WhseLoc', '','','1' FROM
#IN10990_Errorlog WHERE CHARINDEX('O',Parm3) > 0  AND parm6 = '0'
-- CASE P
UPDATE #IN10990_Errorlog SET msgnbr = 16376, parm4 = '', parm5 = '' WHERE CHARINDEX('P',Parm3) > 0 AND parm6 = '0'
if @rebuild + @rebuildhist > 0  BEGIN
	UPDATE l SET msgnbr = 16377, parm4 = t.UnitDesc, parm5 = I.StkUnit
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('P',Parm3)>0 AND parm6 = '0'
	INNER JOIN Inventory i on t.InvtID = i.InvtID

	UPDATE t SET UnitDesc = I.StkUnit
	FROM #IN10990_Errorlog l
	INNER JOIN intran t on l.recordid = t.recordid AND CHARINDEX('P',Parm3)>0 AND parm6 = '0'
	INNER JOIN Inventory i on t.InvtID = i.InvtID

	UPDATE t SET  UnitDesc = I.StkUnit
	FROM #IN10990_Errorlog l
	INNER JOIN #IN10990_InTran t on l.recordid = t.recordid AND CHARINDEX('P',Parm3)>0 AND parm6 = '0'
	INNER JOIN Inventory i on t.InvtID = i.InvtID

END

INSERT INTO #IN10990_Errorlog SELECT msgnbr, parm0, parm1, recordid,'UnitDesc',parm4,parm5, CASE WHEN msgnbr = 16376 THEN '1' ELSE '2' END
FROM #IN10990_Errorlog WHERE CHARINDEX('P',Parm3) > 0 AND parm6 = '0'

INSERT INTO #IN10990_Errorlog SELECT 16376, parm0, parm1, recordid,'SpecificCostID',parm4,parm5,'1'
FROM #IN10990_Errorlog WHERE CHARINDEX('Q',Parm3) > 0 AND parm6 = '0'

-- duplicated refnbr critical only if item lotsenumbered, otherwise warning

INSERT INTO #IN10990_Errorlog SELECT 16379, batnbr, lineref,-1, count(lineid),'','',CASE WHEN @lotsertrack <> 'NN' AND @lotserissmthd = 'R' THEN '1' ELSE '2' END FROM #IN10990_InTran
WHERE rtrim(lineref) <> '' AND trantype not in ('CT', 'CG') group by batnbr, lineref
having count(lineid) > 1

-- Sum of ct/cg transactions <> extcost/tranamt
-- Do not use CT/CG transactions FOR transfers unless it is LIFO/FIFO items.
INSERT INTO #IN10990_Errorlog SELECT distinct 16380, t.batnbr, t.lineref, max(t.recordid), '', ROUND(sum(isnull(t1.invtmult*t1.tranamt,0)),@decpl),ROUND(max(CASE WHEN t.trantype in ('IN','II','DM','CM','RI') THEN t.invtmult*t.extcost ELSE t.invtmult*t.tranamt END),@decpl),'0'
FROM #IN10990_InTran t
LEFT JOIN #IN10990_InTran t1 on t.batnbr = t1.batnbr AND t.LineRef = t1.LineRef AND t1.trantype in ('CT','CG') AND t1.OvrhdFlag = 0
WHERE ((t.trantype in ('AS','IN','II','DM') AND t.invtmult = -1) OR t.trantype in (CASE WHEN @valmthd in ('F','L') THEN 'TR' ELSE 'XX' END ,'CM','RI')) AND t.Qty > 0 AND t.S4Future09 = 0
group by t.batnbr, t.lineref
having abs(max(CASE WHEN t.trantype in ('IN','II','DM','CM','RI') THEN t.invtmult*t.extcost ELSE t.invtmult*t.tranamt END) - sum(isnull(t1.invtmult*t1.tranamt,0))) > 0.0000000005

INSERT INTO #IN10990_Errorlog SELECT distinct 16380, t.batnbr, t.linenbr, max(t.recordid), '', ROUND(sum(isnull(t1.invtmult*t1.tranamt,0)),@decpl),ROUND(max(CASE WHEN t.trantype in ('IN','II','DM','CM','RI') THEN t.invtmult*t.extcost ELSE t.invtmult*t.tranamt END),@decpl),'0'
FROM #IN10990_InTran t
LEFT JOIN #IN10990_InTran t1 on t.batnbr = t1.batnbr AND t.LineNbr = t1.LineNbr AND t1.trantype in ('CT','CG') AND t1.OvrhdFlag = 0
WHERE ((t.trantype in ('AS','IN','II','DM') AND t.invtmult = -1) OR t.trantype in (CASE WHEN @valmthd in ('F','L') THEN 'TR' ELSE 'XX' END ,'CM','RI')) AND t.Qty > 0 AND t.S4Future09 = 0
group by t.batnbr, t.linenbr
having abs(max(CASE WHEN t.trantype in ('IN','II','DM','CM','RI') THEN t.invtmult*t.extcost ELSE t.invtmult*t.tranamt END) - sum(isnull(t1.invtmult*t1.tranamt,0))) > 0.0000000005

INSERT INTO #IN10990_Errorlog SELECT 16380, max(parm0), max(parm1), recordid, '', max(parm4), max(parm5), '1'
FROM #IN10990_Errorlog
WHERE MsgNbr = 16380
group by recordid
having count(*) > 1

UPDATE #IN10990_Errorlog SET
	parm4 = LEFT(parm4,ISNULL(NULLIF(CHARINDEX('.',parm4)+@DecPl,@DecPl),30)),
	parm5 = LEFT(parm5,ISNULL(NULLIF(CHARINDEX('.',parm5)+@DecPl,@DecPl),30))
WHERE MsgNbr = 16380 AND parm6 = '1'

DELETE FROM #IN10990_Errorlog WHERE parm6 = '0'

if @lotsertrack <> 'NN' AND @lotserissmthd = 'R' BEGIN
        INSERT INTO #IN10990_Lotsert
	SELECT l.BatNbr,l.INTranLineRef,l.InvtID,l.LineNbr,l.LotSerNbr,
	l.LUpd_DateTime,l.LUpd_Prog,l.Qty,l.RcptNbr,l.recordid,l.RefNbr,
	/*l.Retired,*/l.Rlsed,l.SiteID,l.TranType,l.WhseLoc
	FROM LOTSERT l WHERE l.InvtID = @InvtID
	AND l.SiteID = @siteID
if @rebuild + @rebuildhist > 0  BEGIN
        INSERT #templot SELECT t.batnbr,t.Lineref,t.trantype, sum(CONVERT(dec(28,9),ROUND(abs(CASE WHEN t.UnitMultDiv = 'M' THEN 1/t.CnvFact ELSE t.CnvFact END * t.Qty),@DecPlQty)))
        FROM #IN10990_InTran t LEFT JOIN #IN10990_Lotsert l
	on t.batnbr = l.batnbr
	AND t.lineref = l.intranlineref
	WHERE l.batnbr IS NULL
	group by t.batnbr,t.Lineref,t.trantype

	DECLARE templot_cursor CURSOR FOR
	SELECT * FROM #templot

        open templot_cursor
	fetch templot_cursor INTO @tbatnbr, @tlineref, @ttrantype, @tQty
	while @@fetch_status = 0 BEGIN
		If (SELECT sum(CONVERT(dec(28,9),ROUND(abs(l.Qty),@DecPlQty))) FROM #IN10990_Lotsert l LEFT JOIN #IN10990_intran t on l.batnbr = t.batnbr AND t.lineref = l.intranlineref WHERE l.batnbr = @tbatnbr AND l.trantype = @ttrantype AND t.batnbr IS NULL) = @tQty
 BEGIN
		  UPDATE l SET intranlineref = @tlineref FROM #IN10990_Lotsert l LEFT JOIN #IN10990_intran t on l.batnbr = t.batnbr AND t.lineref = l.intranlineref WHERE l.batnbr = @tbatnbr AND l.trantype = @ttrantype AND t.batnbr IS NULL
		END ELSE if (SELECT count(l.batnbr) FROM #IN10990_Lotsert l LEFT JOIN #IN10990_intran t on l.batnbr = t.batnbr AND t.lineref = l.intranlineref WHERE l.batnbr = @tbatnbr AND l.trantype = @ttrantype AND t.batnbr IS NULL AND CONVERT(dec(28,9),ROUND(abs(l.Qty),@DecPlQty)) = @tQty ) = 1 BEGIN
		  UPDATE l SET intranlineref = @tlineref FROM #IN10990_Lotsert l LEFT JOIN #IN10990_intran t on l.batnbr = t.batnbr AND t.lineref = l.intranlineref WHERE l.batnbr = @tbatnbr AND l.trantype = @ttrantype AND t.batnbr IS NULL AND CONVERT(dec(28,9),ROUND(abs(l.Qty),@DecPlQty)) = @tQty
		END
		fetch next FROM templot_cursor INTO @tbatnbr, @tlineref, @ttrantype, @tQty
	END
	close templot_cursor
	deallocate templot_cursor
END

INSERT INTO #IN10990_Errorlog SELECT distinct 16381, t.batnbr, t.lineref,max(t.recordid), '', max(CONVERT(dec(28,9), ROUND(t.qty,@DecPlQty))),isnull(sum(CONVERT(dec(28,9), ROUND(l.Qty,@DecPlQty))),0),'1'
	FROM #IN10990_InTran t LEFT JOIN #IN10990_Lotsert l
        on t.batnbr = l.batnbr
	AND t.lineref = l.intranlineref
	WHERE t.trantype not in ('CG', 'CT')
	AND t.S4Future09 = 0
	AND (t.LotSerCntr > 0 OR l.batnbr IS NOT NULL)
	AND t.TranDesc NOT IN ('Adj Tran for Ovrsld Invt Item', 'Reverse of Orig Tran Ovrsld')
        group by t.batnbr,t.lineref
	having
	abs(abs(ROUND(sum(isnull(l.Qty,0)),@DecPlQty))- abs(max(ROUND(t.qty,@DecPlQty)))) > 0.0000000005

UPDATE #IN10990_Errorlog SET
	parm4 = LEFT(CONVERT(CHAR(30),parm4),ISNULL(NULLIF(CHARINDEX('.',CONVERT(CHAR(30),parm4))+@DecPlQty,@DecPlQty),30)),
	parm5 = LEFT(CONVERT(CHAR(30),parm5),ISNULL(NULLIF(CHARINDEX('.',CONVERT(CHAR(30),parm5))+@DecPlQty,@DecPlQty),30))
WHERE MsgNbr = 16381 AND parm6 = '1'

END

if @valmthd = 'F' BEGIN

INSERT INTO #layers
SELECT '',rcptnbr = CASE WHEN trantype in ('RC','AS') THEN refnbr
   		 WHEN trantype in ('CT','CG') AND (Qty*invtmult) < 0 AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900'))THEN 'OVRSLD'
   		 WHEN trantype in ('CT','CG') AND (Qty*invtmult) > 0 AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900'))THEN 'INTEGRITY'
   		 ELSE rcptnbr END,
          rcptdate = CASE WHEN trantype in ('AS') THEN TranDate
     		WHEN trantype in ('CT','CG') AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900')) THEN TranDate
     		ELSE rcptdate END,
          Qty = sum(t.InvtMult * t.Qty),
          totcost = sum(t.invtmult * CASE WHEN t.trantype in ('IN','II','DM','CM', 'RI') THEN t.extcost ELSE t.tranamt END),
	  bmitotcost = sum(t.invtmult * CASE WHEN t.trantype in ('IN','II','DM','CM', 'RI') THEN t.bmiextcost ELSE t.bmitranamt END)
FROM #IN10990_InTran t
WHERE ((trantype not in ('IN','II','DM','CM', 'RI','TR','PI','CT','CG') AND t.invtmult = 1)
        OR (trantype  = 'PI' and not exists(select * from #IN10990_InTran where trantype='CT' and batnbr=t.batnbr and lineref=t.lineref))
        OR (trantype  IN ('AB','AJ'))
        OR t.trantype in ('CT','CG') and (t.invtmult <> 1 or not exists(select * from #IN10990_InTran where trantype='as' and batnbr=t.batnbr and lineref=t.lineref))
        ) AND  S4Future09 = 0 and ToSiteID = 0
group by
CASE WHEN trantype in ('RC','AS') THEN refnbr
     WHEN trantype in ('CT','CG') AND (Qty*invtmult) < 0 AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900'))THEN 'OVRSLD'
     WHEN trantype in ('CT','CG') AND (Qty*invtmult) > 0 AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900'))THEN 'INTEGRITY'
     ELSE rcptnbr END,
CASE WHEN trantype in ('AS') THEN TranDate
     WHEN trantype in ('CT','CG') AND  (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900')) THEN TranDate
     ELSE rcptdate END

BEGIN
	SELECT @qty = sum(Qty), @totcost = sum(Totcost), @bmitotcost = sum(bmiTotcost) FROM #layers WHERE Qty < 0 OR Totcost < 0
	DELETE FROM #layers WHERE Qty < 0 OR Totcost < 0


	if ( @qty IS NULL ) BEGIN
		SELECT @qty = 0
	END
	if ( @totcost IS NULL ) BEGIN
		SELECT @totcost = 0
	END
	IF ( @bmitotcost IS NULL ) BEGIN
		SELECT @bmitotcost = 0
	END


	DECLARE layer_cursor CURSOR FOR
	SELECT qty, totcost, bmitotcost FROM #layers ORder by rcptdate
	FOR UPDATE of qty, totcost, bmitotcost

	OPEN layer_cursor
	FETCH FROM layer_cursor INTO @tqty, @ttotcost, @tbmitotcost
	While @@fetch_status = 0 AND (@qty < 0 OR @totcost< 0)
	BEGIN
		if (@tqty + @qty) < 0 BEGIN
			SELECT @qty = @tqty + @qty, @totcost = @totcost + @ttotcost, @bmitotcost = @bmitotcost + @tbmitotcost
			SELECT @tQty = 0, @ttotcost = 0, @tbmitotcost = 0
		END ELSE BEGIN
			SELECT @tqty = @tqty + @qty, @ttotcost = @totcost + @ttotcost, @tbmitotcost = @bmitotcost + @tbmitotcost
			SELECT @Qty = 0, @totcost = 0, @bmitotcost = 0
		END
		if @ttotcost < 0 BEGIN
		  	SELECT @totcost = @ttotcost, @bmitotcost = @tbmitotcost
			SELECT @ttotcost = 0, @tbmitotcost = 0
		END
		UPDATE #layers SET qty = @tqty, totcost = @ttotcost, bmitotcost = @tbmitotcost WHERE current of layer_cursor
		FETCH NEXT FROM layer_cursor INTO @tqty, @ttotcost, @tbmitotcost
	END
	CLOSE layer_cursor
	DEALLOCATE layer_cursor
	DELETE FROM #layers WHERE Qty = 0 AND totcost = 0
	If (@Qty <> 0 OR @totcost <> 0) BEGIN
	INSERT INTO #layers SELECT '','OVRSLD','01/01/1900',@qty, @totcost, @bmitotcost
	END

END

END

If @valmthd = 'L' BEGIN
INSERT INTO #layers
SELECT '',rcptnbr = CASE WHEN trantype in ('RC','AS') THEN refnbr
   		 WHEN trantype in ('CT','CG') AND (Qty*invtmult) < 0 AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900'))THEN 'OVRSLD'
   		 WHEN trantype in ('CT','CG') AND (Qty*invtmult) > 0 AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900'))THEN 'INTEGRITY'
   		 ELSE rcptnbr END,
          rcptdate = CASE WHEN trantype in ('RC','AS') THEN TranDate
     		WHEN trantype in ('CT','CG') AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900')) THEN TranDate
     		ELSE rcptdate END,
          Qty = sum(t.InvtMult * t.Qty),
          totcost = sum(t.invtmult * CASE WHEN t.trantype in ('IN','II','DM','CM', 'RI') THEN t.extcost ELSE t.tranamt END),
	  bmitotcost = sum(t.invtmult * CASE WHEN t.trantype in ('IN','II','DM','CM', 'RI') THEN t.bmiextcost ELSE t.bmitranamt END)
FROM #IN10990_InTran t
WHERE ((trantype not in ('IN','II','DM','CM', 'RI','TR','PI','CT','CG') AND t.invtmult = 1)
        OR (trantype  = 'PI' and not exists(select * from #IN10990_InTran where trantype='CT' and batnbr=t.batnbr and lineref=t.lineref))
        OR (trantype  IN ('AB','AJ'))
        OR t.trantype in ('CT','CG') and (t.invtmult <> 1 or not exists(select * from #IN10990_InTran where trantype='as' and batnbr=t.batnbr and lineref=t.lineref))
       ) AND  S4Future09 = 0 and ToSiteId = 0
group by
CASE WHEN trantype in ('RC','AS') THEN refnbr
     WHEN trantype in ('CT','CG') AND (Qty*invtmult) < 0 AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900'))THEN 'OVRSLD'
     WHEN trantype in ('CT','CG') AND (Qty*invtmult) > 0 AND (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900'))THEN 'INTEGRITY'
     ELSE rcptnbr END,
CASE WHEN trantype in ('RC','AS') THEN TranDate
     WHEN trantype in ('CT','CG') AND  (rcptnbr = '' OR (rcptnbr = '' AND rcptdate = '01/01/1900')) THEN TranDate
     ELSE rcptdate END

if (SELECT count(*) FROM #layers WHERE qty < 0 OR Totcost < 0) > 0
BEGIN
	INSERT #layers1 SELECT * FROM #layers WHERE Qty < 0 OR Totcost < 0
	DELETE FROM #layers WHERE Qty < 0 OR Totcost < 0

	DECLARE layer_cursor1 CURSOR FOR
	SELECT qty, totcost, bmitotcost, rcptdate FROM #layers1 ORder by rcptdate
	FOR UPDATE of qty, totcost, bmitotcost

	OPEN layer_cursor1
	FETCH FROM layer_cursor1 INTO @qty, @totcost,@bmitotcost, @rcptdate
	While @@fetch_status = 0 BEGIN
			DECLARE layer_cursor CURSOR FOR
		SELECT qty, totcost, bmitotcost FROM #layers WHERE rcptdate <= @rcptdate ORder by rcptdate desc
		FOR UPDATE of qty, totcost, bmitotcost

		OPEN layer_cursor
		FETCH FROM layer_cursor INTO @tqty, @ttotcost, @tbmitotcost
	        While @@fetch_status = 0  AND (@qty < 0 OR @totcost< 0)  BEGIN
			if (@tqty + @qty) < 0 BEGIN
				SELECT @qty = @tqty + @qty, @totcost = @totcost + @ttotcost, @bmitotcost = @bmitotcost + @tbmitotcost
				SELECT @tQty = 0, @ttotcost = 0, @tbmitotcost = 0
			END ELSE BEGIN
				SELECT @tqty = @tqty + @qty, @ttotcost = @totcost + @ttotcost, @tbmitotcost = @bmitotcost + @tbmitotcost
				SELECT @Qty = 0, @totcost = 0, @bmitotcost = 0
			END
			if @ttotcost < 0 BEGIN
		  		SELECT @totcost = @ttotcost, @bmitotcost = @tbmitotcost
				SELECT @ttotcost = 0, @tbmitotcost = 0
			END
			UPDATE #layers SET qty = @tqty, totcost = @ttotcost, bmitotcost = @tbmitotcost WHERE current of layer_cursor
			FETCH NEXT FROM layer_cursor INTO @tqty, @ttotcost,  @tbmitotcost
		END
		CLOSE layer_cursor
		DEALLOCATE layer_cursor
        UPDATE #layers1 SET qty = @qty, totcost = @totcost, bmitotcost = @bmitotcost WHERE current of layer_cursor1
	FETCH FROM layer_cursor1 INTO @qty, @totcost, @bmitotcost, @rcptdate
	END
	CLOSE layer_cursor1

If (SELECT  count(*) FROM #layers1 WHERE Qty <> 0 OR totcost <> 0)> 0 BEGIN
	INSERT INTO #layers SELECT '','OVRSLD','01/01/1900',sum(qty), sum(totcost), sum(bmitotcost) FROM #layers1
END

--repeat once again using FIFO
if (SELECT count(*) FROM #layers WHERE qty < 0 OR Totcost < 0) > 0
BEGIN
	SELECT @qty = sum(Qty), @totcost = sum(Totcost), @bmitotcost = sum(bmiTotcost) FROM #layers WHERE Qty < 0 OR Totcost < 0
	        DELETE FROM #layers WHERE Qty < 0 OR Totcost < 0
		DECLARE layer_cursor CURSOR FOR
	SELECT qty, totcost, bmitotcost FROM #layers ORder by rcptdate
	FOR UPDATE of qty, totcost, bmitotcost

	OPEN layer_cursor
	FETCH FROM layer_cursor INTO @tqty, @ttotcost, @tbmitotcost

        While @@fetch_status = 0 AND (@qty < 0 OR @totcost< 0)
	BEGIN
		if (@tqty + @qty) < 0 BEGIN
			SELECT @qty = @tqty + @qty, @totcost = @totcost + @ttotcost, @bmitotcost = @bmitotcost + @tbmitotcost
			SELECT @tQty = 0, @ttotcost = 0, @tbmitotcost = 0
		END ELSE BEGIN
			SELECT @tqty = @tqty + @qty, @ttotcost = @totcost + @ttotcost, @tbmitotcost = @bmitotcost + @tbmitotcost
			SELECT @Qty = 0, @totcost = 0, @bmitotcost = 0
		END
		if @ttotcost < 0 BEGIN
		  	SELECT @totcost = @ttotcost, @bmitotcost = @tbmitotcost
			SELECT @ttotcost = 0, @tbmitotcost = 0
		END
		UPDATE #layers SET qty = @tqty, totcost = @ttotcost, bmitotcost = @tbmitotcost WHERE current of layer_cursor
		FETCH NEXT FROM layer_cursor INTO @tqty, @ttotcost,  @tbmitotcost
	END
	CLOSE layer_cursor
	DEALLOCATE layer_cursor
	DELETE FROM #layers WHERE Qty = 0 AND totcost = 0
	If @Qty <> 0 OR @totcost <> 0 BEGIN
	INSERT INTO #layers SELECT '','OVRSLD','01/01/1900',@qty, @totcost, @bmitotcost
	END
END

END

END
DELETE FROM #LAYERS WHERE QTY = 0 AND TOTCOST = 0

If @valmthd = 'S' BEGIN
--some old version of INBR did not INSERTed ct-cg transactions FOR transfers.
	INSERT #layers
	SELECT SpecificCostID,'',
       		'01/01/1900',
       		Qty = sum(t.InvtMult * t.Qty ),
       		totcost = sum(t.invtmult * CASE WHEN t.trantype in ('IN','II','DM','CM', 'RI') THEN t.extcost ELSE t.tranamt END),
		bmitotcost = sum(t.invtmult * CASE WHEN t.trantype in ('IN','II','DM','CM', 'RI') THEN t.bmiextcost ELSE t.bmitranamt END)
	FROM #IN10990_InTran t
	WHERE trantype not in ('CT', 'CG') AND  S4Future09 = 0 and ToSiteID = 0
	group by SpecificCostID
--DELETE FROM #layers WHERE Qty = 0 AND totcost = 0
END

SELECT	@Qty = 0, @TotCost = 0, @tQty = 0, @tTotCost = 0, @lQty = 0
SELECT 	@Qty = COALESCE(ROUND(SUM(InvtMult * Qty), @DecPlQty),0),
	@TotCost = COALESCE(ROUND(SUM(invtmult * CASE WHEN trantype in ('IN','II','DM','CM', 'RI') THEN extcost ELSE tranamt END), @DecPl),0)
FROM	#IN10990_InTran WHERE trantype NOT IN ('CT', 'CG') AND  S4Future09 = 0
IF @valmthd IN ('S', 'F', 'L')
SELECT 	@tQty = COALESCE(ROUND(SUM(Qty), @DecPlQty),0),
	@tTotCost = COALESCE(ROUND(SUM(TotCost), @DecPl),0)
FROM	#layers
IF @lotsertrack <> 'NN' AND @lotserissmthd = 'R'
SELECT	@lQty = COALESCE(ROUND(SUM(SIGN(t.InvtMult * t.Qty) * ABS(l.Qty)), @DecPlQty),0)
FROM	#IN10990_intran t INNER JOIN
	#IN10990_Lotsert l ON t.BatNbr = l.BatNbr AND t.LineRef = l.INTranLineRef
WHERE	t.S4Future09 = 0 AND t.TranType NOT IN ('CT', 'CG')
INSERT	INTO #IN10990_Errorlog
SELECT	16386, LEFT(CONVERT(CHAR(30),@Qty),ISNULL(NULLIF(CHARINDEX('.',CONVERT(CHAR(30),@Qty))+@DecPlQty,@DecPlQty),30)),
		LEFT(CONVERT(CHAR(30),@TotCost),ISNULL(NULLIF(CHARINDEX('.',CONVERT(CHAR(30),@TotCost))+@DecPl,@DecPl),30)), 0,
		LEFT(CONVERT(CHAR(30),@tQty),ISNULL(NULLIF(CHARINDEX('.',CONVERT(CHAR(30),@tQty))+@DecPlQty,@DecPlQty),30)),
		LEFT(CONVERT(CHAR(30),@tTotCost),ISNULL(NULLIF(CHARINDEX('.',CONVERT(CHAR(30),@tTotCost))+@DecPl,@DecPl),30)),
		LEFT(CONVERT(CHAR(30),@lQty),ISNULL(NULLIF(CHARINDEX('.',CONVERT(CHAR(30),@lQty))+@DecPlQty,@DecPlQty),30)),
	CASE WHEN @valmthd IN ('S', 'F', 'L') AND (@Qty <> @tQty OR @TotCost <> @tTotCost) OR @lotsertrack <> 'NN' AND @lotserissmthd = 'R' AND @Qty <> @lQty THEN '1' ELSE '2' END

IF EXISTS(SELECT * FROM #IN10990_Errorlog WHERE parm6 = '1') GOTO Fatal

IF @rebuild = 1 BEGIN

UPDATE	i SET
	QtyOnHand = ROUND(COALESCE(s.Qty, 0), @DecPlQty),
	TotCost = CASE @valmthd WHEN 'U' THEN 0 ELSE ROUND(COALESCE(s.TotCost, 0), @DecPl) END,
	BMITotCost = CASE @valmthd WHEN 'U' THEN 0 ELSE ROUND(COALESCE(s.BMITotCost, 0), @BMIDecPl) END
FROM	ItemSite i LEFT JOIN (
	SELECT 	Qty = SUM(InvtMult * Qty),
		TotCost = SUM(invtmult * CASE WHEN trantype in ('IN','II','DM','CM', 'RI') THEN extcost ELSE tranamt END),
		BMITotCost = SUM(invtmult * CASE WHEN trantype in ('IN','II','DM','CM', 'RI') THEN bmiextcost ELSE bmitranamt END)
	FROM	#IN10990_InTran WHERE trantype NOT IN ('CT', 'CG') AND  S4Future09 = 0
	) s ON 1 = 1
WHERE	i.InvtID = @InvtID AND i.SiteID = @SiteID
IF @@ERROR <> 0 GOTO Err

UPDATE	ItemSite SET
	AvgCost = CASE QtyOnHand WHEN 0 THEN 0 ELSE ROUND(TotCost / QtyOnHand, @DecPlPrcCst) END,
	BMIAvgCost = CASE QtyOnHand WHEN 0 THEN 0 ELSE ROUND(BMITotCost / QtyOnHand, @DecPlPrcCst) END,
	LUpd_Prog = CASE LUpd_Prog WHEN '09901' THEN '10990' ELSE LUpd_Prog END
WHERE	InvtID = @InvtID AND SiteID = @SiteID
IF @@ERROR <> 0 GOTO Err

INSERT	Location (InvtId, SiteId, WhseLoc, Crtd_Prog, Crtd_DateTime, Crtd_User, LUpd_Prog, LUpd_DateTime, LUpd_User)
SELECT	@InvtID, @SiteID, t.WhseLoc, '10990', GETDATE(), @user, '10990', GETDATE(), @user
FROM	#IN10990_InTran t LEFT JOIN
	Location l ON l.InvtID = @InvtID AND l.SiteID = @SiteID AND l.WhseLoc = t.WhseLoc
WHERE	t.TranType NOT IN ('CT', 'CG') AND  t.S4Future09 = 0  AND l.WhseLoc IS NULL
GROUP	BY t.WhseLoc
HAVING	ROUND(SUM(InvtMult * Qty), @DecPlQty) <> 0
IF @@ERROR <> 0 GOTO Err

UPDATE	l SET
	QtyOnHand = ROUND(COALESCE(s.Qty, 0), @DecPlQty)
FROM	Location l LEFT JOIN (
	SELECT	WhseLoc,
		Qty = SUM(InvtMult * Qty)
	FROM	#IN10990_InTran WHERE trantype NOT IN ('CT', 'CG') AND  S4Future09 = 0
	GROUP	BY WhseLoc
	) s ON s.WhseLoc = l.WhseLoc
WHERE	l.InvtID = @InvtID AND l.SiteID = @SiteID
IF @@ERROR <> 0 GOTO Err

IF @valmthd IN ('S', 'F', 'L') BEGIN

IF @valmthd = 'S' BEGIN

INSERT	ItemCost (InvtID, SiteID, SpecificCostID, RcptNbr, RcptDate, Crtd_Prog, Crtd_DateTime, Crtd_User, LUpd_Prog, LUpd_DateTime, LUpd_User)
SELECT	@Invtid, @SiteID, l.SpecificCostID, MAX(l.RcptNbr), MAX(l.RcptDate), '10990', GETDATE(), @user, '10990', GETDATE(), @user
FROM	#layers l LEFT JOIN
	ItemCost c ON c.InvtID = @InvtID AND c.SiteID = @SiteID AND c.SpecificCostID = l.SpecificCostID AND c.LayerType = 'S'
WHERE	c.InvtID IS NULL
GROUP	BY l.SpecificCostID
IF @@ERROR <> 0 GOTO Err

UPDATE	c SET
	Qty = ROUND(COALESCE(l.Qty, 0), @DecPlQty),
	TotCost = ROUND(COALESCE(l.TotCost, 0), @DecPl),
	BMITotCost = ROUND(COALESCE(l.BMITotCost, 0), @BMIDecPl),
	UnitCost = CASE WHEN ROUND(COALESCE(l.Qty, 0), @DecPlQty) = 0 THEN UnitCost ELSE ROUND ( ROUND(COALESCE(l.TotCost, 0), @DecPl) / ROUND(COALESCE(l.Qty, 0), @DecPlQty), @DecPlPrcCst) END
FROM	ItemCost c LEFT JOIN
	#layers l on c.SpecificCostID = l.SpecificCostID
WHERE	c.InvtID = @InvtID AND c.SiteID = @SiteID AND c.LayerType = 'S'
IF @@ERROR <> 0 GOTO Err

END ELSE BEGIN

INSERT	ItemCost (InvtID, SiteID, SpecificCostID, RcptNbr, RcptDate, Crtd_Prog, Crtd_DateTime, Crtd_User, LUpd_Prog, LUpd_DateTime, LUpd_User)
SELECT	@Invtid, @SiteID, MAX(l.SpecificCostID), l.RcptNbr, l.RcptDate, '10990', GETDATE(), @user, '10990', GETDATE(), @user
FROM	#layers l LEFT JOIN
	ItemCost c ON c.InvtID = @InvtID AND c.SiteID = @SiteID AND c.RcptNbr = l.RcptNbr AND c.RcptDate = l.RcptDate AND c.LayerType = 'S'
WHERE	c.InvtID IS NULL
GROUP	BY l.RcptNbr, l.RcptDate
IF @@ERROR <> 0 GOTO Err

UPDATE	c SET
	Qty = ROUND(COALESCE(l.Qty, 0), @DecPlQty),
	TotCost = ROUND(COALESCE(l.TotCost, 0), @DecPl),
	BMITotCost = ROUND(COALESCE(l.BMITotCost, 0), @BMIDecPl),
	UnitCost = CASE WHEN ROUND(COALESCE(l.Qty, 0), @DecPlQty) = 0 THEN UnitCost ELSE ROUND ( ROUND(COALESCE(l.TotCost, 0), @DecPl) / ROUND(COALESCE(l.Qty, 0), @DecPlQty), @DecPlPrcCst) END
FROM	ItemCost c INNER JOIN #layers l ON c.RcptNbr = l.RcptNbr AND c.RcptDate = l.RcptDate
WHERE	c.InvtID = @InvtID AND c.SiteID = @SiteID AND c.layertype = 'S'
IF @@ERROR <> 0 GOTO Err

DELETE	c
FROM	ItemCost c LEFT JOIN
	#layers l on c.RcptNbr = l.RcptNbr AND c.RcptDate = l.RcptDate
WHERE	c.InvtID = @InvtID AND c.SiteID = @SiteID AND c.LayerType = 'S' AND l.RcptNbr IS NULL
IF @@ERROR <> 0 GOTO Err

END

END

	declare	@OptWOFirmRlsedDemand char (1)

	select		@OptWOFirmRlsedDemand = Left(S4Future11,1)
	from		WOSetup (NOLOCK)
	where		Init = 'Y'

	update	Location
	set	QtyAllocBM = isnull((select round(sum(BOMTran.CmpnentQty), @DecPlQty)
				from	BOMDoc, BOMTran, LocTable
				where	BOMTran.CmpnentID = Location.InvtID
				and	BOMTran.SiteID = Location.SiteID
				and	BOMTran.WhseLoc = Location.WhseLoc
				and	BOMDoc.RefNbr = BOMTran.RefNbr
				and	BOMDoc.Rlsed = 0
				and	BOMTran.CmpnentQty > 0
				and	BOMTran.SiteID = LocTable.SiteID
				and	BOMTran.WhseLoc = LocTable.WhseLoc
				and	LocTable.InclQtyAvail = 1
				and	not exists(select * from INTran where INTran.BatNbr = BOMTran.BatNbr and INTran.LineRef = BOMTran.LineRef)), 0)
	where	Location.InvtID = @InvtID
	and	Location.SiteID = @SiteID
	IF @@ERROR <> 0 GOTO Err

	update	Location
	set	QtyAllocPORet = isnull((select round(sum(case when POTran.UnitMultDiv = 'D' then
						case when POTran.CnvFact <> 0 then
							round(POTran.Qty / POTran.CnvFact, @DecPlQty)
						else
							0
						end
						else
							round(POTran.Qty * POTran.CnvFact, @DecPlQty)
						end), @DecPlQty)
				from	POReceipt, POTran, LocTable
				where	POTran.InvtID = Location.InvtID
				and	POTran.SiteID = Location.SiteID
				and	POTran.WhseLoc = Location.WhseLoc
				and	POReceipt.RcptNbr = POTRan.RcptNbr
				and	POTran.TranType = 'X'
				and	POTran.PurchaseType IN ('GI','PI')
				and	POReceipt.Rlsed = 0
				and	POTran.SiteID = LocTable.SiteID
				and	POTran.WhseLoc = LocTable.WhseLoc
				and	LocTable.InclQtyAvail = 1), 0)
	where	Location.InvtID = @InvtID
	and	Location.SiteID = @SiteID
	IF @@ERROR <> 0 GOTO Err

	update	Location
	set	QtyAllocSD = isnull((select round(sum(
						case when COALESCE(u1.MultDiv, u2.MultDiv, u3.MultDiv, 'M') = 'D' then
						case when COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1) <> 0 then
							round(smServDetail.Quantity / COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), @DecPlQty)
						else
							0
						end
						else
							round(smServDetail.Quantity * COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), @DecPlQty)
						end), @DecPlQty)
				FROM	smServCall
				JOIN	smServDetail ON
					smServCall.ServiceCallID = smServDetail.ServiceCallID
				JOIN	LocTable ON
					smServDetail.SiteID = LocTable.SiteID
					AND smServDetail.WhseLoc = LocTable.WhseLoc
				JOIN	Inventory ON smServDetail.InvtID = Inventory.InvtID
				LEFT JOIN INUnit u1 ON
					u1.FromUnit = Inventory.DfltSOUnit
					AND u1.ToUnit = Inventory.StkUnit
					AND u1.UnitType = '3'
					AND u1.InvtID = Inventory.InvtID
				LEFT JOIN INUnit u2 ON
					u2.FromUnit = Inventory.DfltSOUnit
					AND u2.ToUnit = Inventory.StkUnit
					AND u2.UnitType = '2'
					AND u2.ClassID = Inventory.ClassID
				LEFT JOIN INUnit u3 ON
					u3.FromUnit = Inventory.DfltSOUnit
					AND u3.ToUnit = Inventory.StkUnit
					AND u3.UnitType = '1'
				WHERE	smServDetail.InvtId = Location.InvtID
					AND smServDetail.SiteID = Location.SiteID
					AND smServDetail.WhseLoc = Location.WhseLoc
					AND smServDetail.INBatNbr = '' -- grab only the trans that aren't in an IN batch yet
					AND smServDetail.Quantity > 0
					AND LocTable.InclQtyAvail = 1), 0)
	where	Location.InvtID = @InvtID
	and	Location.SiteID = @SiteID
	IF @@ERROR <> 0 GOTO Err

	update	L
	set	QtyAllocBM = round(L.QtyAllocBM + isnull(D.QtyAllocBM, 0), @DecPlQty),
		QtyAllocIN = round(isnull(D.QtyAllocIN, 0), @DecPlQty),
		QtyAllocPORet = round(L.QtyAllocPORet + isnull(D.QtyAllocPORet, 0), @DecPlQty),
		QtyAllocSD = round(L.QtyAllocSD + isnull(D.QtyAllocSD, 0), @DecPlQty)
	from	Location L
	left join
		(select INTran.InvtID, INTran.SiteID, INTran.WhseLoc,
				QtyAllocBM = round(sum(case when INTran.JrnlType = 'BM' then
						case when INTran.UnitMultDiv = 'D' then
						case when INTran.CnvFact <> 0 then
							round(-INTran.InvtMult*INTran.Qty / INTran.CnvFact, @DecPlQty)
						else
							0
						end
						else
							round(-INTran.InvtMult*INTran.Qty * INTran.CnvFact, @DecPlQty)
						end else 0 end), @DecPlQty),
				QtyAllocIN = round(sum(case when INTran.JrnlType = 'IN' and INTran.Crtd_Prog not like 'SD%' then
						case when INTran.UnitMultDiv = 'D' then
						case when INTran.CnvFact <> 0 then
							round(-INTran.InvtMult*INTran.Qty / INTran.CnvFact, @DecPlQty)
						else
							0
						end
						else
							round(-INTran.InvtMult*INTran.Qty * INTran.CnvFact, @DecPlQty)
						end else 0 end), @DecPlQty),
				QtyAllocPORet = round(sum(case when INTran.JrnlType = 'PO' then
						case when INTran.UnitMultDiv = 'D' then
						case when INTran.CnvFact <> 0 then
							round(-INTran.InvtMult*INTran.Qty / INTran.CnvFact, @DecPlQty)
						else
							0
						end
						else
							round(-INTran.InvtMult*INTran.Qty * INTran.CnvFact, @DecPlQty)
						end else 0 end), @DecPlQty),
				QtyAllocSD = round(sum(case when INTran.Crtd_Prog LIKE 'SD%' then
						case when INTran.UnitMultDiv = 'D' then
						case when INTran.CnvFact <> 0 then
							round(-INTran.InvtMult*INTran.Qty / INTran.CnvFact, @DecPlQty)
						else
							0
						end
						else
							round(-INTran.InvtMult*INTran.Qty * INTran.CnvFact, @DecPlQty)
						end else 0 end), @DecPlQty)
				from	INTran, LocTable
				where	INTran.S4Future09 = 0
				and	INTran.Rlsed = 0
				and	(INTran.TranType IN ('II','IN','DM','TR')
				or	INTran.TranType = 'AS' and INTran.InvtMult = -1
				or	INTran.TranType = 'AJ' and INTran.Qty < 0)
				and	INTran.SiteID = LocTable.SiteID
				and	INTran.WhseLoc = LocTable.WhseLoc
				and	LocTable.InclQtyAvail = 1
				group by INTran.InvtID, INTran.SiteID, INTran.WhseLoc) D
	on	L.InvtID = D.InvtID
	and	L.SiteID = D.SiteID
	and	L.WhseLoc = D.WhseLoc
	where	L.InvtID = @InvtID
	and	L.SiteID = @SiteID
	IF @@ERROR <> 0 GOTO Err
		UPDATE	Location
	SET	QtyWORlsedDemand = Coalesce(D.Qty_RD,0),
		S4Future03 = Coalesce(D.Qty_FM,0)
	FROM	Location
	LEFT JOIN
		(SELECT	Round(Sum(CASE WHEN WOHeader.WOType <> 'P'
				AND WOHeader.ProcStage = 'R'
				OR WOHeader.WOType = 'P'
				AND WOTask.ProcStage = 'R' THEN
				WOMatlReq.QtyRemaining ELSE 0 END), @DecPlQty) AS Qty_RD,
			Round(Sum(CASE WHEN WOHeader.WOType <> 'P'
			  	AND WOHeader.ProcStage = 'F'
			  	OR WOHeader.WOType = 'P'
				AND WOTask.ProcStage = 'F' THEN
				WOMatlReq.QtyRemaining ELSE 0 END), @DecPlQty) AS Qty_FM,
				WOMatlReq.WhseLoc, WOMatlReq.InvtID,WOMatlReq.SiteID
			FROM	WOMatlReq

			JOIN 	WOHeader
			  ON 	WOMatlReq.WONbr = WOHeader.WONbr

			JOIN	LocTable
			  ON	LocTable.SiteID = WOMatlReq.SiteID
			 AND	LocTable.WhseLoc = WOMatlReq.WhseLoc
			 AND	LocTable.InclQtyAvail = 1

			LEFT JOIN WOTask
			  ON 	WOMatlReq.WONbr = WOTask.WONbr
			  AND 	WOMatlReq.Task = WOTask.Task

			WHERE	WOMatlReq.InvtID = @InvtID
			  AND 	WOMatlReq.SiteID = @SiteID
			  AND	WOHeader.Status <> 'P'
			  AND 	((WOHeader.WOType <> 'P'
			  		AND WOHeader.ProcStage IN ('R','F'))
			  	OR (WOHeader.WOType = 'P'
					AND WOTask.ProcStage IN ('R','F')))
			  AND	WOMatlReq.QtyRemaining > 0

			GROUP BY WOMatlReq.WhseLoc, WOMatlReq.InvtID, WOMatlReq.SiteID) AS D

		  ON 	D.WhseLoc = Location.WhseLoc
		  AND 	D.InvtId = Location.InvtID
		  AND 	D.SiteID = Location.SiteID

	where	Location.InvtID = @InvtID
	and	Location.SiteID = @SiteID
	IF @@ERROR <> 0 GOTO Err

	update	Location
	set	QtyAvail = round(QtyOnHand
		- QtyAlloc
		- QtyAllocBM
		- QtyAllocIN
		- QtyAllocPORet
		- QtyAllocSD
		- QtyAllocSO
		- QtyShipNotInv
		- QtyAllocProjIN
		+ PrjINQtyAlloc
		+ PrjINQtyShipNotInv
		+ PrjINQtyAllocSO
		+ PrjINQtyAllocIN
		+ PrjINQtyAllocPORet
		- case when @OptWOFirmRlsedDemand in ('F','R') then QtyWORlsedDemand else 0 End
		- case when @OptWOFirmRlsedDemand = 'F' then S4Future03 else 0 end,
		@DecPlQty)
	where	InvtID = @InvtID
	  and	SiteID = @SiteID
	  and	exists (select * from LocTable where SiteID = @SiteID and LocTable.WhseLoc = Location.WhseLoc
	  and	InclQtyAvail = 1)
	IF @@ERROR <> 0 GOTO Err

	UPDATE	ItemSite
	SET	QtyAllocBM = round(coalesce(D.QtyAllocBM, 0), @DecPlQty),
		QtyAllocIN = round(coalesce(D.QtyAllocIN, 0), @DecPlQty),
		QtyAllocPORet = round(coalesce(D.QtyAllocPORet, 0), @DecPlQty),
		QtyAllocSD = round(coalesce(D.QtyAllocSD, 0), @DecPlQty),
		QtyWORlsedDemand = round(coalesce(D.QtyWORlsedDemand, 0), @DecPlQty),
		QtyWOFirmDemand = round(coalesce(D.QtyWOFirmDemand, 0), @DecPlQty)
		FROM	ItemSite
		LEFT JOIN (SELECT Location.InvtID, Location.SiteID,
		QtyAllocBM = sum(QtyAllocBM),
		QtyAllocIN = sum(QtyAllocIN),
		QtyAllocPORet = sum(QtyAllocPORet),
		QtyAllocSD = sum(QtyAllocSD),
		QtyWORlsedDemand = sum(QtyWORlsedDemand),
		QtyWOFirmDemand = sum(S4Future03)
	from	Location
	group by Location.InvtID, Location.SiteID) D

	  ON 	D.InvtID = ItemSite.InvtID
	  AND 	D.SiteID = ItemSite.SiteID

	Where 	ItemSite.InvtID = @InvtID
	  AND 	ItemSite.SiteID = @SiteID
	IF @@ERROR <> 0 GOTO Err

IF @lotsertrack <> 'NN' AND @lotserissmthd = 'R' BEGIN

INSERT	LotSerMst (InvtId, SiteId, WhseLoc, LotSerNbr, Status, Crtd_Prog, Crtd_DateTime, Crtd_User, LUpd_Prog, LUpd_DateTime, LUpd_User)
SELECT	@InvtId, @SiteID, t.WhseLoc, l.LotSerNbr, 'A', '10990', GETDATE(), @user, '10990', GETDATE(), @user
FROM	#IN10990_intran t INNER JOIN
	#IN10990_Lotsert l ON t.BatNbr = l.BatNbr AND t.LineRef = l.INTranLineRef LEFT JOIN
	LotSerMst m ON m.InvtID = @InvtID AND m.SiteID = @SiteID AND m.WhseLoc = t.WhseLoc AND m.LotSerNbr = l.LotSerNbr
WHERE	t.S4Future09 = 0 AND t.TranType NOT IN ('CT', 'CG') AND m.InvtID IS NULL
GROUP	BY t.WhseLoc, l.LotSerNbr
IF @@ERROR <> 0 GOTO Err

UPDATE	m SET
	QtyOnHand = CASE WHEN s.Qty IS NULL THEN CASE m.Status WHEN 'A' THEN 0 ELSE m.QtyOnHand END ELSE s.Qty END
FROM	LotSerMst m LEFT JOIN (
	SELECT	t.WhseLoc, l.LotSerNbr,
		Qty = ROUND(SUM(SIGN(t.InvtMult * t.Qty) * ABS(l.Qty)), @DecPlQty)
	FROM	#IN10990_intran t INNER JOIN
		#IN10990_Lotsert l ON t.BatNbr = l.BatNbr AND t.LineRef = l.INTranLineRef
	WHERE	t.S4Future09 = 0 AND t.TranType NOT IN ('CT', 'CG')
	GROUP	BY t.SiteID, t.WhseLoc, l.LotSerNbr) s ON s.WhseLoc = m.WhseLoc AND s.LotSerNbr = m.LotSerNbr
WHERE	m.InvtID = @InvtID AND m.SiteID = @SiteID
IF @@ERROR <> 0 GOTO Err

		update	LotSerMst
		set	QtyAllocSD = isnull((select round(sum(
						case when COALESCE(u1.MultDiv, u2.MultDiv, u3.MultDiv, 'M') = 'D' then
						case when COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1) <> 0 then
							round(smServDetail.Quantity / COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), @DecPlQty)
						else
							0
						end
						else
							round(smServDetail.Quantity * COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), @DecPlQty)
						end), @DecPlQty)
				FROM	smServCall
				JOIN	smServDetail ON
					smServCall.ServiceCallID = smServDetail.ServiceCallID
				JOIN	LocTable ON
					smServDetail.SiteID = LocTable.SiteID
					AND smServDetail.WhseLoc = LocTable.WhseLoc
				JOIN	Inventory ON smServDetail.InvtID = Inventory.InvtID
				LEFT JOIN INUnit u1 ON
					u1.FromUnit = Inventory.DfltSOUnit
					AND u1.ToUnit = Inventory.StkUnit
					AND u1.UnitType = '3'
					AND u1.InvtID = Inventory.InvtID
				LEFT JOIN INUnit u2 ON
					u2.FromUnit = Inventory.DfltSOUnit
					AND u2.ToUnit = Inventory.StkUnit
					AND u2.UnitType = '2'
					AND u2.ClassID = Inventory.ClassID
				LEFT JOIN INUnit u3 ON
					u3.FromUnit = Inventory.DfltSOUnit
					AND u3.ToUnit = Inventory.StkUnit
					AND u3.UnitType = '1'
				WHERE	smServDetail.InvtId = LotSerMst.InvtID
					AND smServDetail.SiteID = LotSerMst.SiteID
					AND smServDetail.WhseLoc = LotSerMst.WhseLoc
					AND smServDetail.LotSerialRep = LotSerMst.LotSerNbr
					AND smServDetail.LotSerialRep <> ''
					AND smServDetail.INBatNbr = '' -- grab only the trans that aren't in an IN batch yet
					AND smServDetail.Quantity > 0
					AND LocTable.InclQtyAvail = 1), 0)
		where	LotSerMst.InvtID = @InvtID
		and	LotSerMst.SiteID = @SiteID
		IF @@ERROR <> 0 GOTO Err

		update	M
		set	QtyAllocBM = round(isnull(D.QtyAllocBM, 0), @DecPlQty),
			QtyAllocIN = round(isnull(D.QtyAllocIN, 0), @DecPlQty),
			QtyAllocPORet = round(isnull(D.QtyAllocPORet, 0), @DecPlQty),
			QtyAllocSD = round(M.QtyAllocSD + isnull(D.QtyAllocSD, 0), @DecPlQty)
		from	LotSerMst M
		left join
			(select LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr,
					QtyAllocBM = round(sum(case when LotSerT.TranSrc = 'BM' then
							-LotSerT.InvtMult * LotSerT.Qty else 0 end), @DecPlQty),
					QtyAllocIN = round(sum(case when LotSerT.TranSrc = 'IN' and LotSerT.Crtd_Prog not like 'SD%' then
							-LotSerT.InvtMult * LotSerT.Qty else 0 end), @DecPlQty),
					QtyAllocPORet = round(sum(case when LotSerT.TranSrc = 'PO' then
							-LotSerT.InvtMult * LotSerT.Qty else 0 end), @DecPlQty),
					QtyAllocSD = round(sum(case when LotSerT.Crtd_Prog LIKE 'SD%' then
							-LotSerT.InvtMult * LotSerT.Qty else 0 end), @DecPlQty)
					from	LotSerT, LocTable
					where	LotSerT.InvtMult * LotSerT.Qty < 0
					and	LotSerT.Rlsed = 0
					and	LotSerT.TranType IN ('II','IN','DM','TR','AS','AJ')
					and	LotSerT.SiteID = LocTable.SiteID
					and	LotSerT.WhseLoc = LocTable.WhseLoc
					and	LocTable.InclQtyAvail = 1
					group by LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr) D
		on	M.InvtID = D.InvtID
		and	M.SiteID = D.SiteID
		and	M.WhseLoc = D.WhseLoc
		and	M.LotSerNbr = D.LotSerNbr
		where	M.InvtID = @InvtID
		and	M.SiteID = @SiteID
		IF @@ERROR <> 0 GOTO Err

		UPDATE	LotSerMst
			SET	QtyWORlsedDemand = Coalesce(D.Qty_RD,0)
		FROM	LotSerMst

			LEFT JOIN
				(SELECT	Round(Sum(WOLotSerT.Qty), @DecPlQty) AS Qty_RD,
					WOLotSerT.WhseLoc, WOLotSerT.InvtID, WOLotSerT.SiteID, WOLotSerT.LotSerNbr
				FROM	WOLotSerT

				JOIN 	WOHeader
				  ON 	WOLotSerT.WONbr = WOHeader.WONbr

				JOIN	LocTable
				  ON	LocTable.SiteID = WOLotSerT.SiteID
				 AND	LocTable.WhseLoc = WOLotSerT.WhseLoc
				 AND	LocTable.InclQtyAvail = 1

				LEFT JOIN WOTask
				  ON 	WOLotSerT.WONbr = WOTask.WONbr
				  AND 	WOLotSerT.TaskID = WOTask.Task

				WHERE	WOHeader.Status <> 'P'
				  AND 	((WOHeader.WOType <> 'P'
		  		  AND 	WOHeader.ProcStage = 'R')
			  	   OR	(WOHeader.WOType = 'P'
					AND WOTask.ProcStage = 'R'))
				  AND	(WOLotSerT.Status IN ('A','E'))
				GROUP BY WOLotSerT.WhseLoc, WOLotSerT.InvtID, WOLotSerT.SiteID, WOLotSerT.LotSerNbr) AS D

			   ON 	D.WhseLoc = LotSerMst.WhseLoc
			  AND 	D.InvtId = LotSerMst.InvtID
			  AND 	D.SiteID = LotSerMst.SiteID
			  AND	D.LotSerNbr = LotSerMst.LotSerNbr

		where	LotSerMst.InvtID = @InvtID
		and	LotSerMst.SiteID = @SiteID
		IF @@ERROR <> 0 GOTO Err

		update	LotSerMst
		set	QtyAvail = round(QtyOnHand
			- QtyAlloc
			- QtyAllocBM
			- QtyAllocIN
			- QtyAllocPORet
			- QtyAllocSD
			- QtyAllocSO
			- QtyShipNotInv
			- QtyAllocProjIN
			+ PrjINQtyAlloc
			+ PrjINQtyShipNotInv
			+ PrjINQtyAllocSO
			+ PrjINQtyAllocIN
			+ PrjINQtyAllocPORet
			- case when @OptWOFirmRlsedDemand in ('F','R') then QtyWORlsedDemand else 0 End,
			@DecPlQty)
		where	InvtID = @InvtID
		  and	SiteID = @SiteID
		  and	exists (select * from LocTable where SiteID = @SiteID and LocTable.WhseLoc = LotSerMst.WhseLoc
		  and	InclQtyAvail = 1)
		IF @@ERROR <> 0 GOTO Err

END

END

SELECT @perstart = left(min(perpost),4) FROM #IN10990_InTran
SELECT @permin = min(fiscyr) FROM ItemHist WHERE InvtID = @InvtID AND SiteID = @SiteID

if @perstart is not null
	if @permin is null select @perstart = @perstart + '01'
	else	if @permin < @perstart select @perstart = @permin + '01'
		else select @perstart = @perstart + '01'
else	if @permin is not null select @perstart = @permin + '01'

IF @rebuildhist = 1 AND @perstart IS NOT NULL BEGIN

if @FiscYr <> '' AND LEN(@FiscYr) = 4 AND @FiscYr >= LEFT(@perstart, 4) SET @perstart = RIGHT('0000' + LTRIM(STR(CONVERT(INT, @FiscYr) + 1)),4) + '01'

SELECT 	@MinYr = LEFT(@perstart, 4)
SELECT	@MaxYr = COALESCE(MAX(FiscYr), 0) FROM ItemHist WHERE InvtID = @InvtID AND SiteID = @SiteID
SELECT	@MaxYr = COALESCE(MAX(FiscYr), @MaxYr) FROM #IN10990_InTran WHERE FiscYr > @MaxYr
IF @MaxYr < @CurrYear AND @MaxYr > 0 SELECT @MaxYr = @CurrYear

WHILE @MinYr <= @MaxYr BEGIN

INSERT	INTO #IN10990_InTran
VALUES(	'', 0,
	0, 1, '', '10990SQL',
	0, RIGHT('0000'+LTRIM(STR(@MinYr)),4),
	0,
	@InvtID, 1, 'IN',/*LayerType,*/1, '00001', -32767, 0,
	getdate(), 0, 0, 0, RIGHT('0000'+LTRIM(STR(@MinYr)),4) + '01',
	0,
	0,
	'', '', 0, '', /*Retired,*/1, 0, 0, ' ',@SiteID,
	'', 0, 0,
	'', '', 'RC', '', 'M', /*USETranCost,*/'')
	IF @@ERROR <> 0 GOTO Err

	SET @MinYr = @MinYr + 1

END
 SELECT	InvtID = @InvtID, SiteID = @SiteID, FiscYr = SUBSTRING(t.PerPost, 1, 4),
	--Amount Sold FOR each period.
        PtdSls00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
        PtdSls01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	PtdSls12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType IN ('CM', 'DM','IN')) THEN -T.InvtMult*T.TranAmt ELSE 0 END),
	--Drop Ship Cost Sold FOR each period.
        PTDDShpSls00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
        PTDDShpSls12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	-- Cost Of Goods Sold FOR each period.
	PtdCOGS00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	PtdCOGS12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 <> 2) THEN -InvtMult*T.ExtCost ELSE 0 END),
	--Cost Adjustments FOR each period.
	PtdCostAdjd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	PtdCostAdjd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType in ('AJ', 'AC', 'PI' ,'AB')) THEN InvtMult*T.TranAmt ELSE 0 END),
	--Cost Issued FOR each period
	PtdCostIssd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	PtdCostIssd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AS' AND T.InvtMult = -1)  THEN T.TranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.ExtCost ELSE 0 END),
	--Cost Received FOR each period.
	PtdCostRcvd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	PtdCostRcvd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.TranAmt  ELSE 0 END),
	--Cost Transfer In FOR each period.
	PtdCostTrsfrIn00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
        PtdCostTrsfrIn08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrIn12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.TranAmt ELSE 0 END),
	--Cost Transfer Out FOR each period.
	PtdCostTrsfrOut00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
        PtdCostTrsfrOut08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	PtdCostTrsfrOut12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.TranAmt ELSE 0 END),
	--Adjustment Qty FOR each period.
	PtdQtyAdjd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyAdjd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType in ('AJ','PI','AB')) THEN T.InvtMult*T.Qty ELSE 0 END),
	--Issued Qty FOR each period.
	PtdQtyIssd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
 	PtdQtyIssd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyIssd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND (T.TranType in ('RI','II') OR (T.TranType = 'AS' AND T.InvtMult = -1))) THEN -T.InvtMult*T.Qty ELSE 0 END),
	-- Received Qty FOR each period.
	PtdQtyRcvd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	PtdQtyRcvd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND (T.TranType = 'RC' OR (T.TranType = 'AS' AND T.InvtMult = 1))) THEN T.InvtMult*T.Qty ELSE 0 END),
	--Qty Sold FOR each period.
        PtdQtySls00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PtdQtySls12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType in ('CM', 'DM', 'IN') AND T.S4Future09 <> 2) THEN -T.InvtMult*T.Qty ELSE 0 END),
	--Drop Ship Qty Sold FOR each period.
        PTDQtyDShpSls00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
   PTDQtyDShpSls01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
        PTDQtyDShpSls12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType IN ('CM', 'IN') AND T.S4Future09 = 1) THEN -T.InvtMult*T.Qty ELSE 0 END),
	--Qty Transfer In
        PtdQtyTrsfrIn00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrIn12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' AND T.InvtMult = 1) THEN T.Qty ELSE 0 END),
	--Qty Transfer Out
        PtdQtyTrsfrOut00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
        PtdQtyTrsfrOut12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' AND T.InvtMult = -1) THEN T.Qty ELSE 0 END),
	-- BMICost Of Goods Sold FOR each period.
	BMIPtdCOGS00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCOGS12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType IN ('IN','CM','DM') AND T.S4Future09 = 0) THEN -InvtMult*T.BMIExtCost ELSE 0 END),
	--BMICost Adjustments FOR each period.
	BMIPtdCostAdjd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	BMIPtdCostAdjd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType in ('AJ', 'AC', 'PI', 'AB')) THEN InvtMult*T.BMITranAmt ELSE 0 END),
	--BMICost Issued FOR each period
	BMIPtdCostIssd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	BMIPtdCostIssd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType in ('AS', 'TR') AND T.InvtMult = -1)  THEN T.BMITranAmt
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType in ('II', 'RI')) THEN -T.InvtMult*T.BMIExtCost ELSE 0 END),
	--BMICost Received FOR each period.
	BMIPtdCostRcvd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END),
	BMIPtdCostRcvd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND (T.TranType = 'RC' OR (T.TranType in ('AS', 'TR') AND T.InvtMult = 1))) THEN T.BMITranAmt  ELSE 0 END)
INTO	#TempHist
FROM	#IN10990_InTran t
WHERE	t.TranType NOT IN ('CT', 'CG') AND t.PerPost >= @perstart
GROUP	BY SUBSTRING(t.PerPost, 1, 4)
IF @@ERROR <> 0 GOTO Err

-- INSERT ItemHist records that does not exists
INSERT	ItemHist (Crtd_Prog, Crtd_DateTime, Crtd_User, FiscYr, InvtID, LUpd_Prog, LUpd_DateTime, LUpd_User, SiteID)
SELECT	'10990', GETDATE(), @user, t.FiscYr, t.InvtID, '10990', GETDATE(), @user, t.SiteID
FROM	#TempHist t LEFT JOIN
	ItemHist h ON t.FiscYr = h.FiscYr AND t.SiteID = H.SiteID AND t.InvtID = H.InvtID
WHERE	h.fiscYr IS NULL
IF @@ERROR <> 0 GOTO Err

INSERT	Item2Hist (Crtd_Prog, Crtd_DateTime, Crtd_User, FiscYr, InvtID, LUpd_Prog, LUpd_DateTime, LUpd_User, SiteID)
SELECT	'10990', GETDATE(), @user, t.FiscYr, t.InvtID, '10990', GETDATE(), @user, t.SiteID
FROM	#TempHist t LEFT JOIN
	Item2Hist h ON t.FiscYr = h.FiscYr AND t.SiteID = H.SiteID AND t.InvtID = H.InvtID
WHERE	h.fiscYr IS NULL
IF @@ERROR <> 0 GOTO Err

INSERT	ItemBMIHist (Crtd_Prog, Crtd_DateTime, Crtd_User, FiscYr, InvtID, LUpd_Prog, LUpd_DateTime, LUpd_User, SiteID)
SELECT	'10990', GETDATE(), @user, t.FiscYr, t.InvtID, '10990', GETDATE(), @user, t.SiteID
FROM	#TempHist t LEFT JOIN
	ItemBMIHist h ON t.FiscYr = h.FiscYr AND t.SiteID = H.SiteID AND t.InvtID = H.InvtID
WHERE	h.fiscYr IS NULL
IF @@ERROR <> 0 GOTO Err

UPDATE	H SET
	PtdSls00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdSls00 ELSE T.PtdSls00 END,
	PtdSls01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdSls01 ELSE T.PtdSls01 END,
	PtdSls02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdSls02 ELSE T.PtdSls02 END,
	PtdSls03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdSls03 ELSE T.PtdSls03 END,
	PtdSls04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdSls04 ELSE T.PtdSls04 END,
	PtdSls05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdSls05 ELSE T.PtdSls05 END,
	PtdSls06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdSls06 ELSE T.PtdSls06 END,
	PtdSls07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdSls07 ELSE T.PtdSls07 END,
	PtdSls08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdSls08 ELSE T.PtdSls08 END,
	PtdSls09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdSls09 ELSE T.PtdSls09 END,
	PtdSls10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdSls10 ELSE T.PtdSls10 END,
	PtdSls11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdSls11 ELSE T.PtdSls11 END,
	PtdSls12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdSls12 ELSE T.PtdSls12 END,
	PtdDShpSls00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdDShpSls00 ELSE T.PtdDShpSls00 END,
	PtdDShpSls01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdDShpSls01 ELSE T.PtdDShpSls01 END,
	PtdDShpSls02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdDShpSls02 ELSE T.PtdDShpSls02 END,
	PtdDShpSls03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdDShpSls03 ELSE T.PtdDShpSls03 END,
	PtdDShpSls04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdDShpSls04 ELSE T.PtdDShpSls04 END,
	PtdDShpSls05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdDShpSls05 ELSE T.PtdDShpSls05 END,
	PtdDShpSls06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdDShpSls06 ELSE T.PtdDShpSls06 END,
	PtdDShpSls07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdDShpSls07 ELSE T.PtdDShpSls07 END,
	PtdDShpSls08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdDShpSls08 ELSE T.PtdDShpSls08 END,
	PtdDShpSls09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdDShpSls09 ELSE T.PtdDShpSls09 END,
	PtdDShpSls10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdDShpSls10 ELSE T.PtdDShpSls10 END,
	PtdDShpSls11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdDShpSls11 ELSE T.PtdDShpSls11 END,
	PtdDShpSls12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdDShpSls12 ELSE T.PtdDShpSls12 END,
	PtdCOGS00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdCOGS00 ELSE T.PtdCOGS00 END,
	PtdCOGS01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdCOGS01 ELSE T.PtdCOGS01 END,
	PtdCOGS02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdCOGS02 ELSE T.PtdCOGS02 END,
	PtdCOGS03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdCOGS03 ELSE T.PtdCOGS03 END,
	PtdCOGS04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdCOGS04 ELSE T.PtdCOGS04 END,
	PtdCOGS05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdCOGS05 ELSE T.PtdCOGS05 END,
	PtdCOGS06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdCOGS06 ELSE T.PtdCOGS06 END,
	PtdCOGS07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdCOGS07 ELSE T.PtdCOGS07 END,
	PtdCOGS08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdCOGS08 ELSE T.PtdCOGS08 END,
	PtdCOGS09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdCOGS09 ELSE T.PtdCOGS09 END,
	PtdCOGS10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdCOGS10 ELSE T.PtdCOGS10 END,
	PtdCOGS11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdCOGS11 ELSE T.PtdCOGS11 END,
	PtdCOGS12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdCOGS12 ELSE T.PtdCOGS12 END,
	PtdCostAdjd00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdCostAdjd00 ELSE T.PtdCostAdjd00 END,
	PtdCostAdjd01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdCostAdjd01 ELSE T.PtdCostAdjd01 END,
	PtdCostAdjd02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdCostAdjd02 ELSE T.PtdCostAdjd02 END,
	PtdCostAdjd03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdCostAdjd03 ELSE T.PtdCostAdjd03 END,
	PtdCostAdjd04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdCostAdjd04 ELSE T.PtdCostAdjd04 END,
	PtdCostAdjd05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdCostAdjd05 ELSE T.PtdCostAdjd05 END,
	PtdCostAdjd06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdCostAdjd06 ELSE T.PtdCostAdjd06 END,
	PtdCostAdjd07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdCostAdjd07 ELSE T.PtdCostAdjd07 END,
	PtdCostAdjd08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdCostAdjd08 ELSE T.PtdCostAdjd08 END,
	PtdCostAdjd09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdCostAdjd09 ELSE T.PtdCostAdjd09 END,
	PtdCostAdjd10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdCostAdjd10 ELSE T.PtdCostAdjd10 END,
	PtdCostAdjd11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdCostAdjd11 ELSE T.PtdCostAdjd11 END,
	PtdCostAdjd12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdCostAdjd12 ELSE T.PtdCostAdjd12 END,
	PtdCostIssd00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdCostIssd00 ELSE T.PtdCostIssd00 END,
	PtdCostIssd01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdCostIssd01 ELSE T.PtdCostIssd01 END,
	PtdCostIssd02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdCostIssd02 ELSE T.PtdCostIssd02 END,
	PtdCostIssd03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdCostIssd03 ELSE T.PtdCostIssd03 END,
	PtdCostIssd04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdCostIssd04 ELSE T.PtdCostIssd04 END,
	PtdCostIssd05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdCostIssd05 ELSE T.PtdCostIssd05 END,
	PtdCostIssd06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdCostIssd06 ELSE T.PtdCostIssd06 END,
	PtdCostIssd07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdCostIssd07 ELSE T.PtdCostIssd07 END,
	PtdCostIssd08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdCostIssd08 ELSE T.PtdCostIssd08 END,
	PtdCostIssd09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdCostIssd09 ELSE T.PtdCostIssd09 END,
	PtdCostIssd10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdCostIssd10 ELSE T.PtdCostIssd10 END,
	PtdCostIssd11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdCostIssd11 ELSE T.PtdCostIssd11 END,
	PtdCostIssd12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdCostIssd12 ELSE T.PtdCostIssd12 END,
	PtdCostRcvd00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdCostRcvd00 ELSE T.PtdCostRcvd00 END,
	PtdCostRcvd01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdCostRcvd01 ELSE T.PtdCostRcvd01 END,
	PtdCostRcvd02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdCostRcvd02 ELSE T.PtdCostRcvd02 END,
	PtdCostRcvd03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdCostRcvd03 ELSE T.PtdCostRcvd03 END,
	PtdCostRcvd04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdCostRcvd04 ELSE T.PtdCostRcvd04 END,
	PtdCostRcvd05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdCostRcvd05 ELSE T.PtdCostRcvd05 END,
	PtdCostRcvd06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdCostRcvd06 ELSE T.PtdCostRcvd06 END,
	PtdCostRcvd07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdCostRcvd07 ELSE T.PtdCostRcvd07 END,
	PtdCostRcvd08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdCostRcvd08 ELSE T.PtdCostRcvd08 END,
	PtdCostRcvd09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdCostRcvd09 ELSE T.PtdCostRcvd09 END,
	PtdCostRcvd10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdCostRcvd10 ELSE T.PtdCostRcvd10 END,
	PtdCostRcvd11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdCostRcvd11 ELSE T.PtdCostRcvd11 END,
	PtdCostRcvd12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdCostRcvd12 ELSE T.PtdCostRcvd12 END,
	PtdCostTrsfrIn00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdCostTrsfrIn00 ELSE T.PtdCostTrsfrIn00 END,
	PtdCostTrsfrIn01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdCostTrsfrIn01 ELSE T.PtdCostTrsfrIn01 END,
	PtdCostTrsfrIn02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdCostTrsfrIn02 ELSE T.PtdCostTrsfrIn02 END,
	PtdCostTrsfrIn03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdCostTrsfrIn03 ELSE T.PtdCostTrsfrIn03 END,
	PtdCostTrsfrIn04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdCostTrsfrIn04 ELSE T.PtdCostTrsfrIn04 END,
	PtdCostTrsfrIn05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdCostTrsfrIn05 ELSE T.PtdCostTrsfrIn05 END,
	PtdCostTrsfrIn06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdCostTrsfrIn06 ELSE T.PtdCostTrsfrIn06 END,
	PtdCostTrsfrIn07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdCostTrsfrIn07 ELSE T.PtdCostTrsfrIn07 END,
	PtdCostTrsfrIn08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdCostTrsfrIn08 ELSE T.PtdCostTrsfrIn08 END,
	PtdCostTrsfrIn09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdCostTrsfrIn09 ELSE T.PtdCostTrsfrIn09 END,
	PtdCostTrsfrIn10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdCostTrsfrIn10 ELSE T.PtdCostTrsfrIn10 END,
	PtdCostTrsfrIn11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdCostTrsfrIn11 ELSE T.PtdCostTrsfrIn11 END,
	PtdCostTrsfrIn12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdCostTrsfrIn12 ELSE T.PtdCostTrsfrIn12 END,
	PtdCostTrsfrOut00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdCostTrsfrOut00 ELSE T.PtdCostTrsfrOut00 END,
	PtdCostTrsfrOut01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdCostTrsfrOut01 ELSE T.PtdCostTrsfrOut01 END,
	PtdCostTrsfrOut02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdCostTrsfrOut02 ELSE T.PtdCostTrsfrOut02 END,
	PtdCostTrsfrOut03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdCostTrsfrOut03 ELSE T.PtdCostTrsfrOut03 END,
	PtdCostTrsfrOut04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdCostTrsfrOut04 ELSE T.PtdCostTrsfrOut04 END,
	PtdCostTrsfrOut05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdCostTrsfrOut05 ELSE T.PtdCostTrsfrOut05 END,
	PtdCostTrsfrOut06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdCostTrsfrOut06 ELSE T.PtdCostTrsfrOut06 END,
	PtdCostTrsfrOut07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdCostTrsfrOut07 ELSE T.PtdCostTrsfrOut07 END,
	PtdCostTrsfrOut08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdCostTrsfrOut08 ELSE T.PtdCostTrsfrOut08 END,
	PtdCostTrsfrOut09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdCostTrsfrOut09 ELSE T.PtdCostTrsfrOut09 END,
	PtdCostTrsfrOut10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdCostTrsfrOut10 ELSE T.PtdCostTrsfrOut10 END,
	PtdCostTrsfrOut11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdCostTrsfrOut11 ELSE T.PtdCostTrsfrOut11 END,
	PtdCostTrsfrOut12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdCostTrsfrOut12 ELSE T.PtdCostTrsfrOut12 END
FROM	#TempHist t INNER JOIN
	ItemHist h ON t.FiscYr = h.FiscYr AND t.SiteID = h.SiteID AND t.InvtID = h.InvtID
IF @@ERROR <> 0 GOTO Err

UPDATE	H SET
	BMIPtdCOGS00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.BMIPtdCOGS00 ELSE T.BMIPtdCOGS00 END,
	BMIPtdCOGS01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.BMIPtdCOGS01 ELSE T.BMIPtdCOGS01 END,
	BMIPtdCOGS02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.BMIPtdCOGS02 ELSE T.BMIPtdCOGS02 END,
	BMIPtdCOGS03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.BMIPtdCOGS03 ELSE T.BMIPtdCOGS03 END,
	BMIPtdCOGS04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.BMIPtdCOGS04 ELSE T.BMIPtdCOGS04 END,
	BMIPtdCOGS05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.BMIPtdCOGS05 ELSE T.BMIPtdCOGS05 END,
	BMIPtdCOGS06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.BMIPtdCOGS06 ELSE T.BMIPtdCOGS06 END,
	BMIPtdCOGS07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.BMIPtdCOGS07 ELSE T.BMIPtdCOGS07 END,
	BMIPtdCOGS08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.BMIPtdCOGS08 ELSE T.BMIPtdCOGS08 END,
	BMIPtdCOGS09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.BMIPtdCOGS09 ELSE T.BMIPtdCOGS09 END,
	BMIPtdCOGS10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.BMIPtdCOGS10 ELSE T.BMIPtdCOGS10 END,
	BMIPtdCOGS11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.BMIPtdCOGS11 ELSE T.BMIPtdCOGS11 END,
	BMIPtdCOGS12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.BMIPtdCOGS12 ELSE T.BMIPtdCOGS12 END,
	BMIPtdCostAdjd00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.BMIPtdCostAdjd00 ELSE T.BMIPtdCostAdjd00 END,
	BMIPtdCostAdjd01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.BMIPtdCostAdjd01 ELSE T.BMIPtdCostAdjd01 END,
	BMIPtdCostAdjd02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.BMIPtdCostAdjd02 ELSE T.BMIPtdCostAdjd02 END,
	BMIPtdCostAdjd03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.BMIPtdCostAdjd03 ELSE T.BMIPtdCostAdjd03 END,
	BMIPtdCostAdjd04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.BMIPtdCostAdjd04 ELSE T.BMIPtdCostAdjd04 END,
	BMIPtdCostAdjd05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.BMIPtdCostAdjd05 ELSE T.BMIPtdCostAdjd05 END,
	BMIPtdCostAdjd06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.BMIPtdCostAdjd06 ELSE T.BMIPtdCostAdjd06 END,
	BMIPtdCostAdjd07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.BMIPtdCostAdjd07 ELSE T.BMIPtdCostAdjd07 END,
	BMIPtdCostAdjd08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.BMIPtdCostAdjd08 ELSE T.BMIPtdCostAdjd08 END,
	BMIPtdCostAdjd09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.BMIPtdCostAdjd09 ELSE T.BMIPtdCostAdjd09 END,
	BMIPtdCostAdjd10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.BMIPtdCostAdjd10 ELSE T.BMIPtdCostAdjd10 END,
	BMIPtdCostAdjd11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.BMIPtdCostAdjd11 ELSE T.BMIPtdCostAdjd11 END,
	BMIPtdCostAdjd12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.BMIPtdCostAdjd12 ELSE T.BMIPtdCostAdjd12 END,
	BMIPtdCostIssd00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.BMIPtdCostIssd00 ELSE T.BMIPtdCostIssd00 END,
	BMIPtdCostIssd01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.BMIPtdCostIssd01 ELSE T.BMIPtdCostIssd01 END,
	BMIPtdCostIssd02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.BMIPtdCostIssd02 ELSE T.BMIPtdCostIssd02 END,
	BMIPtdCostIssd03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.BMIPtdCostIssd03 ELSE T.BMIPtdCostIssd03 END,
	BMIPtdCostIssd04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.BMIPtdCostIssd04 ELSE T.BMIPtdCostIssd04 END,
	BMIPtdCostIssd05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.BMIPtdCostIssd05 ELSE T.BMIPtdCostIssd05 END,
	BMIPtdCostIssd06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.BMIPtdCostIssd06 ELSE T.BMIPtdCostIssd06 END,
	BMIPtdCostIssd07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.BMIPtdCostIssd07 ELSE T.BMIPtdCostIssd07 END,
	BMIPtdCostIssd08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.BMIPtdCostIssd08 ELSE T.BMIPtdCostIssd08 END,
	BMIPtdCostIssd09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.BMIPtdCostIssd09 ELSE T.BMIPtdCostIssd09 END,
	BMIPtdCostIssd10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.BMIPtdCostIssd10 ELSE T.BMIPtdCostIssd10 END,
	BMIPtdCostIssd11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.BMIPtdCostIssd11 ELSE T.BMIPtdCostIssd11 END,
	BMIPtdCostIssd12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.BMIPtdCostIssd12 ELSE T.BMIPtdCostIssd12 END,
	BMIPtdCostRcvd00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.BMIPtdCostRcvd00 ELSE T.BMIPtdCostRcvd00 END,
	BMIPtdCostRcvd01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.BMIPtdCostRcvd01 ELSE T.BMIPtdCostRcvd01 END,
	BMIPtdCostRcvd02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.BMIPtdCostRcvd02 ELSE T.BMIPtdCostRcvd02 END,
	BMIPtdCostRcvd03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.BMIPtdCostRcvd03 ELSE T.BMIPtdCostRcvd03 END,
	BMIPtdCostRcvd04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.BMIPtdCostRcvd04 ELSE T.BMIPtdCostRcvd04 END,
	BMIPtdCostRcvd05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.BMIPtdCostRcvd05 ELSE T.BMIPtdCostRcvd05 END,
	BMIPtdCostRcvd06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.BMIPtdCostRcvd06 ELSE T.BMIPtdCostRcvd06 END,
	BMIPtdCostRcvd07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.BMIPtdCostRcvd07 ELSE T.BMIPtdCostRcvd07 END,
	BMIPtdCostRcvd08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.BMIPtdCostRcvd08 ELSE T.BMIPtdCostRcvd08 END,
	BMIPtdCostRcvd09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.BMIPtdCostRcvd09 ELSE T.BMIPtdCostRcvd09 END,
	BMIPtdCostRcvd10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.BMIPtdCostRcvd10 ELSE T.BMIPtdCostRcvd10 END,
	BMIPtdCostRcvd11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.BMIPtdCostRcvd11 ELSE T.BMIPtdCostRcvd11 END,
	BMIPtdCostRcvd12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.BMIPtdCostRcvd12 ELSE T.BMIPtdCostRcvd12 END
FROM	#TempHist t INNER JOIN
	ItemBMIHist h ON t.FiscYr = h.FiscYr AND t.SiteID = h.SiteID AND t.InvtID = h.InvtID
IF @@ERROR <> 0 GOTO Err

UPDATE	H SET
	PtdQtySls00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdQtySls00 ELSE T.PtdQtySls00 END,
	PtdQtySls01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdQtySls01 ELSE T.PtdQtySls01 END,
	PtdQtySls02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdQtySls02 ELSE T.PtdQtySls02 END,
	PtdQtySls03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdQtySls03 ELSE T.PtdQtySls03 END,
	PtdQtySls04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdQtySls04 ELSE T.PtdQtySls04 END,
	PtdQtySls05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdQtySls05 ELSE T.PtdQtySls05 END,
	PtdQtySls06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdQtySls06 ELSE T.PtdQtySls06 END,
	PtdQtySls07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdQtySls07 ELSE T.PtdQtySls07 END,
	PtdQtySls08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdQtySls08 ELSE T.PtdQtySls08 END,
	PtdQtySls09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdQtySls09 ELSE T.PtdQtySls09 END,
	PtdQtySls10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdQtySls10 ELSE T.PtdQtySls10 END,
	PtdQtySls11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdQtySls11 ELSE T.PtdQtySls11 END,
	PtdQtySls12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdQtySls12 ELSE T.PtdQtySls12 END,
	PtdQtyDShpSls00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdQtyDShpSls00 ELSE T.PtdQtyDShpSls00 END,
	PtdQtyDShpSls01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdQtyDShpSls01 ELSE T.PtdQtyDShpSls01 END,
	PtdQtyDShpSls02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdQtyDShpSls02 ELSE T.PtdQtyDShpSls02 END,
	PtdQtyDShpSls03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdQtyDShpSls03 ELSE T.PtdQtyDShpSls03 END,
	PtdQtyDShpSls04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdQtyDShpSls04 ELSE T.PtdQtyDShpSls04 END,
	PtdQtyDShpSls05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdQtyDShpSls05 ELSE T.PtdQtyDShpSls05 END,
	PtdQtyDShpSls06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdQtyDShpSls06 ELSE T.PtdQtyDShpSls06 END,
	PtdQtyDShpSls07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdQtyDShpSls07 ELSE T.PtdQtyDShpSls07 END,
	PtdQtyDShpSls08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdQtyDShpSls08 ELSE T.PtdQtyDShpSls08 END,
	PtdQtyDShpSls09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdQtyDShpSls09 ELSE T.PtdQtyDShpSls09 END,
	PtdQtyDShpSls10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdQtyDShpSls10 ELSE T.PtdQtyDShpSls10 END,
	PtdQtyDShpSls11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdQtyDShpSls11 ELSE T.PtdQtyDShpSls11 END,
	PtdQtyDShpSls12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdQtyDShpSls12 ELSE T.PtdQtyDShpSls12 END,
	PtdQtyAdjd00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdQtyAdjd00 ELSE T.PtdQtyAdjd00 END,
	PtdQtyAdjd01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdQtyAdjd01 ELSE T.PtdQtyAdjd01 END,
	PtdQtyAdjd02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdQtyAdjd02 ELSE T.PtdQtyAdjd02 END,
	PtdQtyAdjd03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdQtyAdjd03 ELSE T.PtdQtyAdjd03 END,
	PtdQtyAdjd04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdQtyAdjd04 ELSE T.PtdQtyAdjd04 END,
	PtdQtyAdjd05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdQtyAdjd05 ELSE T.PtdQtyAdjd05 END,
	PtdQtyAdjd06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdQtyAdjd06 ELSE T.PtdQtyAdjd06 END,
	PtdQtyAdjd07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdQtyAdjd07 ELSE T.PtdQtyAdjd07 END,
	PtdQtyAdjd08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdQtyAdjd08 ELSE T.PtdQtyAdjd08 END,
	PtdQtyAdjd09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdQtyAdjd09 ELSE T.PtdQtyAdjd09 END,
	PtdQtyAdjd10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdQtyAdjd10 ELSE T.PtdQtyAdjd10 END,
	PtdQtyAdjd11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdQtyAdjd11 ELSE T.PtdQtyAdjd11 END,
	PtdQtyAdjd12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdQtyAdjd12 ELSE T.PtdQtyAdjd12 END,
	PtdQtyIssd00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdQtyIssd00 ELSE T.PtdQtyIssd00 END,
	PtdQtyIssd01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdQtyIssd01 ELSE T.PtdQtyIssd01 END,
	PtdQtyIssd02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdQtyIssd02 ELSE T.PtdQtyIssd02 END,
	PtdQtyIssd03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdQtyIssd03 ELSE T.PtdQtyIssd03 END,
	PtdQtyIssd04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdQtyIssd04 ELSE T.PtdQtyIssd04 END,
	PtdQtyIssd05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdQtyIssd05 ELSE T.PtdQtyIssd05 END,
	PtdQtyIssd06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdQtyIssd06 ELSE T.PtdQtyIssd06 END,
	PtdQtyIssd07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdQtyIssd07 ELSE T.PtdQtyIssd07 END,
	PtdQtyIssd08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdQtyIssd08 ELSE T.PtdQtyIssd08 END,
	PtdQtyIssd09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdQtyIssd09 ELSE T.PtdQtyIssd09 END,
	PtdQtyIssd10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdQtyIssd10 ELSE T.PtdQtyIssd10 END,
	PtdQtyIssd11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdQtyIssd11 ELSE T.PtdQtyIssd11 END,
	PtdQtyIssd12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdQtyIssd12 ELSE T.PtdQtyIssd12 END,
	PtdQtyRcvd00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdQtyRcvd00 ELSE T.PtdQtyRcvd00 END,
	PtdQtyRcvd01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdQtyRcvd01 ELSE T.PtdQtyRcvd01 END,
	PtdQtyRcvd02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdQtyRcvd02 ELSE T.PtdQtyRcvd02 END,
	PtdQtyRcvd03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdQtyRcvd03 ELSE T.PtdQtyRcvd03 END,
	PtdQtyRcvd04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdQtyRcvd04 ELSE T.PtdQtyRcvd04 END,
	PtdQtyRcvd05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdQtyRcvd05 ELSE T.PtdQtyRcvd05 END,
	PtdQtyRcvd06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdQtyRcvd06 ELSE T.PtdQtyRcvd06 END,
	PtdQtyRcvd07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdQtyRcvd07 ELSE T.PtdQtyRcvd07 END,
	PtdQtyRcvd08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdQtyRcvd08 ELSE T.PtdQtyRcvd08 END,
	PtdQtyRcvd09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdQtyRcvd09 ELSE T.PtdQtyRcvd09 END,
	PtdQtyRcvd10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdQtyRcvd10 ELSE T.PtdQtyRcvd10 END,
	PtdQtyRcvd11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdQtyRcvd11 ELSE T.PtdQtyRcvd11 END,
	PtdQtyRcvd12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdQtyRcvd12 ELSE T.PtdQtyRcvd12 END,
	PtdQtyTrsfrIn00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdQtyTrsfrIn00 ELSE T.PtdQtyTrsfrIn00 END,
	PtdQtyTrsfrIn01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdQtyTrsfrIn01 ELSE T.PtdQtyTrsfrIn01 END,
	PtdQtyTrsfrIn02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdQtyTrsfrIn02 ELSE T.PtdQtyTrsfrIn02 END,
	PtdQtyTrsfrIn03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdQtyTrsfrIn03 ELSE T.PtdQtyTrsfrIn03 END,
	PtdQtyTrsfrIn04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdQtyTrsfrIn04 ELSE T.PtdQtyTrsfrIn04 END,
	PtdQtyTrsfrIn05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdQtyTrsfrIn05 ELSE T.PtdQtyTrsfrIn05 END,
	PtdQtyTrsfrIn06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdQtyTrsfrIn06 ELSE T.PtdQtyTrsfrIn06 END,
	PtdQtyTrsfrIn07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdQtyTrsfrIn07 ELSE T.PtdQtyTrsfrIn07 END,
	PtdQtyTrsfrIn08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdQtyTrsfrIn08 ELSE T.PtdQtyTrsfrIn08 END,
	PtdQtyTrsfrIn09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdQtyTrsfrIn09 ELSE T.PtdQtyTrsfrIn09 END,
	PtdQtyTrsfrIn10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdQtyTrsfrIn10 ELSE T.PtdQtyTrsfrIn10 END,
	PtdQtyTrsfrIn11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdQtyTrsfrIn11 ELSE T.PtdQtyTrsfrIn11 END,
	PtdQtyTrsfrIn12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdQtyTrsfrIn12 ELSE T.PtdQtyTrsfrIn12 END,
	PtdQtyTrsfrOut00 = CASE WHEN t.fiscYr + '01' < @perstart THEN H.PtdQtyTrsfrOut00 ELSE T.PtdQtyTrsfrOut00 END,
	PtdQtyTrsfrOut01 = CASE WHEN t.fiscYr + '02' < @perstart THEN H.PtdQtyTrsfrOut01 ELSE T.PtdQtyTrsfrOut01 END,
	PtdQtyTrsfrOut02 = CASE WHEN t.fiscYr + '03' < @perstart THEN H.PtdQtyTrsfrOut02 ELSE T.PtdQtyTrsfrOut02 END,
	PtdQtyTrsfrOut03 = CASE WHEN t.fiscYr + '04' < @perstart THEN H.PtdQtyTrsfrOut03 ELSE T.PtdQtyTrsfrOut03 END,
	PtdQtyTrsfrOut04 = CASE WHEN t.fiscYr + '05' < @perstart THEN H.PtdQtyTrsfrOut04 ELSE T.PtdQtyTrsfrOut04 END,
	PtdQtyTrsfrOut05 = CASE WHEN t.fiscYr + '06' < @perstart THEN H.PtdQtyTrsfrOut05 ELSE T.PtdQtyTrsfrOut05 END,
	PtdQtyTrsfrOut06 = CASE WHEN t.fiscYr + '07' < @perstart THEN H.PtdQtyTrsfrOut06 ELSE T.PtdQtyTrsfrOut06 END,
	PtdQtyTrsfrOut07 = CASE WHEN t.fiscYr + '08' < @perstart THEN H.PtdQtyTrsfrOut07 ELSE T.PtdQtyTrsfrOut07 END,
	PtdQtyTrsfrOut08 = CASE WHEN t.fiscYr + '09' < @perstart THEN H.PtdQtyTrsfrOut08 ELSE T.PtdQtyTrsfrOut08 END,
	PtdQtyTrsfrOut09 = CASE WHEN t.fiscYr + '10' < @perstart THEN H.PtdQtyTrsfrOut09 ELSE T.PtdQtyTrsfrOut09 END,
	PtdQtyTrsfrOut10 = CASE WHEN t.fiscYr + '11' < @perstart THEN H.PtdQtyTrsfrOut10 ELSE T.PtdQtyTrsfrOut10 END,
	PtdQtyTrsfrOut11 = CASE WHEN t.fiscYr + '12' < @perstart THEN H.PtdQtyTrsfrOut11 ELSE T.PtdQtyTrsfrOut11 END,
	PtdQtyTrsfrOut12 = CASE WHEN t.fiscYr + '13' < @perstart THEN H.PtdQtyTrsfrOut12 ELSE T.PtdQtyTrsfrOut12 END
FROM	#TempHist t INNER JOIN
	Item2Hist h ON t.FiscYr = h.FiscYr AND t.SiteID = h.SiteID AND t.InvtID = h.InvtID
IF @@ERROR <> 0 GOTO Err

UPDATE	ItemHist SET
	BegBal = 0,
	YTDCOGS = CONVERT(dec(28,3), ROUND(PTDCOGS00, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS01, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS02, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS03, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS04, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS05, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS06, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS07, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS08, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS09, @DecPl)) + CONVERT(dec(28,3),
ROUND(PTDCOGS10, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS11, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCOGS12, @DecPl)),
	YTDCostAdjd = CONVERT(dec(28,3), ROUND(PTDCostAdjd00, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd01, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd02, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd03, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd04, @DecPl))+ CONVERT(dec(28,3), ROUND(PTDCostAdjd05, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd06, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd07, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd08, @DecPl)) + CONVERT(dec(28,3),
ROUND(PTDCostAdjd09,@DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd10, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd11, @DecPl)) + CONVERT(dec(28,3), ROUND(PTDCostAdjd12, @DecPl)),
	YTDCostIssd = CONVERT(dec(28,3), ROUND(PtdCostIssd00, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd01, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd02, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd03, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd04, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd05, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd06, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd07, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd08, @DecPl)) + CONVERT(dec(28,3),
ROUND(PtdCostIssd09, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd10, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd11, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostIssd12, @DecPl)),
	YTDCostRcvd = CONVERT(dec(28,3), ROUND(PtdCostRcvd00, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd01, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd02, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd03, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd04, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd05, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd06, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd07, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd08, @DecPl)) + CONVERT(dec(28,3),
ROUND(PtdCostRcvd09, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd10, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd11, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostRcvd12, @DecPl)),
	YTDCostTrsfrIn = CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn00, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn01, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn02, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn03, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn04, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn05, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn06, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn07, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn08, @DecPl)) + CONVERT(dec(28,3),
ROUND(PtdCostTrsfrIn09, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn10, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn11, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrIn12, @DecPl)),
	YTDCostTrsfrOut = CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut00, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut01, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut02, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut03, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut04, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut05, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut06, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut07, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut08, @DecPl))
+ CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut09, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut10, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut11, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdCostTrsfrOut12, @DecPl)),
	YTDSls = CONVERT(dec(28,3), ROUND(PtdSls00, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls01, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls02, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls03, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls04, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls05, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls06, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls07, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls08, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls09, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls10, @DecPl))
+ CONVERT(dec(28,3), ROUND(PtdSls11, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdSls12, @DecPl)),
	YTDDShpSls = CONVERT(dec(28,3), ROUND(PtdDShpSls00, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls01, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls02, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls03, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls04, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls05, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls06, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls07, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls08, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls09, @DecPl))
+ CONVERT(dec(28,3), ROUND(PtdDShpSls10, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls11, @DecPl)) + CONVERT(dec(28,3), ROUND(PtdDShpSls12, @DecPl))
WHERE	InvtID = @InvtID AND SiteID = @SiteID
IF @@ERROR <> 0 GOTO Err

UPDATE	ItemBMIHist SET
	BMIBegBal = 0,
	BMIYTDCOGS = CONVERT(dec(28,3), ROUND(BMIPtdCOGS00, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS01, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS02, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS03, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS04, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS05, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS06, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS07, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS08, @BMIDecPl)) + CONVERT(dec(28,3),
ROUND(BMIPtdCOGS09, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS10, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS11, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCOGS12, @BMIDecPl)),
	BMIYTDCostAdjd = CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd00, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd01, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd02, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd03, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd04, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd05, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd06, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd07, @BMIDecPl)) + CONVERT(dec(28,3),
ROUND(BMIPtdCostAdjd08, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd09, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd10, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd11, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostAdjd12, @BMIDecPl)),
	BMIYTDCostIssd = CONVERT(dec(28,3), ROUND(BMIPtdCostIssd00, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd01, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd02, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd03, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd04, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd05, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd06, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd07, @BMIDecPl)) + CONVERT(dec(28,3),
ROUND(BMIPtdCostIssd08, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd09, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd10, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd11, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostIssd12, @BMIDecPl)),
	BMIYTDCostRcvd = CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd00, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd01, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd02, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd03, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd04, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd05, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd06, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd07, @BMIDecPl)) + CONVERT(dec(28,3),
ROUND(BMIPtdCostRcvd08, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd09, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd10, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd11, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(BMIPtdCostRcvd12, @BMIDecPl))
WHERE	InvtID = @InvtID AND SiteID = @SiteID
IF @@ERROR <> 0 GOTO Err

UPDATE	Item2Hist SET
	BegQty = 0,
	YTDQtyAdjd = CONVERT(dec(25,9), ROUND(PtdQtyAdjd00, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd01, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd02, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd03, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd04, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd05, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd06, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd07, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd08, @DecPlQty)) + CONVERT(dec(25,9),
ROUND(PtdQtyAdjd09, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd10, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd11, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyAdjd12, @DecPlQty)),
	YTDQtyIssd = CONVERT(dec(25,9), ROUND(PtdQtyIssd00, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd01, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd02, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd03, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd04, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd05, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd06, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd07, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd08, @DecPlQty)) + CONVERT(dec(25,9),
ROUND(PtdQtyIssd09, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd10, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd11, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyIssd12, @DecPlQty)),
	YTDQtyRcvd = CONVERT(dec(25,9), ROUND(PtdQtyRcvd00, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd01, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd02, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd03, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd04, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd05, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd06, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd07, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd08, @DecPlQty)) + CONVERT(dec(25,9),
ROUND(PtdQtyRcvd09, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd10, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd11, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyRcvd12, @DecPlQty)),
	YTDQtyTrsfrIn = CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn00, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn01, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn02, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn03, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn04, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn05, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn06, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn07, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn08, @DecPlQty))
+ CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn09, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn10, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn11, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrIn12, @DecPlQty)),
	YTDQtyTrsfrOut = CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut00, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut01, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut02, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut03, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut04, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut05, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut06, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut07, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut08, @DecPlQty))
+ CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut09, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut10, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut11, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyTrsfrOut12, @DecPlQty)),
	YTDQtySls = CONVERT(dec(25,9), ROUND(PtdQtySls00, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls01, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls02, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls03, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls04, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls05, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls06, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls07, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls08, @DecPlQty)) + CONVERT(dec(25,9),
ROUND(PtdQtySls09, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls10, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls11, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtySls12, @DecPlQty)),
	YTDQtyDShpSls = CONVERT(dec(25,9), ROUND(PtdQtyDShpSls00, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls01, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls02, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls03, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls04, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls05, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls06, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls07, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls08, @DecPlQty))
+ CONVERT(dec(25,9), ROUND(PtdQtyDShpSls09, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls10, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls11, @DecPlQty)) + CONVERT(dec(25,9), ROUND(PtdQtyDShpSls12, @DecPlQty))
WHERE	InvtID = @invtID AND SiteID = @SiteID
IF @@ERROR <> 0 GOTO Err

SELECT 	@MinYr = MIN(FiscYr), @MaxYr = MAX(FiscYr) FROM ItemHist WHERE InvtID = @InvtID AND SiteID = @SiteID

WHILE @MinYr <= @MaxYr BEGIN

	UPDATE	H SET
		BegBal = CONVERT(dec(28,3), ROUND(H1.BegBal, @DecPl)) + CONVERT(dec(28,3), ROUND(H1.YTDCostRcvd, @DecPl)) + CONVERT(dec(28,3), ROUND(H1.YTDCostTrsfrIn, @DecPl)) + CONVERT(dec(28,3), ROUND(H1.YTDCostAdjd, @DecPl)) - CONVERT(dec(28,3), ROUND(H1.YTDCostIssd, @DecPl)) - CONVERT(dec(28,3), ROUND(H1.YTDCOGS, @DecPl)) - CONVERT(dec(28,3), ROUND(H1.YTDCostTrsfrOut, @DecPl))
	FROM	ItemHist H INNER JOIN
		ItemHist H1 ON H.InvtID = @InvtID AND H.SiteID = @SiteID AND H.InvtID = H1.InvtID AND H.FiscYr = @minYr AND H.SiteID = H1.SiteID AND CONVERT(varchar(4), CONVERT(INT, H.FiscYr) - 1) = H1.FiscYr
	IF @@ERROR <> 0 GOTO Err

	UPDATE	H SET
 		BegQty = CONVERT(dec(25,9), ROUND(H1.BegQty, @DecPlQty)) + CONVERT(dec(25,9), ROUND(H1.YTDQtyRcvd, @DecPlQty)) + CONVERT(dec(25,9), ROUND(H1.YTDQtyTrsfrIn, @DecPlQty)) + CONVERT(dec(25,9), ROUND(H1.YTDQtyAdjd, @DecPlQty)) - CONVERT(dec(25,9), ROUND(H1.YTDQtyIssd, @DecPlQty)) - CONVERT(dec(25,9), ROUND(H1.YTDQtySls, @DecPlQty)) - CONVERT(dec(25,9), ROUND(H1.YTDQtyTrsfrOut, @DecPlQty))
	FROM	Item2Hist H INNER JOIN
		Item2Hist H1 ON H.InvtID = @InvtID AND H.FiscYr = @minYr AND H.SiteID = @SiteID AND H.InvtID = H1.InvtID AND H.SiteID = H1.SiteID AND CONVERT(varchar(4), CONVERT(INT, H.FiscYr) - 1) = H1.FiscYr
	IF @@ERROR <> 0 GOTO Err

	UPDATE	H SET
		BMIBegBal = CONVERT(dec(28,3), ROUND(H1.BMIBegBal, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(H1.BMIYTDCostRcvd, @BMIDecPl)) + CONVERT(dec(28,3), ROUND(H1.BMIYTDCostAdjd, @BMIDecPl)) - CONVERT(dec(28,3), ROUND(H1.BMIYTDCostIssd, @BMIDecPl)) - CONVERT(dec(28,3), ROUND(H1.BMIYTDCOGS, @BMIDecPl))
	FROM	ItemBMIHist H INNER JOIN
		ItemBMIHist H1 ON H.INvtID = @InvtID AND H.SiteID = @SiteID AND H.FiscYr = @minYr AND H.InvtID = H1.InvtID AND H.SiteID = H1.SiteID AND CONVERT(varchar(4), CONVERT(INT, H.FiscYr) - 1) = H1.FiscYr
	IF @@ERROR <> 0 GOTO Err

	SET @MinYr = @MinYr + 1

END

/*  After calculating the beginning balance, find any intran entries for which there
	was an RFC and the item was sent to "scrap".  Those items should not be included
	in the inventory and must be removed.
*/

SELECT 	@MinYr = MIN(FiscYr), @MaxYr = MAX(FiscYr) FROM ItemHist WHERE InvtID = @InvtID AND SiteID = @SiteID

WHILE @MinYr < @MaxYr BEGIN

	SET @NextYr = @MinYr + 1

	UPDATE H SET
	    Begbal = CONVERT(dec(28,3), ROUND(H.BegBal, @DecPl)) - Extcost from
		ItemHist H INNER JOIN
	        (SELECT Extcost = SUM(I.ExtCost), I.InvtId, I.SiteId, I.FiscYr
                   FROM #IN10990_InTran I INNER JOIN Inventory  Y
                        ON I.InvtId = Y.InvtId
                     LEFT OUTER JOIN SOShipHeader s WITH(NOLOCK)
                        ON I.ShipperID = s.ShipperID
                       AND I.CpnyID = s.CpnyID
	          WHERE (I.TranType = 'CM' AND I.S4Future09 = 1 AND
	 	         Y.StkItem = 1 AND  I.FiscYr = @MinYr  AND ISNULL(s.DropShip,0) = 0)
                  GROUP BY I.InvtId, I.SiteId, I.FiscYr) I
	on H.InvtId = I.InvtId and H.SiteId = I.SiteId and H.FiscYr = @NextYr

	IF @@ERROR <> 0 GOTO Err

	UPDATE H SET
	     BegQty = CONVERT(dec(25,9), ROUND(H.BegQty, @DecPlQty)) - Qty
	FROM Item2Hist H INNER JOIN
	     (SELECT Qty = sum(I.Qty), I.InvtId, I.SiteId, I.FiscYr
                FROM #IN10990_InTran I INNER JOIN Inventory  Y
                        ON I.InvtId = Y.InvtId
                     LEFT OUTER JOIN SOShipHeader s WITH(NOLOCK)
                        ON I.ShipperID = s.ShipperID
                       AND I.CpnyID = s.CpnyID
	       WHERE (I.TranType = 'CM' AND I.S4Future09 = 1 AND
	              Y.StkItem = 1 AND  I.FiscYr = @MinYr  AND ISNULL(s.DropShip,0) = 0)
               GROUP BY I.InvtId, I.SiteId, I.FiscYr) I
	on H.InvtId = I.InvtId and H.SiteId = I.SiteId and H.FiscYr = @NextYr

	IF @@ERROR <> 0 GOTO Err

	SET @MinYr = @MinYr + 1

END

END

Fatal:

IF @@TRANCOUNT > 0 COMMIT

SELECT * FROM #IN10990_Errorlog

RETURN

err:

IF @@TRANCOUNT > 0 ROLLBACK



GO
GRANT CONTROL
    ON OBJECT::[dbo].[scm_10990_Status_tables_Rebuild] TO [MSDSL]
    AS [dbo];

