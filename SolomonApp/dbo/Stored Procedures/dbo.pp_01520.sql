 CREATE PROCEDURE pp_01520
	@UserAddress varchar(21),
	@pUserID	VarChar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
As
/********************************************************************************
*             Copyright TLB, Inc. 1991, 1994 All Rights Reserved
** Proc Name     : pp_01520
** Narrative     : All posting activity occurs from within this routine.  This routine
*                 processes all batches identified in wrkpost for the given useraddress. It
*                 first performs several checks and removes batches that cannot be processed.
*                 The remaining batches are set to Z while processing and then they are set
*                 to status 'P' when complete. The entire post is done as a single transaction
*                 set.
**
* Inputs        : UserAddress - Workstation ID of requesting user
** Output        : This proc commits if good or rolls back on error
*                  Any batches containing errors are identified in Wrkpostbad and
*                  are handled by the calling program.
*****************************************************************************
* #   Init   Date         Change
********************************************************************************
*001  JJ   12/06/1997  Initial Creation
*002  MDu,CLs  05/21/1998  Re-written for 4.0
*********************************************************************************
*/

Set NoCount ON
Set DEADLOCK_PRIORITY Low

DECLARE @BaseDecPl INT

/*** Get the Base Decimal Place ***/
SELECT  @BaseDecPl = c.DecPl
  FROM  GLSetup s WITH(NOLOCK) INNER JOIN Currncy c WITH(NOLOCK)
                      ON s.BaseCuryID = c.CuryID

/***** Start transaction set. *****/
BEGIN TRANSACTION
/***** Delete leftover workpostbad records *****/
Delete wrkpostbad
 where UserAddress = @UserAddress
/***** Delete all records already processed by another user *****/
Delete WrkPost from wrkpost p ,batch b
where b.BatNbr=p.BatNbr and b.Module=p.Module
and p.UserAddress=@UserAddress and b.status in ('Z','P')

/***** Load used GLSetup Fields into Variables *****/
Declare @PerNbr VarChar ( 6), @ValidateAtPosting SmallInt, @YTDNetIncAcct VarChar ( 10), @RetEarnAcct VarChar ( 10), @SuspenseRowCount int

Select @PerNbr = PerNbr, @ValidateAtPosting = ValidateAtPosting, @YTDNetIncAcct = YTDNetIncAcct, @RetEarnAcct = RetEarnAcct from GLSetup (NOLOCK)

/***** End Selecting GLSetup Fields *****/

/***** Set initial population for posting. *****/

UPDATE Batch SET Status = 'Z' From Batch b (ROWLOCK), WrkPost p
WHERE Status = 'U'
  and b.BatNbr=p.BatNbr
  and b.Module=p.Module
  and p.UserAddress=@UserAddress

IF @@ERROR < > 0 GOTO ABORT

/***** Restore and exclude records meeting certain criteria. *****/
/***** Maintain the necessary exception rules here. *****/

/***** If the PerPost is greater than the current period or empty, exclude the record. *****/
INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
SELECT b.BatNbr, b.Module, Situation = '6035', @UserAddress
FROM Batch b ,Wrkpost p
WHERE  (PerPost > @PerNbr OR PerPost = '')
  and b.BatNbr=p.BatNbr and b.Module=p.Module
  and p.UserAddress=@UserAddress
IF @@ERROR < > 0 GOTO ABORT

/***** If the PerPost of transaction is empty, exclude the record. *****/
INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
SELECT distinct t.BatNbr, t.Module, Situation = '6035', @UserAddress
FROM GLTran t, Wrkpost p
WHERE  PerPost = ''
  and t.BatNbr=p.BatNbr and t.Module=p.Module
  and p.UserAddress=@UserAddress
IF @@ERROR < > 0 GOTO ABORT

/***** If the PerPost of transaction and PerPost of batch is different, exclude the record. *****/
INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
SELECT distinct t.BatNbr, t.Module, Situation = '6035', @UserAddress
FROM GLTran t, Batch b, Wrkpost p
WHERE  t.BatNbr=p.BatNbr and t.Module=p.Module and t.BatNbr = b.BatNbr AND t.Module = b.Module
  and p.UserAddress=@UserAddress
  and t.PerPost <> b.PerPost
IF @@ERROR < > 0 GOTO ABORT

/***** If the batch is a direct depost batch that has not cleared, exclude the record. *****/
INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
SELECT b.BatNbr, b.Module, Situation = '6874', @UserAddress
FROM  Batch b,wrkpost p
WHERE b.Module = 'PR' AND JrnlType = 'DD' AND DATEPART(YEAR,DateClr) < 1930
  and b.BatNbr=p.BatNbr and b.Module=p.Module
  and p.UserAddress=@UserAddress
IF @@ERROR < > 0 GOTO ABORT

/***** If valid date subaccount combos is on and the subacct doesn't exist, exclude...*****/
INSERT wrkpostbad (Batnbr, Module, Situation, UserAddress)
SELECT DISTINCT Min(b.Batnbr), MIN(b.Module), situation = '6654',@UserAddress
FROM GLTran g, Batch b, FlexDef f, wrkpost p
WHERE b.BatNbr=p.BatNbr and b.Module=p.Module
  	and p.UserAddress=@UserAddress
	and g.Module = b.Module AND g.BatNbr = b.BatNbr
  	and f.FieldClassName = 'SUBACCOUNT' and f.ValidCombosRequired = 1
	GROUP BY g.Sub, g.CpnyID
        HAVING g.Sub NOT IN (SELECT Sub FROM vp_MC_Company_SubXref where CpnyID = g.CpnyID)
IF @@ERROR < > 0 GOTO ABORT

/***** If valid date subaccount combos is on and the subacct is inactive, exclude...*****/
INSERT wrkpostbad (BatNbr, Module, Situation, UserAddress)
SELECT DISTINCT g.Batnbr, g.Module, situation = '6642',@UserAddress
FROM GLTran g, FlexDef f, vp_MC_Company_SubXref s,wrkpost p
WHERE g.Module = p.Module AND g.BatNbr = p.BatNbr
	AND s.sub = g.sub AND s.SubActive = 0
	AND s.CpnyID = g.CpnyID
  	and f.FieldClassName = 'SUBACCOUNT' and f.ValidCombosRequired = 1
  	and p.UserAddress=@UserAddress
IF @@ERROR < > 0 GOTO ABORT

/***** If acct or subaccount field is blank, exclude...*****/
INSERT wrkpostbad (BatNbr, Module, Situation, UserAddress)
SELECT DISTINCT Min(b.Batnbr), MIN(b.Module), situation = '6658',@UserAddress
FROM GLTran g, Batch b, wrkpost p
WHERE b.BatNbr=p.BatNbr and b.Module=p.Module
  	and p.UserAddress= @UserAddress
	and g.Module = b.Module AND g.BatNbr = b.BatNbr
	GROUP BY g.Acct,g.Sub
        HAVING (g.Acct = '' or g.Sub = '')
IF @@ERROR < > 0 GOTO ABORT

/***** If Basecuryid doesn't exist within Gltran, exclude...*****/
INSERT wrkpostbad (BatNbr, Module, Situation, UserAddress)
SELECT DISTINCT MIN(b.Batnbr), MIN(b.Module), situation = '8060',@UserAddress
FROM GLTran g, Batch b, wrkpost p
WHERE b.BatNbr = p.BatNbr AND b.Module = p.Module
      AND p.UserAddress=@UserAddress
      AND g.Module = b.Module AND g.BatNbr = b.BatNbr
      AND b.status = 'Z'
	GROUP BY g.Batnbr, g.Basecuryid
        HAVING g.Basecuryid NOT IN (SELECT Curyid FROM Currncy)

IF @@ERROR < > 0 GOTO ABORT

/***** If the batch is missing IC GL Tran records exclude the record. *****/
INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
SELECT DISTINCT v.batnbr, v.module, '3011', v.UserAddress
  FROM vp_01520ChkSumGlTransForIC v
 WHERE ROUND(v.cramt,@BaseDecPl) <> ROUND(v.dramt, @BaseDecPl)
  AND v.useraddress = @useraddress

/***** If the batch is missing GL Tran records or is out of balance, exclude the record. *****/
DECLARE @xCurBatNbr Char(10), @xCurModule Char(2), @xCrTot Float, @xLedgerID Char(10), @xBatType Char(1), @xBaseCuryID Char(4)
DECLARE @xCuryCrTot Float, @xCuryID Char(4)
DECLARE xBatchCursor CURSOR FOR
	SELECT b.Module, b.BatNbr, CrTot, LedgerID, BatType, BaseCuryID, CuryCrTot, b.CuryID
                 FROM Batch b, WrkPost p, Currncy c (NOLOCK)
		WHERE b.BatNbr=p.BatNbr and b.Module=p.Module and b.BaseCuryID = c.CuryID
                  and p.UserAddress=@UserAddress

OPEN xBatchCursor

FETCH NEXT FROM xBatchCursor INTO
	@xCurModule, @xCurBatNbr, @xCrTot, @xLedgerID, @xBatType, @xBaseCuryID, @xCuryCrTot, @xCuryID
IF @@ERROR < > 0 GOTO ABORT

WHILE (@@FETCH_STATUS <> -1)
	BEGIN

		IF @@FETCH_STATUS <> -2
		BEGIN
			IF (SELECT COUNT(BatNbr) FROM GLTran
				WHERE BatNbr = @xCurBatNbr AND Module = @xCurModule) = 0
			        INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
				    VALUES(@xCurBatNbr, @xCurModule, '3011', @UserAddress)
			IF @@ERROR < > 0 GOTO ABORT

		    IF @xCurModule = 'GL'
			Begin
		    	IF @xBatType = 'V' OR @xBatType = 'O'
				BEGIN
					select @xBatType = dbo.getNonReversNonCorrBatType(@xCurBatNbr, @xCurModule, @xBatType)
				END
				INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
				SELECT t.BatNbr, t.Module, Situation = '3011', @UserAddress
				FROM GLTran t, Currncy c, Ledger l, Currncy cr
				WHERE @xBaseCuryID = t.CuryID AND t.CuryID = c.CuryID AND t.BatNbr = @xCurBatNbr AND
					t.Module = @xCurModule AND l.LedgerID = @xLedgerID AND @xCuryID = cr.CuryID
				GROUP BY t.Module, t.BatNbr, c.DecPl, l.BalRequired, cr.DecPl
				HAVING (((ABS(Round(Round(@xCrTot, c.DecPl) - ROUND(Sum(t.DRAmt), c.DecPl), c.DecPl)) > (1/Power(10.0,c.DecPl+1))
							AND ABS(Round(Round(@xCrTot, c.DecPl) - ROUND(Sum(t.CRAmt), c.DecPl), c.DecPl)) > (1/Power(10.0,c.DecPl+1))
							AND (@xBatType = 'J' OR l.BalRequired = 0))
									OR
					((ABS(Round(Round(@xCrTot, c.DecPl) - ROUND(Sum(t.DRAmt), c.DecPl), c.DecPl)) > (1/Power(10.0,c.DecPl+1))
								OR ABS(Round(Round(@xCrTot, c.DecPl) - ROUND(Sum(t.CRAmt), c.DecPl), c.DecPl)) > (1/Power(10.0,c.DecPl+1)))
								AND (@xBatType <> 'J' AND l.BalRequired = 1))))
				OR
				(((ABS(Round(Round(@xCuryCrTot, cr.DecPl) - ROUND(Sum(t.CuryDRAmt), cr.DecPl), cr.DecPl)) > (1/Power(10.0,cr.DecPl+1))
							AND ABS(Round(Round(@xCuryCrTot, cr.DecPl) - ROUND(Sum(t.CuryCRAmt), cr.DecPl), cr.DecPl)) > (1/Power(10.0,cr.DecPl+1))
							AND (@xBatType = 'J' OR l.BalRequired = 0))
									OR
					((ABS(Round(Round(@xCuryCrTot, cr.DecPl) - ROUND(Sum(t.CuryDRAmt), cr.DecPl), cr.DecPl)) > (1/Power(10.0,cr.DecPl+1))
								OR ABS(Round(Round(@xCuryCrTot, cr.DecPl) - ROUND(Sum(t.CuryCRAmt), cr.DecPl), cr.DecPl)) > (1/Power(10.0,cr.DecPl+1)))
								AND (@xBatType <> 'J' AND l.BalRequired = 1))))
			End

			IF @@ERROR < > 0 GOTO ABORT

		    IF @xCurModule <> 'GL'
			Begin
				IF @xBatType = 'V' OR @xBatType = 'O'
				BEGIN
					select @xBatType = dbo.getNonReversNonCorrBatType(@xCurBatNbr, @xCurModule, @xBatType)
				END
				INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
				SELECT t.BatNbr, t.Module, Situation = '3011', @UserAddress
   				  FROM GLTran t, Currncy c, Ledger l, Currncy cr
				 WHERE @xBaseCuryID = c.CuryID AND t.BatNbr = @xCurBatNbr AND
				    	t.Module = @xCurModule AND t.TranType <> 'IC' AND l.LedgerID = @xLedgerID AND @xCuryID = cr.CuryID
				 GROUP BY t.Module, t.BatNbr, c.DecPl, l.BalRequired , cr.DecPl
				HAVING (((ABS(Round(Round(@xCrTot, c.DecPl) - ROUND(Sum(t.DRAmt), c.DecPl),c.DecPl)) > (1/Power(10.0,c.DecPl+1))
							AND ABS(Round(Round(@xCrTot, c.DecPl) - ROUND(Sum(t.CRAmt), c.DecPl), c.DecPl)) > (1/Power(10.0,c.DecPl+1))
							AND (@xBatType = 'J' OR l.BalRequired = 0))
									OR
					((ABS(Round(Round(@xCrTot, c.DecPl) - ROUND(Sum(t.DRAmt), c.DecPl), c.DecPl)) > (1/Power(10.0,c.DecPl+1))
								OR ABS(Round(Round(@xCrTot, c.DecPl) - ROUND(Sum(t.CRAmt), c.DecPl), c.DecPl)) > (1/Power(10.0,c.DecPl+1)))
								AND (@xBatType <> 'J' AND l.BalRequired = 1))))
				OR
				(((ABS(Round(Round(@xCuryCrTot, cr.DecPl) - ROUND(Sum(t.CuryDRAmt), cr.DecPl),cr.DecPl)) > (1/Power(10.0,cr.DecPl+1))
							AND ABS(Round(Round(@xCuryCrTot, cr.DecPl) - ROUND(Sum(t.CuryCRAmt), cr.DecPl), cr.DecPl)) > (1/Power(10.0,cr.DecPl+1))
							AND (@xBatType = 'J' OR l.BalRequired = 0))
									OR
					((ABS(Round(Round(@xCuryCrTot, cr.DecPl) - ROUND(Sum(t.CuryDRAmt), cr.DecPl), cr.DecPl)) > (1/Power(10.0,cr.DecPl+1))
								OR ABS(Round(Round(@xCuryCrTot, cr.DecPl) - ROUND(Sum(t.CuryCRAmt), cr.DecPl), cr.DecPl)) > (1/Power(10.0,cr.DecPl+1)))
								AND (@xBatType <> 'J' AND l.BalRequired = 1))))
			End

			IF @@ERROR < > 0 GOTO ABORT
		END
		FETCH NEXT FROM xBatchCursor INTO @xCurModule, @xCurBatNbr, @xCrTot, @xLedgerID, @xBatType, @xBaseCuryID, @xCuryCrTot, @xCuryID
		IF @@ERROR < > 0 GOTO ABORT
    	END
CLOSE xBatchCursor
DEALLOCATE xBatchCursor

IF @@ERROR < > 0 GOTO ABORT

/***** Change 'Z' back to 'U' according to WrkPostBad. *****/

UPDATE Batch SET Status = 'U' FROM Batch b (ROWLOCK), WrkPostBad w
WHERE b.Module = w.Module AND b.BatNbr = w.BatNbr
  and w.UserAddress=@UserAddress

IF @@ERROR < > 0 GOTO ABORT

/***** Remove Records from Wrkpost that will not be processed *****/

Delete Wrkpost
  from wrkpost p, wrkpostbad b
 where b.Module = p.Module
   AND b.BatNbr = p.BatNbr
   AND p.UserAddress = b.UserAddress
   AND p.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT
Select @SuspenseRowCount = 0 /***** used to determine whether-or-not a suspense acct should be created *****/

/***** If any accounts do not exist update the tran to be suspense. *****/
UPDATE t SET t.Acct = '000000    '
	FROM Batch b, GLTran t (ROWLOCK), Wrkpost P
	WHERE b.BatNbr = t.BatNbr AND b.Module = t.Module
          and b.BatNbr=p.BatNbr and b.Module=p.Module
          and p.UserAddress=@UserAddress
          and Not Exists(Select 'Found'
                          From vs_company c, vs_acctxref x
                          Where t.cpnyid = c.cpnyid
                          and c.cpnycoa = x.cpnyid
                          and t.acct = x.acct
                          and x.active = 1)

Select @SuspenseRowCount = @@rowcount

IF @@ERROR < > 0 GOTO ABORT

/***** If ValidateAtPosting is on and acct/sub combos do not exist update the tran to be suspense. *****/

IF @ValidateAtPosting = 1
Begin
 UPDATE t SET t.Acct = '000000    '
	FROM Batch b, GLTran t (ROWLOCK), Wrkpost P
	WHERE b.BatNbr = t.BatNbr AND b.Module = t.Module
          and b.BatNbr=p.BatNbr and b.Module=p.Module
          and p.UserAddress=@UserAddress
          and NOT Exists (SELECT 'No record'
                            FROM vs_acctsub a
                           where t.acct = a.acct
                             and t.sub  = a.sub
                             and t.cpnyid = a.cpnyid
                             and a.active = 1)
End
Select @SuspenseRowCount = @SuspenseRowCount + @@rowcount

IF @SuspenseRowCount <> 0
Begin
	/***** If a suspense account '000000    ' does not exist, create one. *****/
	IF (SELECT COUNT(Acct) FROM Account WHERE Acct = '000000    ') = 0
    Begin
		INSERT Account (Acct, AcctType, Acct_Cat, Acct_Cat_SW, Active, ClassID, ConsolAcct,
					Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId, Descr, Employ_Sw,
					LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, RatioGrp, S4Future01,
					S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
					S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
					S4Future12, SummPost, UnitofMeas, Units_SW, User1, User2,
					User3, User4, User5, User6, User7, User8, ValidateID)

		VALUES ('000000    ','1A','','',1,'','000000    ',getdate(),'01520',@pUserID,'',
			'GL SUSPENSE','',getdate(),'01520',@pUserID,0,'',
			'', '',0,0,0,0,'','',1,1,'','',
			'N','','','','',0,0, '', '', '', '', '')
    End

	Insert into VW_AcctXRef (Acct, AcctType, Active, CpnyId , Descr, User1, User2, User3, User4)
    	SELECT DISTINCT '000000    ','1A', 1, v.cpnyCOA, 'GL SUSPENSE', '', '',0,0
          FROM GLTran t Inner Join vs_company v on t.cpnyID = v.cpnyID
               Inner Join WrkPost P on p.batnbr = t.batnbr and p.module = t.module
               -- modified join to fix 6909 error    
               Left join VW_AcctXRef vw on v.cpnycoa = vw.cpnyid and vw.acct = '000000'
               --Original Lines Below:          
               --Left join VW_AcctXRef vw on t.cpnyid = vw.cpnyid and vw.acct = '000000'
         WHERE p.UserAddress=@UserAddress and vw.cpnyid is null

	IF @@ERROR < > 0 GOTO ABORT
End

/***** If Gtran is assigned a Suspense account then notify user in Event Log by inserting a
record in WrkPostBad,As this Batch will be posted no need to remove the BatNbr from WrkPost*****/
INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
	SELECT t.BatNbr, t.Module, Situation = '6659', @UserAddress
	FROM Batch b, GLTran t, Wrkpost P
	WHERE b.BatNbr = t.BatNbr AND b.Module = t.Module
          and b.BatNbr = p.BatNbr and b.Module = p.Module
          and p.UserAddress = @UserAddress
	  and t.Acct = '000000    '

IF @@ERROR < > 0 GOTO ABORT

EXECUTE Insert_AcctSub @YTDNetIncAcct, @UserAddress, @pUserID

IF @@ERROR < > 0 GOTO ABORT

/***** If a sub account doesn't exist, create it. *****/
INSERT SubAcct (Active, ConsolSub, Crtd_DateTime, Crtd_Prog, Crtd_User, Descr,
				LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, S4Future01,S4Future02,
				S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08,
				S4Future09, S4Future10, S4Future11, S4Future12, Sub, User1, User2,
				User3, User4, User5, User6, User7, User8)

SELECT 1, g.Sub,getdate(),'01520',@pUserID,'Sub Acct Added During Posting',
	getdate(),'01520',@pUserID, 0,
	'', '',0,0,0,0,'','',1,1,'','',
	g.Sub, ' ', ' ', 0, 0, '', '', '', ''
FROM GLTran g inner join WrkPost p on g.BatNbr=p.BatNbr and g.Module=p.Module
	inner join GLSetup s (NOLOCK) on s.SetupID = 'GL'
	inner join vs_Company c on c.CpnySub = s.CpnyID and c.CpnyID = g.CpnyID
WHERE p.UserAddress=@UserAddress
	GROUP BY g.Sub
        HAVING g.Sub NOT IN (SELECT Sub FROM SubAcct)

IF @@ERROR < > 0 GOTO ABORT

EXECUTE Insert_SubxRef @UserAddress

IF @@ERROR < > 0 GOTO ABORT

/***** Build a temporary time range table to span all years that may be affected by trans. *****/

CREATE TABLE dbo.#TimeRange (
	FiscYr char (4) NOT NULL)

DECLARE @FirstYr CHAR(4)

SELECT @FirstYr = (SELECT MIN(FiscYr) FROM vp_01520PostTran)

WHILE (@FirstYr <= SUBSTRING(@PerNbr,1,4))
	BEGIN
		INSERT #TimeRange VALUES (@FirstYr)
		SELECT @FirstYr = LTRIM(STR(CONVERT(INT,@FirstYr) + 1))
	END

/***** Insert AcctHist records that don't currently exist. *****/
INSERT AcctHist (Acct, AnnBdgt, AnnMemo1, BalanceType, BdgtRvsnDate, BegBal,
				CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId, DistType,
				FiscYr, LastClosePerNbr, LedgerID, LUpd_DateTime, LUpd_Prog,
				LUpd_User, NoteID, PtdAlloc00, PtdAlloc01, PtdAlloc02, PtdAlloc03,
				PtdAlloc04, PtdAlloc05, PtdAlloc06, PtdAlloc07, PtdAlloc08,
				PtdAlloc09, PtdAlloc10, PtdAlloc11, PtdAlloc12, PtdBal00,
				PtdBal01, PtdBal02, PtdBal03, PtdBal04, PtdBal05, PtdBal06,
				PtdBal07, PtdBal08, PtdBal09, PtdBal10, PtdBal11, PtdBal12,
				PtdCon00, PtdCon01, PtdCon02, PtdCon03, PtdCon04, PtdCon05,
				PtdCon06, PtdCon07, PtdCon08, PtdCon09, PtdCon10, PtdCon11,
				PtdCon12, S4Future01, S4Future02, S4Future03, S4Future04,
				S4Future05, S4Future06, S4Future07, S4Future08, S4Future09,
				S4Future10, S4Future11, S4Future12, SpreadSheetType, Sub,
				User1, User2 ,User3, User4, User5, User6, User7, User8,
				YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04, YtdBal05,
				YtdBal06, YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11,
				YtdBal12,YTDEstimated)

SELECT DISTINCT z.Acct, 0, 0,
	(SELECT BalanceType FROM Ledger l WHERE l.LedgerID = z.LedgerID),
	'7/9/1922', 0, z.CpnyID, getdate(),'01520',@pUserID,
	z.CuryID, '', r.FiscYr, ' ', z.LedgerID,
	getdate(),'01520',@pUserID, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	'', '',0,0,0,0,'','',1,1,'','',
	'', z.Sub, ' ', ' ', 0, 0, '', '', '', '',
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM vp_01520PostTran z, #TimeRange r, vs_Company c
WHERE useraddress=@useraddress and c.CpnyID=z.CpnyID and c.DatabaseName=DB_NAME() and
      NOT EXISTS (SELECT a.Acct FROM AcctHist a WHERE a.Acct = z.Acct AND a.Sub = z.Sub AND
	a.FiscYr = r.FiscYr AND a.LedgerID = z.LedgerID AND a.CpnyID=z.CpnyID) AND
	((z.AcctType IN ('E', 'I') AND z.FiscYr = r.FiscYr) OR
	(z.AcctType IN ('A', 'L') AND z.FiscYr <= r.FiscYr))

IF @@ERROR < > 0 GOTO ABORT

/***** Insert AcctHist records for YTD Net Income that don't currently exist. *****/
INSERT AcctHist (Acct, AnnBdgt, AnnMemo1, BalanceType, BdgtRvsnDate, BegBal,
				CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId, DistType,
				FiscYr, LastClosePerNbr, LedgerID, LUpd_DateTime, LUpd_Prog,
				LUpd_User, NoteID, PtdAlloc00, PtdAlloc01, PtdAlloc02, PtdAlloc03,
				PtdAlloc04, PtdAlloc05, PtdAlloc06, PtdAlloc07, PtdAlloc08,
				PtdAlloc09, PtdAlloc10, PtdAlloc11, PtdAlloc12, PtdBal00,
				PtdBal01, PtdBal02, PtdBal03, PtdBal04, PtdBal05, PtdBal06,
				PtdBal07, PtdBal08, PtdBal09, PtdBal10, PtdBal11, PtdBal12,
				PtdCon00, PtdCon01, PtdCon02, PtdCon03, PtdCon04, PtdCon05,
				PtdCon06, PtdCon07, PtdCon08, PtdCon09, PtdCon10, PtdCon11,
				PtdCon12, S4Future01, S4Future02, S4Future03, S4Future04,
				S4Future05, S4Future06, S4Future07, S4Future08, S4Future09,
				S4Future10, S4Future11, S4Future12, SpreadSheetType, Sub,
				User1, User2 ,User3, User4, User5, User6, User7, User8,
				YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04, YtdBal05,
				YtdBal06, YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11,
				YtdBal12,YTDEstimated)

SELECT DISTINCT @YTDNetIncAcct, 0, 0,
	(SELECT BalanceType FROM Ledger l WHERE l.LedgerID = z.LedgerID),
	'7/9/1922', 0, z.CpnyID, getdate(),'01520',@pUserID,
	z.CuryID, '', r.FiscYr, ' ', z.LedgerID,
	getdate(),'01520',@pUserID, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	'', '',0,0,0,0,'','',1,1,'','',
	'', z.Sub, ' ', ' ', 0, 0, '', '', '', '',
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM vp_01520PostNetInc z, #TimeRange r, vs_Company c
WHERE  Useraddress=@Useraddress and c.CpnyID=z.CpnyID and c.DatabaseName=DB_NAME() and
       NOT EXISTS (SELECT a.Acct FROM AcctHist a WHERE a.Acct = @YTDNetIncAcct
	AND a.Sub = z.Sub AND a.FiscYr = r.FiscYr AND a.LedgerID = z.LedgerID
	AND a.CpnyID=z.CpnyID)

IF @@ERROR < > 0 GOTO ABORT

/*****Insert AcctHist records for Retained Earnings that don't currently exist. *****/
INSERT AcctHist (Acct, AnnBdgt, AnnMemo1, BalanceType, BdgtRvsnDate, BegBal,
				CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId, DistType,
				FiscYr, LastClosePerNbr, LedgerID, LUpd_DateTime, LUpd_Prog,
				LUpd_User, NoteID, PtdAlloc00, PtdAlloc01, PtdAlloc02, PtdAlloc03,
				PtdAlloc04, PtdAlloc05, PtdAlloc06, PtdAlloc07, PtdAlloc08,
				PtdAlloc09, PtdAlloc10, PtdAlloc11, PtdAlloc12, PtdBal00,
				PtdBal01, PtdBal02, PtdBal03, PtdBal04, PtdBal05, PtdBal06,
				PtdBal07, PtdBal08, PtdBal09, PtdBal10, PtdBal11, PtdBal12,
				PtdCon00, PtdCon01, PtdCon02, PtdCon03, PtdCon04, PtdCon05,
				PtdCon06, PtdCon07, PtdCon08, PtdCon09, PtdCon10, PtdCon11,
				PtdCon12, S4Future01, S4Future02, S4Future03, S4Future04,
				S4Future05, S4Future06, S4Future07, S4Future08, S4Future09,
				S4Future10, S4Future11, S4Future12, SpreadSheetType, Sub,
				User1, User2 ,User3, User4, User5, User6, User7, User8,
				YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04, YtdBal05,
				YtdBal06, YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11,
				YtdBal12,YTDEstimated)

SELECT DISTINCT @RetEarnAcct, 0, 0,
	(SELECT BalanceType FROM Ledger l WHERE l.LedgerID = z.LedgerID),
	'7/9/1922', 0, z.CpnyID, getdate(),'01520',@pUserID,
	z.CuryID, '', RTRIM(LTRIM(STR(CONVERT(INT,r.FiscYr) + 1))), ' ', z.LedgerID,
	getdate(),'01520',@pUserID, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	'', '',0,0,0,0,'','',1,1,'','',
	'', z.Sub, ' ', ' ', 0, 0, '', '', '', '',
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM vp_01520PostNetInc z, #TimeRange r, vs_Company c
WHERE UserAddress= @UserAddress and c.CpnyID=z.CpnyID and c.DatabaseName=DB_NAME() and
      NOT EXISTS (SELECT a.Acct FROM AcctHist a WHERE a.Acct = @RetEarnAcct
	AND a.Sub = z.Sub AND a.FiscYr = RTRIM(LTRIM(STR(CONVERT(INT,r.FiscYr) + 1))) AND
	a.LedgerID = z.LedgerID AND a.CpnyID=z.CpnyID)
	AND r.FiscYr < SUBSTRING(@PerNbr,1,4)

IF @@ERROR < > 0 GOTO ABORT

/***** The Retained Earnings statement will insert records for future periods, these records 	*****/
/***** need to be removed.									*****/
DELETE FROM AcctHist WHERE Acct = @RetEarnAcct AND FiscYr > SUBSTRING(@PerNbr,1,4)

IF @@ERROR < > 0 GOTO ABORT

/***** Update AcctHist period to date and year to date balances. *****/
UPDATE AcctHist

	SET PtdBal00=	Round(h.PtdBal00 + v.Net00, v.DecPl),
	PtdBal01=	Round(h.PtdBal01 + v.Net01, v.DecPl),
	PtdBal02=	Round(h.PtdBal02 + v.Net02, v.DecPl),
	PtdBal03=	Round(h.PtdBal03 + v.Net03, v.DecPl),
	PtdBal04=	Round(h.PtdBal04 + v.Net04, v.DecPl),
	PtdBal05=	Round(h.PtdBal05 + v.Net05, v.DecPl),
	PtdBal06=	Round(h.PtdBal06 + v.Net06, v.DecPl),
	PtdBal07=	Round(h.PtdBal07 + v.Net07, v.DecPl),
	PtdBal08=	Round(h.PtdBal08 + v.Net08, v.DecPl),
	PtdBal09=	Round(h.PtdBal09 + v.Net09, v.DecPl),
	PtdBal10=	Round(h.PtdBal10 + v.Net10, v.DecPl),
	PtdBal11=	Round(h.PtdBal11 + v.Net11, v.DecPl),
	PtdBal12=	Round(h.PtdBal12 + v.Net12, v.DecPl),
	YtdBal00=	Round(h.YtdBal00 + v.Ytd00, v.DecPl),
	YtdBal01=	Round(h.YtdBal01 + v.Ytd01, v.DecPl),
	YtdBal02=	Round(h.YtdBal02 + v.Ytd02, v.DecPl),
	YtdBal03=	Round(h.YtdBal03 + v.Ytd03, v.DecPl),
	YtdBal04=	Round(h.YtdBal04 + v.Ytd04, v.DecPl),
	YtdBal05=	Round(h.YtdBal05 + v.Ytd05, v.DecPl),
	YtdBal06=	Round(h.YtdBal06 + v.Ytd06, v.DecPl),
	YtdBal07=	Round(h.YtdBal07 + v.Ytd07, v.DecPl),
	YtdBal08=	Round(h.YtdBal08 + v.Ytd08, v.DecPl),
	YtdBal09=	Round(h.YtdBal09 + v.Ytd09, v.DecPl),
	YtdBal10=	Round(h.YtdBal10 + v.Ytd10, v.DecPl),
	YtdBal11=	Round(h.YtdBal11 + v.Ytd11, v.DecPl),
	YtdBal12=	Round(h.YtdBal12 + v.Ytd12, v.DecPl),
	BegBal=	Round(h.BegBal + v.BegBal, v.DecPl),

	Lupd_DateTime = GetDate(),
	LUpd_Prog = '01520',
	LUpd_User = @pUserID

FROM vp_01520PostTranYr v, AcctHist h
WHERE UserAddress=@Useraddress AND
      v.Acct = h.Acct AND v.Sub = h.Sub AND v.LedgerID = h.LedgerID AND v.FiscYr = h.FiscYr
	AND v.CpnyID=h.CpnyID

IF @@ERROR < > 0 GOTO ABORT

/***** Update AcctHist YTD Net Income balances. *****/
UPDATE AcctHist
	SET PtdBal00=	ROUND(h.PtdBal00 + z.Net00, z.DecPl),
	PtdBal01=	ROUND(h.PtdBal01 + z.Net01, z.DecPl),
	PtdBal02=	ROUND(h.PtdBal02 + z.Net02, z.DecPl),
	PtdBal03=	ROUND(h.PtdBal03 + z.Net03, z.DecPl),
	PtdBal04=	ROUND(h.PtdBal04 + z.Net04, z.DecPl),
	PtdBal05=	ROUND(h.PtdBal05 + z.Net05, z.DecPl),
	PtdBal06=	ROUND(h.PtdBal06 + z.Net06, z.DecPl),
	PtdBal07=	ROUND(h.PtdBal07 + z.Net07, z.DecPl),
	PtdBal08=	ROUND(h.PtdBal08 + z.Net08, z.DecPl),
	PtdBal09=	ROUND(h.PtdBal09 + z.Net09, z.DecPl),
	PtdBal10=	ROUND(h.PtdBal10 + z.Net10, z.DecPl),
	PtdBal11=	ROUND(h.PtdBal11 + z.Net11, z.DecPl),
	PtdBal12=	ROUND(h.PtdBal12 + z.Net12, z.DecPl),

	PtdCon00=	ROUND(h.PtdCon00 + z.Net00, z.DecPl),
	PtdCon01=	ROUND(h.PtdCon01 + z.Net01, z.DecPl),
	PtdCon02=	ROUND(h.PtdCon02 + z.Net02, z.DecPl),
	PtdCon03=	ROUND(h.PtdCon03 + z.Net03, z.DecPl),
	PtdCon04=	ROUND(h.PtdCon04 + z.Net04, z.DecPl),
	PtdCon05=	ROUND(h.PtdCon05 + z.Net05, z.DecPl),
	PtdCon06=	ROUND(h.PtdCon06 + z.Net06, z.DecPl),
	PtdCon07=	ROUND(h.PtdCon07 + z.Net07, z.DecPl),
	PtdCon08=	ROUND(h.PtdCon08 + z.Net08, z.DecPl),
	PtdCon09=	ROUND(h.PtdCon09 + z.Net09, z.DecPl),
	PtdCon10=	ROUND(h.PtdCon10 + z.Net10, z.DecPl),
	PtdCon11=	ROUND(h.PtdCon11 + z.Net11, z.DecPl),
	PtdCon12=	ROUND(h.PtdCon12 + z.Net12, z.DecPl),

	YtdBal00=	ROUND(h.YtdBal00 + z.Net00, z.DecPl),
	YtdBal01=	ROUND(CASE
				WHEN s.nbrper >= 2 AND ((RIGHT(s.PerNbr,2) >= '02' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal01 + z.Net00 + z.Net01
				ELSE h.YtdBal01
			END, z.DecPl),
	YtdBal02=	ROUND(CASE
				WHEN s.nbrper >= 3 AND ((RIGHT(s.PerNbr,2) >= '03' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal02 + z.Net00 + z.Net01 + z.Net02
				ELSE h.YtdBal02
			END, z.DecPl),
	YtdBal03=	ROUND(CASE
				WHEN s.nbrper >= 4 AND ((RIGHT(s.PerNbr,2) >= '04' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal03 + z.Net00 + z.Net01 + z.Net02 + z.Net03
				ELSE h.YtdBal03
			END, z.DecPl),
	YtdBal04=	ROUND(CASE
				WHEN s.nbrper >= 5 AND ((RIGHT(s.PerNbr,2) >= '05' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal04 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04
				ELSE h.YtdBal04
			END, z.DecPl),
	YtdBal05=	ROUND(CASE
				WHEN s.nbrper >= 6 AND ((RIGHT(s.PerNbr,2) >= '06' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal05 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05
				ELSE h.YtdBal05
			END, z.DecPl),
	YtdBal06=	ROUND(CASE
				WHEN s.nbrper >= 7 AND ((RIGHT(s.PerNbr,2) >= '07' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal06 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06
				ELSE h.YtdBal06
			END, z.DecPl),
	YtdBal07=	ROUND(CASE
				WHEN s.nbrper >= 8 AND ((RIGHT(s.PerNbr,2) >= '08' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal07 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07
				ELSE h.YtdBal07
			END, z.DecPl),
	YtdBal08=	ROUND(CASE
				WHEN s.nbrper >= 9 AND ((RIGHT(s.PerNbr,2) >= '09' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal08 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07 + z.Net08				ELSE h.YtdBal08
			END, z.DecPl),
	YtdBal09=	ROUND(CASE
				WHEN s.nbrper >= 10 AND ((RIGHT(s.PerNbr,2) >= '10' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal09 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07 + z.Net08 + z.Net09
				ELSE h.YtdBal09
			END, z.DecPl),
	YtdBal10=	ROUND(CASE
				WHEN s.nbrper >= 11 AND ((RIGHT(s.PerNbr,2) >= '11' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal10 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07 + z.Net08 + z.Net09 + z.Net10
				ELSE h.YtdBal10
			END, z.DecPl),
	YtdBal11=	ROUND(CASE
				WHEN s.nbrper >= 12 AND ((RIGHT(s.PerNbr,2) >= '12' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal11 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07 + z.Net08 + z.Net09 + z.Net10 + z.Net11
				ELSE h.YtdBal11
			END, z.DecPl),
	YtdBal12=	ROUND(CASE
				WHEN s.nbrper >= 13 AND ((RIGHT(s.PerNbr,2) >= '13' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal12 + z.NetYear
				ELSE h.YtdBal12
			END, z.DecPl),

	Lupd_DateTime = GetDate(),
	LUpd_Prog = '01520',
	LUpd_User = @pUserID

FROM vp_01520PostNetInc z, AcctHist h, GLSetup s (NOLOCK)
WHERE UserAddress = @UserAddress
  AND h.Acct = s.ytdnetincAcct
  AND z.Sub = h.Sub
  AND z.LedgerID = h.LedgerID
  AND z.FiscYr = h.FiscYr AND z.CpnyID=h.CpnyID

IF @@ERROR < > 0 GOTO ABORT

/***** Update AcctHist Retained Earnings Balances. *****/
UPDATE h
		SET YtdBal00=	h.YtdBal00 + z.NetYear,

	YtdBal01=	CASE
				WHEN (z.nbrper >= 2 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '02')) THEN h.YtdBal01 + z.NetYear
				ELSE h.YtdBal01
			END,
	YtdBal02=	CASE
				WHEN (z.nbrper >= 3 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '03')) THEN h.YtdBal02 + z.NetYear
				ELSE h.YtdBal02
			END,
	YtdBal03=	CASE
				WHEN (z.nbrper >= 4 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '04')) THEN h.YtdBal03 + z.NetYear
				ELSE h.YtdBal03
			END,
	YtdBal04=	CASE
				WHEN (z.nbrper >= 5 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '05')) THEN h.YtdBal04 + z.NetYear
				ELSE h.YtdBal04
			END,
	YtdBal05=	CASE
				WHEN (z.nbrper >= 6 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '06')) THEN h.YtdBal05 + z.NetYear
				ELSE h.YtdBal05
			END,
	YtdBal06=	CASE
				WHEN (z.nbrper >= 7 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '07')) THEN h.YtdBal06 + z.NetYear
				ELSE h.YtdBal06
			END,
	YtdBal07=	CASE
				WHEN (z.nbrper >= 8 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '08')) THEN h.YtdBal07 + z.NetYear
				ELSE h.YtdBal07
			END,
	YtdBal08=	CASE
				WHEN (z.nbrper >= 9 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '09')) THEN h.YtdBal08 + z.NetYear
				ELSE h.YtdBal08
			END,
	YtdBal09=	CASE
				WHEN (z.nbrper >= 10 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '10')) THEN h.YtdBal09 + z.NetYear
				ELSE h.YtdBal09
			END,
	YtdBal10=	CASE
				WHEN (z.nbrper >= 11 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '11')) THEN h.YtdBal10 + z.NetYear
				ELSE h.YtdBal10
			END,
	YtdBal11=	CASE
				WHEN (z.nbrper >= 12 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '12')) THEN h.YtdBal11 + z.NetYear
				ELSE h.YtdBal11
			END,
	YtdBal12=	CASE
				WHEN (z.nbrper >= 13 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '13')) THEN h.YtdBal12 + z.NetYear
				ELSE h.YtdBal12
			END,
	BegBal=		h.BegBal + z.NetYear,

	Lupd_DateTime = GetDate(),
	Lupd_Prog = '01520',
	LUpd_User = @pUserID

FROM	AcctHist h INNER JOIN
	(SELECT	h.CpnyID, h.Acct, h.Sub, h.LedgerID, h.FiscYr,
			NbrPer = MAX(s.NbrPer), PerNbr = MAX(s.PerNbr),
			NetYear = SUM(z.NetYear)
	FROM		vp_01520PostNetInc z, AcctHist h, GLSetup s (NOLOCK)
	WHERE	UserAddress = @UserAddress
		 	AND h.Acct = s.RetEarnAcct AND z.Sub = h.Sub
 			AND z.LedgerID = h.LedgerID AND h.FiscYr <= SUBSTRING(s.PerNbr,1,4)
			AND z.CpnyID=h.CpnyID
			AND z.FiscYr < h.FiscYr
	GROUP BY	h.CpnyID, h.Acct, h.Sub, h.LedgerID, h.FiscYr) z
	ON h.CpnyID = z.CpnyID AND h.Acct = z.Acct AND h.Sub = z.Sub AND h.LedgerID = z.LedgerID AND h.FiscYr = z.FiscYr
IF @@ERROR < > 0 GOTO ABORT

/***** MULTI-CURRENCY *****/

/***** Insert CuryAcct records that don't currently exist. *****/
INSERT CuryAcct (Acct, BalanceType, BaseCuryID, BegBal, CpnyID, Crtd_DateTime,
				Crtd_Prog,Crtd_User, CuryBegBal, CuryId, CuryPtdBal00,
				CuryPtdBal01, CuryPtdBal02, CuryPtdBal03, CuryPtdBal04,
				CuryPtdBal05, CuryPtdBal06, CuryPtdBal07, CuryPtdBal08,
				CuryPtdBal09, CuryPtdBal10, CuryPtdBal11, CuryPtdBal12,
				CuryYtdBal00, CuryYtdBal01, CuryYtdBal02, CuryYtdBal03,
				CuryYtdBal04, CuryYtdBal05, CuryYtdBal06, CuryYtdBal07,
				CuryYtdBal08, CuryYtdBal09, CuryYtdBal10, CuryYtdBal11,
				CuryYtdBal12, FiscYr, LedgerID, LUpd_DateTime, LUpd_Prog,
				LUpd_User, NoteId, PtdBal00, PtdBal01, PtdBal02, PtdBal03,
				PtdBal04, PtdBal05, PtdBal06, PtdBal07, PtdBal08, PtdBal09,
				PtdBal10, PtdBal11, PtdBal12, S4Future01, S4Future02,
				S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
				S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
				Sub, User1, User2, User3, User4, User5, User6, User7, User8,
				YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04, YtdBal05,
				YtdBal06, YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11,
				YtdBal12)

SELECT DISTINCT z.Acct, (SELECT BalanceType FROM Ledger l WHERE l.LedgerID = z.LedgerID),
	z.BaseCuryID, 0,z.CpnyID, getdate(),'01520',@pUserID, 0, z.CuryID,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	r.FiscYr, z.LedgerID, getdate(),'01520',@pUserID, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	'', '',0,0,0,0,'','',1,1,'','',
	z.Sub, ' ', ' ', 0, 0, '', '', '', '',
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM vp_01520PostTranMC z, #TimeRange r, vs_Company c
WHERE UserAddress = @UserAddress and c.CpnyID=z.CpnyID and c.DatabaseName=DB_NAME()
  AND NOT EXISTS (SELECT a.Acct FROM CuryAcct a WHERE a.Acct = z.Acct AND a.Sub = z.Sub AND
	a.FiscYr = r.FiscYr AND a.LedgerID = z.LedgerID AND a.CuryID = z.CuryID
	AND a.CpnyID=z.CpnyID) AND
	((z.AcctType NOT IN ('A', 'L') AND z.FiscYr = r.FiscYr) OR
	(z.AcctType IN ('A', 'L') AND z.FiscYr <= r.FiscYr))

IF @@ERROR < > 0 GOTO ABORT

/***** Insert CuryAcct records for YTD Net Income that don't currently exist. *****/
INSERT CuryAcct (Acct, BalanceType, BaseCuryID, BegBal, CpnyID, Crtd_DateTime,
				Crtd_Prog,Crtd_User, CuryBegBal, CuryId, CuryPtdBal00,
				CuryPtdBal01, CuryPtdBal02, CuryPtdBal03, CuryPtdBal04,
				CuryPtdBal05, CuryPtdBal06, CuryPtdBal07, CuryPtdBal08,
				CuryPtdBal09, CuryPtdBal10, CuryPtdBal11, CuryPtdBal12,
				CuryYtdBal00, CuryYtdBal01, CuryYtdBal02, CuryYtdBal03,
				CuryYtdBal04, CuryYtdBal05, CuryYtdBal06, CuryYtdBal07,
				CuryYtdBal08, CuryYtdBal09, CuryYtdBal10, CuryYtdBal11,
				CuryYtdBal12, FiscYr, LedgerID, LUpd_DateTime, LUpd_Prog,
				LUpd_User, NoteId, PtdBal00, PtdBal01, PtdBal02, PtdBal03,
				PtdBal04, PtdBal05, PtdBal06, PtdBal07, PtdBal08, PtdBal09,
				PtdBal10, PtdBal11, PtdBal12, S4Future01, S4Future02,
				S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
				S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
				Sub, User1, User2, User3, User4, User5, User6, User7, User8,
				YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04, YtdBal05,
				YtdBal06, YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11,
				YtdBal12)

SELECT DISTINCT @YTDNetIncAcct,
	(SELECT BalanceType FROM Ledger l WHERE l.LedgerID = z.LedgerID),
	z.BaseCuryID, 0, z.CpnyID, getdate(),'01520',@pUserID, 0, z.CuryID,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	r.FiscYr, z.LedgerID, getdate(),'01520',@pUserID, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	'', '',0,0,0,0,'','',1,1,'','',
	z.Sub, ' ', ' ', 0, 0, '', '', '', '',
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM vp_01520PostNetIncMC z, #TimeRange r, vs_Company c
WHERE UserAddress = @UserAddress and c.CpnyID=z.CpnyID and c.DatabaseName=DB_NAME()
  AND NOT EXISTS (SELECT a.Acct FROM CuryAcct a WHERE a.Acct = @YTDNetIncAcct
	AND a.Sub = z.Sub AND a.FiscYr = r.FiscYr AND a.LedgerID = z.LedgerID
	AND a.CuryID = z.CuryID AND a.CpnyID=z.CpnyID)

IF @@ERROR < > 0 GOTO ABORT

/*****Insert CuryAcct records for Retained Earnings that don't currently exist. *****/
INSERT CuryAcct (Acct, BalanceType, BaseCuryID, BegBal, CpnyID, Crtd_DateTime,
				Crtd_Prog,Crtd_User, CuryBegBal, CuryId, CuryPtdBal00,
				CuryPtdBal01, CuryPtdBal02, CuryPtdBal03, CuryPtdBal04,
				CuryPtdBal05, CuryPtdBal06, CuryPtdBal07, CuryPtdBal08,
				CuryPtdBal09, CuryPtdBal10, CuryPtdBal11, CuryPtdBal12,
				CuryYtdBal00, CuryYtdBal01, CuryYtdBal02, CuryYtdBal03,
				CuryYtdBal04, CuryYtdBal05, CuryYtdBal06, CuryYtdBal07,
				CuryYtdBal08, CuryYtdBal09, CuryYtdBal10, CuryYtdBal11,
				CuryYtdBal12, FiscYr, LedgerID, LUpd_DateTime, LUpd_Prog,
				LUpd_User, NoteId, PtdBal00, PtdBal01, PtdBal02, PtdBal03,
				PtdBal04, PtdBal05, PtdBal06, PtdBal07, PtdBal08, PtdBal09,
				PtdBal10, PtdBal11, PtdBal12, S4Future01, S4Future02,
				S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
				S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
				Sub, User1, User2, User3, User4, User5, User6, User7, User8,
				YtdBal00, YtdBal01, YtdBal02, YtdBal03, YtdBal04, YtdBal05,
				YtdBal06, YtdBal07, YtdBal08, YtdBal09, YtdBal10, YtdBal11,
				YtdBal12)

SELECT DISTINCT @RetEarnAcct,
	(SELECT BalanceType FROM Ledger l WHERE l.LedgerID = z.LedgerID),
	z.BaseCuryID, 0, z.CpnyID, getdate(),'01520',@pUserID, 0, z.CuryID,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	LTRIM(STR(CONVERT(INT,r.FiscYr) + 1)), z.LedgerID, getdate(),'01520',@pUserID, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	'', '',0,0,0,0,'','',1,1,'','',
	z.Sub, ' ', ' ', 0, 0, '', '', '', '',
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM vp_01520PostNetIncMC z, #TimeRange r, vs_Company c
WHERE UserAddress = @UserAddress and c.CpnyID=z.CpnyID and c.DatabaseName=DB_NAME()
  AND NOT EXISTS (SELECT a.Acct FROM CuryAcct a WHERE a.Acct = @RetEarnAcct
	AND a.Sub = z.Sub AND a.FiscYr = RTRIM(LTRIM(STR(CONVERT(INT,r.FiscYr) + 1))) AND
	a.LedgerID = z.LedgerID AND a.CuryID = z.CuryID
	AND a.CpnyID=z.CpnyID) AND r.FiscYr < SUBSTRING(@PerNbr,1,4)

IF @@ERROR < > 0 GOTO ABORT

/***** The Retained Earnings statement will insert records for future periods, these records 	*****/
/***** need to be removed.									*****/
DELETE FROM CuryAcct
      WHERE Acct = @RetEarnAcct
        AND FiscYr > SUBSTRING(@PerNbr,1,4)

IF @@ERROR < > 0 GOTO ABORT

/***** Update CuryAcct period to date and year to date balances. *****/
UPDATE CuryAcct

	SET PtdBal00=	h.PtdBal00 + v.Net00,
	PtdBal01=	h.PtdBal01 + v.Net01,
	PtdBal02=	h.PtdBal02 + v.Net02,
	PtdBal03=	h.PtdBal03 + v.Net03,
	PtdBal04=	h.PtdBal04 + v.Net04,
	PtdBal05=	h.PtdBal05 + v.Net05,
	PtdBal06=	h.PtdBal06 + v.Net06,
	PtdBal07=	h.PtdBal07 + v.Net07,
	PtdBal08=	h.PtdBal08 + v.Net08,
	PtdBal09=	h.PtdBal09 + v.Net09,
	PtdBal10=	h.PtdBal10 + v.Net10,
	PtdBal11=	h.PtdBal11 + v.Net11,
	PtdBal12=	h.PtdBal12 + v.Net12,
	CuryPtdBal00=	h.CuryPtdBal00 + v.CuryNet00,
	CuryPtdBal01=	h.CuryPtdBal01 + v.CuryNet01,
	CuryPtdBal02=	h.CuryPtdBal02 + v.CuryNet02,
	CuryPtdBal03=	h.CuryPtdBal03 + v.CuryNet03,
	CuryPtdBal04=	h.CuryPtdBal04 + v.CuryNet04,
	CuryPtdBal05=	h.CuryPtdBal05 + v.CuryNet05,
	CuryPtdBal06=	h.CuryPtdBal06 + v.CuryNet06,
	CuryPtdBal07=	h.CuryPtdBal07 + v.CuryNet07,
	CuryPtdBal08=	h.CuryPtdBal08 + v.CuryNet08,
	CuryPtdBal09=	h.CuryPtdBal09 + v.CuryNet09,
	CuryPtdBal10=	h.CuryPtdBal10 + v.CuryNet10,
	CuryPtdBal11=	h.CuryPtdBal11 + v.CuryNet11,
	CuryPtdBal12=	h.CuryPtdBal12 + v.CuryNet12,
	YtdBal00=	h.YtdBal00 + v.Ytd00,
	YtdBal01=	h.YtdBal01 + v.Ytd01,
	YtdBal02=	h.YtdBal02 + v.Ytd02,
	YtdBal03=	h.YtdBal03 + v.Ytd03,
	YtdBal04=	h.YtdBal04 + v.Ytd04,
	YtdBal05=	h.YtdBal05 + v.Ytd05,
	YtdBal06=	h.YtdBal06 + v.Ytd06,
	YtdBal07=	h.YtdBal07 + v.Ytd07,
	YtdBal08=	h.YtdBal08 + v.Ytd08,
	YtdBal09=	h.YtdBal09 + v.Ytd09,
	YtdBal10=	h.YtdBal10 + v.Ytd10,
	YtdBal11=	h.YtdBal11 + v.Ytd11,
	YtdBal12=	h.YtdBal12 + v.Ytd12,
	BegBal=		h.BegBal + v.BegBal,
	CuryYtdBal00=	h.CuryYtdBal00 + v.CuryYtd00,
	CuryYtdBal01=	h.CuryYtdBal01 + v.CuryYtd01,
	CuryYtdBal02=	h.CuryYtdBal02 + v.CuryYtd02,
	CuryYtdBal03=	h.CuryYtdBal03 + v.CuryYtd03,
	CuryYtdBal04=	h.CuryYtdBal04 + v.CuryYtd04,
	CuryYtdBal05=	h.CuryYtdBal05 + v.CuryYtd05,
	CuryYtdBal06=	h.CuryYtdBal06 + v.CuryYtd06,
	CuryYtdBal07=	h.CuryYtdBal07 + v.CuryYtd07,
	CuryYtdBal08=	h.CuryYtdBal08 + v.CuryYtd08,
	CuryYtdBal09=	h.CuryYtdBal09 + v.CuryYtd09,
	CuryYtdBal10=	h.CuryYtdBal10 + v.CuryYtd10,
	CuryYtdBal11=	h.CuryYtdBal11 + v.CuryYtd11,
	CuryYtdBal12=	h.CuryYtdBal12 + v.CuryYtd12,
	CuryBegBal=	h.CuryBegBal + v.CuryBegBal,

	Lupd_DateTime = GetDate(),
	LUpd_Prog = '01520',
	LUpd_User = @pUserID

FROM vp_01520PostTranYrMC v, CuryAcct h
WHERE UserAddress = @UserAddress
  AND v.Acct = h.Acct AND v.Sub = h.Sub AND v.LedgerID = h.LedgerID AND v.CuryID = h.CuryID
AND v.FiscYr = h.FiscYr AND v.CpnyID=h.CpnyID

IF @@ERROR < > 0 GOTO ABORT

/***** Update CuryAcct YTD Net Income balances. *****/
UPDATE CuryAcct
	SET PtdBal00=	h.PtdBal00 + z.Net00,
	PtdBal01=	h.PtdBal01 + z.Net01,
	PtdBal02=	h.PtdBal02 + z.Net02,
	PtdBal03=	h.PtdBal03 + z.Net03,
	PtdBal04=	h.PtdBal04 + z.Net04,
	PtdBal05=	h.PtdBal05 + z.Net05,
	PtdBal06=	h.PtdBal06 + z.Net06,
	PtdBal07=	h.PtdBal07 + z.Net07,
	PtdBal08=	h.PtdBal08 + z.Net08,
	PtdBal09=	h.PtdBal09 + z.Net09,
	PtdBal10=	h.PtdBal10 + z.Net10,
	PtdBal11=	h.PtdBal11 + z.Net11,
	PtdBal12=	h.PtdBal12 + z.Net12,
	CuryPtdBal00=	h.CuryPtdBal00 + z.CuryNet00,
	CuryPtdBal01=	h.CuryPtdBal01 + z.CuryNet01,
	CuryPtdBal02=	h.CuryPtdBal02 + z.CuryNet02,
	CuryPtdBal03=	h.CuryPtdBal03 + z.CuryNet03,
	CuryPtdBal04=	h.CuryPtdBal04 + z.CuryNet04,
	CuryPtdBal05=	h.CuryPtdBal05 + z.CuryNet05,

	CuryPtdBal06=	h.CuryPtdBal06 + z.CuryNet06,
	CuryPtdBal07=	h.CuryPtdBal07 + z.CuryNet07,
	CuryPtdBal08=	h.CuryPtdBal08 + z.CuryNet08,
	CuryPtdBal09=	h.CuryPtdBal09 + z.CuryNet09,
	CuryPtdBal10=	h.CuryPtdBal10 + z.CuryNet10,
	CuryPtdBal11=	h.CuryPtdBal11 + z.CuryNet11,
	CuryPtdBal12=	h.CuryPtdBal12 + z.CuryNet12,
	YtdBal00=	h.YtdBal00 + z.Net00,
	YtdBal01=	CASE
				WHEN s.nbrper >= 2 AND ((RIGHT(s.PerNbr,2) >= '02' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal01 + z.Net00 + z.Net01
				ELSE h.YtdBal01
			END,
	YtdBal02=	CASE
				WHEN s.nbrper >= 3 AND ((RIGHT(s.PerNbr,2) >= '03' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal02 + z.Net00 + z.Net01 + z.Net02
				ELSE h.YtdBal02
			END,
	YtdBal03=	CASE
				WHEN s.nbrper >= 4 AND ((RIGHT(s.PerNbr,2) >= '04' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal03 + z.Net00 + z.Net01 + z.Net02 + z.Net03
				ELSE h.YtdBal03
			END,
	YtdBal04=	CASE
				WHEN s.nbrper >= 5 AND ((RIGHT(s.PerNbr,2) >= '05' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal04 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04
				ELSE h.YtdBal04
			END,
	YtdBal05=	CASE
				WHEN s.nbrper >= 6 AND ((RIGHT(s.PerNbr,2) >= '06' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal05 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05
				ELSE h.YtdBal05
			END,
	YtdBal06=	CASE
				WHEN s.nbrper >= 7 AND ((RIGHT(s.PerNbr,2) >= '07' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal06 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06
				ELSE h.YtdBal06
			END,
	YtdBal07=	CASE
				WHEN s.nbrper >= 8 AND ((RIGHT(s.PerNbr,2) >= '08' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal07 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07
				ELSE h.YtdBal07
			END,
	YtdBal08=	CASE
				WHEN s.nbrper >= 9 AND ((RIGHT(s.PerNbr,2) >= '09' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal08 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07 + z.Net08
				ELSE h.YtdBal08
			END,
	YtdBal09=	CASE
				WHEN s.nbrper >= 10 AND ((RIGHT(s.PerNbr,2) >= '10' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal09 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07 + z.Net08 + z.Net09
				ELSE h.YtdBal09
			END,
	YtdBal10=	CASE
				WHEN s.nbrper >= 11 AND ((RIGHT(s.PerNbr,2) >= '11' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal10 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07 + z.Net08 + z.Net09 + z.Net10
				ELSE h.YtdBal10
			END,
	YtdBal11=	CASE
				WHEN s.nbrper >= 12 AND ((RIGHT(s.PerNbr,2) >= '12' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal11 + z.Net00 + z.Net01 + z.Net02 + z.Net03 + z.Net04 + z.Net05 + z.Net06 + z.Net07 + z.Net08 + z.Net09 + z.Net10 + z.Net11
				ELSE h.YtdBal11
			END,
	YtdBal12=	CASE
				WHEN s.nbrper >= 13 AND ((RIGHT(s.PerNbr,2) >= '13' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.YtdBal12 + z.NetYear
				ELSE h.YtdBal12
			END,
	CuryYtdBal00=	h.CuryYtdBal00 + z.CuryNet00,
	CuryYtdBal01=	CASE
				WHEN s.nbrper >= 2 AND ((RIGHT(s.PerNbr,2) >= '02' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal01 + z.CuryNet00 + z.CuryNet01
				ELSE h.CuryYtdBal01
			END,
	CuryYtdBal02=	CASE
				WHEN s.nbrper >= 3 AND ((RIGHT(s.PerNbr,2) >= '03' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal02 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02
				ELSE h.CuryYtdBal02
			END,
	CuryYtdBal03=	CASE
				WHEN s.nbrper >= 4 AND ((RIGHT(s.PerNbr,2) >= '04' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal03 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02 + z.CuryNet03
				ELSE h.CuryYtdBal03
			END,
	CuryYtdBal04=	CASE
				WHEN s.nbrper >= 5 AND ((RIGHT(s.PerNbr,2) >= '05' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal04 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02 + z.CuryNet03 + z.CuryNet04
				ELSE h.CuryYtdBal04
			END,
	CuryYtdBal05=	CASE
				WHEN s.nbrper >= 6 AND ((RIGHT(s.PerNbr,2) >= '06' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal05 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02 + z.CuryNet03 + z.CuryNet04 + z.CuryNet05
				ELSE h.CuryYtdBal05
			END,
	CuryYtdBal06=	CASE
				WHEN s.nbrper >= 7 AND ((RIGHT(s.PerNbr,2) >= '07' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal06 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02 + z.CuryNet03 + z.CuryNet04 + z.CuryNet05 + z.CuryNet06
				ELSE h.CuryYtdBal06
			END,
	CuryYtdBal07=	CASE
				WHEN s.nbrper >= 8 AND ((RIGHT(s.PerNbr,2) >= '08' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal07 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02 + z.CuryNet03 + z.CuryNet04 + z.CuryNet05 + z.CuryNet06 + z.CuryNet07
				ELSE h.CuryYtdBal07
			END,
	CuryYtdBal08=	CASE
				WHEN s.nbrper >= 9 AND ((RIGHT(s.PerNbr,2) >= '09' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal08 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02 + z.CuryNet03 + z.CuryNet04 + z.CuryNet05 + z.CuryNet06 + z.CuryNet07 + z.CuryNet08
				ELSE h.CuryYtdBal08
			END,
	CuryYtdBal09=	CASE
				WHEN s.nbrper >= 10 AND ((RIGHT(s.PerNbr,2) >= '10' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal09 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02 + z.CuryNet03 + z.CuryNet04 + z.CuryNet05 + z.CuryNet06 + z.CuryNet07 + z.CuryNet08 + z.CuryNet09
				ELSE h.CuryYtdBal09
			END,
	CuryYtdBal10=	CASE
				WHEN s.nbrper >= 11 AND ((RIGHT(s.PerNbr,2) >= '11' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal10 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02 + z.CuryNet03 + z.CuryNet04 + z.CuryNet05 + z.CuryNet06 + z.CuryNet07 + z.CuryNet08 + z.CuryNet09 + z.CuryNet10
				ELSE h.CuryYtdBal10
			END,
	CuryYtdBal11=	CASE
				WHEN s.nbrper >= 12 AND ((RIGHT(s.PerNbr,2) >= '12' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal11 + z.CuryNet00 + z.CuryNet01 + z.CuryNet02 + z.CuryNet03 + z.CuryNet04 + z.CuryNet05 + z.CuryNet06 + z.CuryNet07 + z.CuryNet08 + z.CuryNet09 + z.CuryNet10 + z.CuryNet11
				ELSE h.CuryYtdBal11
			END,
	CuryYtdBal12=	CASE
				WHEN s.nbrper >= 13 AND ((RIGHT(s.PerNbr,2) >= '13' AND z.FiscYr = SUBSTRING(s.PerNbr, 1, 4)) OR z.FiscYr < SUBSTRING(s.PerNbr, 1, 4)) THEN h.CuryYtdBal12 + z.CuryNetYear
				ELSE h.CuryYtdBal12
			END,

	Lupd_DateTime = GetDate(),
	LUpd_Prog = '01520',
	LUpd_User = @pUserID

FROM vp_01520PostNetIncMC z, CuryAcct h, GLSetup s (NOLOCK)
WHERE UserAddress = @UserAddress
  AND h.Acct = s.YTDNetIncAcct AND z.Sub = h.Sub AND z.LedgerID = h.LedgerID
AND z.FiscYr = h.FiscYr AND z.CuryID = h.CuryID AND z.CpnyID=h.CpnyID

IF @@ERROR < > 0 GOTO ABORT

/***** Update CuryAcct Retained Earnings Balances. *****/
UPDATE h
		SET YtdBal00=	h.YtdBal00 + z.NetYear,

	YtdBal01=	CASE
				WHEN (z.nbrper >= 2 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '02')) THEN h.YtdBal01 + z.NetYear
				ELSE h.YtdBal01
			END,
	YtdBal02=	CASE
				WHEN (z.nbrper >= 3 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '03')) THEN h.YtdBal02 + z.NetYear
				ELSE h.YtdBal02
			END,
	YtdBal03=	CASE
				WHEN (z.nbrper >= 4 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '04')) THEN h.YtdBal03 + z.NetYear
				ELSE h.YtdBal03
			END,
	YtdBal04=	CASE
				WHEN (z.nbrper >= 5 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '05')) THEN h.YtdBal04 + z.NetYear
				ELSE h.YtdBal04
			END,
	YtdBal05=	CASE
				WHEN (z.nbrper >= 6 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '06')) THEN h.YtdBal05 + z.NetYear
				ELSE h.YtdBal05
			END,
	YtdBal06=	CASE
				WHEN (z.nbrper >= 7 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '07')) THEN h.YtdBal06 + z.NetYear
				ELSE h.YtdBal06
			END,
	YtdBal07=	CASE
				WHEN (z.nbrper >= 8 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '08')) THEN h.YtdBal07 + z.NetYear
				ELSE h.YtdBal07
			END,
	YtdBal08=	CASE
				WHEN (z.nbrper >= 9 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '09')) THEN h.YtdBal08 + z.NetYear
				ELSE h.YtdBal08
			END,
	YtdBal09=	CASE
				WHEN (z.nbrper >= 10 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '10')) THEN h.YtdBal09 + z.NetYear
				ELSE h.YtdBal09
			END,
	YtdBal10=	CASE
				WHEN (z.nbrper >= 11 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '11')) THEN h.YtdBal10 + z.NetYear
				ELSE h.YtdBal10
			END,
	YtdBal11=	CASE
				WHEN (z.nbrper >= 12 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '12')) THEN h.YtdBal11 + z.NetYear
				ELSE h.YtdBal11
			END,
	YtdBal12=	CASE
				WHEN (z.nbrper >= 13 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '13')) THEN h.YtdBal12 + z.NetYear
				ELSE h.YtdBal12
			END,
	BegBal=		h.BegBal + z.NetYear,

	CuryYtdBal00=	h.CuryYtdBal00 + z.CuryNetYear,

	CuryYtdBal01=	CASE
				WHEN (z.nbrper >= 2 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '02')) THEN h.CuryYtdBal01 + z.CuryNetYear
				ELSE h.CuryYtdBal01
			END,
	CuryYtdBal02=	CASE
				WHEN (z.nbrper >= 3 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '03')) THEN h.CuryYtdBal02 + z.CuryNetYear
				ELSE h.CuryYtdBal02
			END,
	CuryYtdBal03=	CASE
				WHEN (z.nbrper >= 4 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '04')) THEN h.CuryYtdBal03 + z.CuryNetYear
				ELSE h.CuryYtdBal03
			END,
	CuryYtdBal04=	CASE
				WHEN (z.nbrper >= 5 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '05')) THEN h.CuryYtdBal04 + z.CuryNetYear
				ELSE h.CuryYtdBal04
			END,
	CuryYtdBal05=	CASE
				WHEN (z.nbrper >= 6 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '06')) THEN h.CuryYtdBal05 + z.CuryNetYear
				ELSE h.CuryYtdBal05
			END,
	CuryYtdBal06=	CASE
				WHEN (z.nbrper >= 7 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '07')) THEN h.CuryYtdBal06 + z.CuryNetYear
				ELSE h.CuryYtdBal06
			END,
	CuryYtdBal07=	CASE
				WHEN (z.nbrper >= 8 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '08')) THEN h.CuryYtdBal07 + z.CuryNetYear
				ELSE h.CuryYtdBal07
			END,
	CuryYtdBal08=	CASE
				WHEN (z.nbrper >= 9 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '09')) THEN h.CuryYtdBal08 + z.CuryNetYear
				ELSE h.CuryYtdBal08
			END,
	CuryYtdBal09=	CASE
				WHEN (z.nbrper >= 10 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '10')) THEN h.CuryYtdBal09 + z.CuryNetYear
				ELSE h.CuryYtdBal09
			END,
	CuryYtdBal10=	CASE
				WHEN (z.nbrper >= 11 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '11')) THEN h.CuryYtdBal10 + z.CuryNetYear
				ELSE h.CuryYtdBal10
			END,
	CuryYtdBal11=	CASE
				WHEN (z.nbrper >= 12 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '12')) THEN h.CuryYtdBal11 + z.CuryNetYear
				ELSE h.CuryYtdBal11
			END,
	CuryYtdBal12=	CASE
				WHEN (z.nbrper >= 13 AND (h.FiscYr < LEFT(z.PerNbr,4) OR RIGHT(z.PerNbr,2) >= '13')) THEN h.CuryYtdBal12 + z.CuryNetYear
				ELSE h.CuryYtdBal12
			END,
	CuryBegBal=		h.CuryBegBal + z.CuryNetYear,

	Lupd_DateTime = GetDate(),
	LUpd_Prog = '01520',
	LUpd_User = @pUserID

FROM	CuryAcct h INNER JOIN
	(SELECT	h.CpnyID, h.Acct, h.Sub, h.LedgerID, h.FiscYr, h.CuryID,
			NbrPer = MAX(s.NbrPer), PerNbr = MAX(s.PerNbr),
			NetYear = SUM(z.NetYear),
			CuryNEtYear = SUM(z.CuryNetYear)
	FROM		vp_01520PostNetIncMC z, CuryAcct h, GLSetup s (NOLOCK)
	WHERE	UserAddress = @UserAddress
		 	AND h.Acct = s.RetEarnAcct AND z.Sub = h.Sub
 			AND z.LedgerID = h.LedgerID AND h.FiscYr <= SUBSTRING(s.PerNbr,1,4)
			AND z.CpnyID=h.CpnyID
			AND z.CuryID = h.CuryID
			AND z.FiscYr < h.FiscYr
	GROUP BY	h.CpnyID, h.Acct, h.Sub, h.LedgerID, h.FiscYr, h.CuryID) z
	ON h.CpnyID = z.CpnyID AND h.Acct = z.Acct AND h.Sub = z.Sub AND h.LedgerID = z.LedgerID AND h.FiscYr = z.FiscYr AND h.CuryID = z.CuryID
IF @@ERROR < > 0 GOTO ABORT

/***** When the process is complete, change the appropriate statuses. *****/
UPDATE GLTran SET Posted='P',
	Lupd_DateTime = GetDate(),
	LUpd_Prog = '01520',
	LUpd_User = @pUserID
FROM GLTran t (ROWLOCK), Batch b, WrkPost p
WHERE t.Module=b.Module AND t.BatNbr=b.BatNbr
  and b.BatNbr=p.BatNbr and b.Module=p.Module
  and p.UserAddress=@UserAddress

IF @@ERROR < > 0 GOTO ABORT

UPDATE Batch
   SET Status = 'P',
	Lupd_DateTime = GetDate(),
	LUpd_Prog = '01520',
	LUpd_User = @pUserID
  from batch b (ROWLOCK), wrkpost p
 WHERE b.BatNbr=p.BatNbr and b.Module=p.Module
   and p.UserAddress=@UserAddress

IF @@ERROR < > 0 GOTO ABORT

COMMIT TRANSACTION
GOTO FINISH

ABORT:
ROLLBACK TRANSACTION

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_01520] TO [MSDSL]
    AS [dbo];

