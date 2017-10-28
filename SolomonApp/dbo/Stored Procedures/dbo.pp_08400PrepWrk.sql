 CREATE PROCEDURE pp_08400PrepWrk @UserAddress VARCHAR(21),
                                 @Prep_Result INT OUTPUT
AS
/********************************************************************************
*    Proc Name: pp_08400PrepWrk
**++* Narrative: Runs preprocessing steps to find batches with errors and then eliminates them
*++*            from this release.  Also handles the incomplete voids. Sets all batches that pass
*++*            these checks to status 'S'
**    Inputs   : UserAddress  VARCHAR(21)   Workstation id of caller
**    Outputs  : Prep_Result INT   1= good, 0 = bad
**   Called by: pp_08400
*
*/

DECLARE @Debug INT
DECLARE	@MinNbr CHAR(10)
DECLARE	@i	SMALLINT
Declare @BaseCuryID char(4)

SELECT @Debug = CASE WHEN @UserAddress = 'ARDebug' THEN 1
                     ELSE 0
                END

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 300-100:  Clear records for voided batches'
  END

/***** Remove Exceptions *****/
BEGIN TRAN

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 300-200:  Clearing voided PA docs'
    SELECT ard.*
      FROM wrkrelease w INNER JOIN batch b
                                ON b.batnbr = w.batnbr
                        INNER JOIN ardoc ard
                                ON ard.Applbatnbr = b.batnbr
     WHERE b.Module='AR' AND w.Module='AR'
       AND useraddress =@useraddress
       AND b.status ='I'
       AND b.editscrnnbr ='08030'
  END

UPDATE Ardoc
   SET Applbatnbr ='',ApplAmt=0,CuryApplamt=0
 WHERE EXISTS
       (select * FROM wrkrelease w, batch b
        WHERE b.batnbr = w.batnbr
          AND ardoc.Applbatnbr = b.batnbr
          AND b.Module='AR'
          AND w.Module='AR'
          AND useraddress =@useraddress
          AND b.status ='I'
          AND b.editscrnnbr ='08030')

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 300-300:  Clearing voided trans docs'
    SELECT art.*
      FROM wrkrelease w INNER JOIN batch b
                           ON b.batnbr = w.batnbr
                        INNER JOIN artran art
                           ON art.batnbr = b.batnbr
     WHERE b.Module ='AR'
       AND W.Module ='AR'
       AND useraddress= @useraddress
       AND b.status ='I'
  END

/* Clearing voided trans */
DELETE Artran
  FROM wrkrelease w INNER JOIN batch b
                       ON b.batnbr = w.batnbr
                    INNER JOIN artran art
                       ON art.batnbr = b.batnbr
 WHERE b.Module ='AR'
   AND W.Module ='AR'
   AND useraddress= @useraddress
   AND b.status ='I'

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 300-400:  Clearing voided IN docs'
    SELECT ard.*
      FROM wrkrelease w INNER JOIN batch b
                           ON  b.batnbr = w.batnbr
                        INNER JOIN ardoc ard
                           ON ard.batnbr = b.batnbr
	WHERE b.module='AR'
          AND w.module ='AR'
	  AND useraddress =@useraddress
          AND ard.docclass <>'N'
          AND b.status ='I'

  END
SELECT	@MinNbr=MIN(ard.RefNbr),@i=LEN(RTRIM(MIN(ard.RefNbr)))
	from ardoc ard,batch b, wrkrelease w
	where ard.batnbr = b.batnbr AND b.batnbr = w.batnbr AND b.module='AR' AND w.module ='AR'
	AND useraddress =@useraddress AND b.status ='I' AND ard.doctype IN ('IN','DM','CM')

DELETE ardoc
  FROM wrkrelease w INNER JOIN batch b
                       ON  b.batnbr = w.batnbr
                    INNER JOIN ardoc ard
                       ON ard.batnbr = b.batnbr
 WHERE b.module='AR'
   AND w.module ='AR'
   AND useraddress =@useraddress
   AND b.status ='I'

IF EXISTS(SELECT * FROM ARSetup (NOLOCK) WHERE SetupID='AR' AND AutoRef=1)  AND @MinNbr IS NOT NULL AND @MinNbr<>'' BEGIN

WHILE	@i>0 AND SUBSTRING(@MinNbr,@i,1)='0'
	SELECT	@MinNbr=SUBSTRING(@MinNbr,1,@i-1)+'9'+SUBSTRING(@MinNbr,@i+1,10), @i=@i-1

IF @i>0 AND SUBSTRING(@MinNbr,@i,1) IN('1','2','3','4','5','6','7','8','9')
	SELECT	@MinNbr=SUBSTRING(@MinNbr,1,@i-1)+CHAR(ASCII(SUBSTRING(@MinNbr,@i,1))-1)+SUBSTRING(@MinNbr,@i+1,10)

UPDATE	ARSetup SET LastRefNbr=@MinNbr WHERE SetupID='AR'

END
IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 300-500:  Voiding batches'
    SELECT b.*
      FROM WrkRelease w INNER JOIN batch b
                           ON b.batnbr = W.batnbr
     WHERE useraddress = @useraddress
      AND b.Module ='AR'
      AND W.Module = 'AR'
      AND b.status ='I'
  END

UPDATE d
   SET d.doctype = 'VT', d.rlsed = '1'
  FROM ardoc d, batch b, wrkrelease w
 WHERE b.module = 'AR' and w.module = 'AR' and useraddress = @useraddress and b.status = 'I'
       and b.editscrnnbr = '08010' and d.batnbr = b.batnbr and b.batnbr = w.batnbr

UPDATE b
   SET b.status = 'V', b.Rlsed =1, b.Autorev = 0
  FROM WrkRelease w INNER JOIN batch b
                       ON b.batnbr = W.batnbr
 WHERE useraddress = @useraddress
   AND b.Module ='AR'
   AND W.Module = 'AR'
   AND b.status ='I'

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 300-600:  Clearing wrkrelease for voided batches'
    SELECT w.*
      FROM WrkRelease w INNER JOIN batch b
                              ON b.batnbr = W.batnbr
     WHERE useraddress = @useraddress
      AND b.Module ='AR'
      AND W.Module = 'AR'
      AND b.status ='V'
  END

DELETE W
  FROM Wrkrelease w  INNER JOIN Batch b
                             ON b.batnbr = W.batnbr
 WHERE Useraddress = @UserAddress
   AND b.module = 'AR'
   AND w.module = 'AR'
   AND b.status = 'V'
 Commit

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 300-700:  Remove batches that are/will be out of balance.'
    PRINT 'Debug...Show which SELECT will remove batch.'
    SELECT v.*, 'vp_08400Exception1'
      FROM vp_08400Exception1 v
     WHERE UserAddress = @UserAddress
    SELECT ' '
    SELECT v.*, 'vp_08400Exception2'
      FROM vp_08400Exception2 v
     WHERE UserAddress = @UserAddress
    SELECT ' '
    SELECT v.*, 'vp_08400Exception3'
      FROM vp_08400Exception3 v
     WHERE UserAddress = @UserAddress
    SELECT ' '
    SELECT v.*, 'vp_08400Exception4'
      FROM vp_08400Exception4 v
      WHERE UserAddress = @UserAddress
    SELECT ' '
    SELECT v.*, 'vp_08400Exception5'
      FROM vp_08400Exception5 v
     WHERE UserAddress = @UserAddress
    SELECT ' '
    SELECT 'Missing installments for Multi Install Docs.',
           d.batnbr,d.refnbr,d.doctype, Module = 'AR',MsgId = 12014,w.useraddress
      FROM WrkRelease w INNER JOIN ardoc d
                              ON w.Batnbr = d.batnbr
                        INNER JOIN terms t
                              ON d.terms = t.termsid
                        Left Outer JOIN docterms c
                              ON d.doctype = c.doctype
                             AND d.refnbr = c.refnbr
    WHERE w.module = 'AR'
          AND w.Useraddress = @useraddress
          AND t.termstype = 'M'
          AND c.doctype IS NULL
    GROUP BY d.batnbr, d.custid, d.doctype, d.refnbr, w.useraddress
    SELECT ' '

    PRINT 'CuryTranAmt <> TranAmt with no rate change.'
    SELECT d.BatNbr,  d.CustID, d.DocType, d.RefNbr,  Module = 'AR', MsgId = 12124,
		w.useraddress, t.TranAmt, t.CuryTranAmt
      FROM  GLSetup g (NOLOCK), WrkRelease w INNER JOIN Ardoc d
                              		ON w.Batnbr = d.BatNbr
                        	      INNER JOIN ARTran t
                              		ON d.BatNbr = t.BatNbr and
				 			d.RefNbr = t.RefNbr and
				 			d.CustID = t.CustID and
				 			d.DocType = t.TranType
    WHERE  w.Module = 'AR'
	     AND w.useraddress = @useraddress
	     AND g.BaseCuryId = d.CuryID
	     AND round(t.curytranamt,2) <> round(t.tranamt,2)

    SELECT ' '
    SELECT v.batnbr, 'AR', v.UserAddress, 'vp_08400ChkSumARDocs'
      from wrkrelease w, vp_08400ChkSumARDocs v, batch b, currncy c (nolock)
      where w.batnbr = v.batnbr and w.module = 'AR'
        and v.useraddress = @useraddress and w.useraddress = @useraddress
        and b.batnbr = v.batnbr and b.module = 'AR'
        and (round(CONVERT(DEC(28,3),b.CuryCrTot), c.decpl) <> round(v.CuryCtrlTot, c.decpl))
    SELECT ' '
    SELECT *
      FROM vp_08400ChkSumARDocs v
     WHERE v.useraddress = @useraddress
    Select ' '
    SELECT  'Batches that are already released', w.Batnbr,b.Rlsed,b.Status,
            gltran_count = (select count(*) from gltran g where g.batnbr = w.batnbr and module  = 'AR'),
            b.*
      FROM WrkRelease w JOIN BATCH b
                          ON w.batnbr = b.batnbr
                         And W.module = b.module
     WHERE w.module = 'ar' and w.useraddress = @UserAddress
       AND B.Rlsed = 1
    Select ' '
    SELECT  msg ='Payment currency does not match the denominated account currency of the document', w.Batnbr,
            InvAcctCury = a.CuryID,PaymentCury = d.CuryID
      FROM WrkRelease w INNER JOIN ARTran t
                           ON w.Batnbr = t.Batnbr
                        INNER JOIN ARDoc d
                           ON t.Custid = d.Custid AND t.Refnbr = d.Refnbr
                                 AND t.Trantype = d.Doctype
                        INNER JOIN Account a (nolock)
                          ON a.Acct = t.Acct
     WHERE w.module = 'AR' AND w.useraddress = @UserAddress
       AND t.DRCR = 'U' AND a.CuryID <> ' ' AND d.CuryID <> a.CuryID

END  /*** ARDebug ***/

/* Remove batches that are already released so they don't go through other balancing checks */
INSERT WrkReleaseBad
SELECT b.batnbr, 'AR', 12008, w.UserAddress, Null
  FROM WrkRelease w JOIN BATCH b
                      ON w.batnbr = b.batnbr
                     And W.module = b.module
 WHERE w.module = 'ar' AND w.useraddress = @UserAddress
   AND B.Rlsed = 1

DELETE WrkRelease
  FROM WrkRelease w INNER JOIN WrkReleaseBad wb
                       ON w.Module = wb.Module
                           AND w.BatNbr = wb.BatNbr
 WHERE wb.UserAddress = @UserAddress
   AND w.UserAddress = @UserAddress
IF @@ERROR < > 0 GOTO ABORT

/* Do balancing checks */
-- Error 12125. ARTrans are missing or ARtrans have blank refnbr.
-- Error 12126. Invoice and Debit Memo transactions have no documents.
INSERT WrkReleaseBad
SELECT BatNbr, Module, Situation, UserAddress, Null
  FROM vp_08400Exception1
 WHERE UserAddress = @UserAddress
IF @@ERROR < > 0 GOTO ABORT

-- Error 12347. ARDocs have invalid Customer id.
-- Error 12348. ARDocs have invalid Tax ID.
INSERT WrkReleaseBad
SELECT BatNbr, Module, MsgID, UserAddress, Null
  FROM vp_08400Exception2
 WHERE UserAddress = @UserAddress
IF @@ERROR < > 0 GOTO ABORT

-- Error 6624. Sales Tax ID is used as an individual tax and group tax in the same document.
INSERT WrkReleaseBad
SELECT BatNbr, Module, MsgID, UserAddress, Null
  FROM vp_08400Exception3
 WHERE UserAddress = @UserAddress
IF @@ERROR < > 0 GOTO ABORT

-- Error 6928. ARTrans have invalid Account.
-- Error 6929. Artrans have invalid Sub. Account.
INSERT WrkReleaseBad
SELECT Batnbr, Module, MsgID, UserAddress, Null
  FROM vp_08400Exception4
 WHERE UserAddress = @UserAddress
IF @@ERROR < > 0 GOTO ABORT

-- Error 6928. ARDocs have invalid Account.
INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
SELECT Distinct w.Batnbr, 'AR', 6928, w.UserAddress
  FROM WrkRelease w INNER JOIN ardoc d
                          ON w.Batnbr = d.batnbr
 WHERE w.module = 'ar' AND UserAddress = @UserAddress
 	AND d.BankAcct = ''
IF @@ERROR < > 0 GOTO ABORT

-- Error 6929. ARDocs have invalid SubAccount.
INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
SELECT Distinct w.Batnbr, 'AR', 6929, w.UserAddress
  FROM WrkRelease w INNER JOIN ardoc d
                          ON w.Batnbr = d.batnbr
 WHERE w.module = 'ar' AND UserAddress = @UserAddress
 	AND d.BankSub = ''
IF @@ERROR < > 0 GOTO ABORT

-- Error 6958. Sales Tax has invalid TaxType.
INSERT WrkReleaseBad
SELECT Batnbr, Module, MsgID, UserAddress, Null
  FROM vp_08400Exception5
 WHERE UserAddress = @UserAddress
IF @@ERROR < > 0 GOTO ABORT

-- Multiple installment document is missing it's installments.
INSERT Wrkreleasebad (BatNbr, Module, MsgID, UserAddress)
SELECT Distinct(d.batnbr),'AR',12014,w.useraddress --Had to add distinct because of multiple records in docterms.
  FROM WrkRelease w INNER JOIN ardoc d
                          ON w.Batnbr = d.batnbr
                    INNER JOIN terms t
                          ON d.terms = t.termsid
                    Left Outer JOIN docterms c
                          ON d.doctype = c.doctype
                         AND d.refnbr = c.refnbr
 WHERE w.module = 'AR'
       AND w.Useraddress = @useraddress
       AND t.termstype = 'M'
       AND c.doctype IS NULL
 GROUP BY d.batnbr, d.custid, d.doctype, d.refnbr, w.useraddress
IF @@ERROR < > 0 GOTO ABORT

-- Curytranamt not equal to tranamt for base currency documents.
INSERT Wrkreleasebad (BatNbr, Module, MsgID, UserAddress)
SELECT DISTINCT(t.BatNbr),'AR',12124,w.useraddress
      FROM  GLSetup g (NOLOCK), WrkRelease w INNER JOIN Ardoc d
                	              	ON w.Batnbr = d.BatNbr
                        	    INNER JOIN ARTran t
                              		ON d.BatNbr = t.BatNbr and
					d.RefNbr = t.RefNbr and
				 	d.CustID = t.CustID and
				 	d.DocType = t.TranType
     WHERE  w.Module = 'AR'
	    AND w.useraddress = @useraddress
	    AND g.BaseCuryId = d.CuryID
	    AND round(t.CuryTranAmt,2) <> round(t.TranAmt,2)
 GROUP BY t.BatNbr, d.CustID, d.DocType, d.RefNbr, w.useraddress

IF @@ERROR < > 0 GOTO ABORT

/**
Begin checking for valid CuryID in single currency database

     If this is a single currency database, there should be no records
     in the Currncy table and the CuryID in the Batch, ARDoc and ARTran
     tables should match the value held in GLSetup.
**/

-- If Batch.CuryID does not exist in the currncy table
INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
    SELECT DISTINCT b.BatNbr, 'AR', 8058, w.UserAddress
      FROM WrkRelease w inner join Batch b
        ON w.BatNbr = b.BatNbr
      LEFT JOIN Currncy c with (NoLock)
        ON c.CuryID = b.CuryID
     WHERE w.Module = 'AR' and b.Module = 'AR'
       AND w.UserAddress = @UserAddress
       AND c.CuryID is null

	IF @@ROWCOUNT = 0
	BEGIN

		-- If ARDoc.CuryID does not exist in the currncy table
		INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
			SELECT DISTINCT d.BatNbr, 'AR', 8058, w.UserAddress
			FROM WrkRelease w inner join ARDoc d
				ON w.BatNbr = d.BatNbr
			LEFT JOIN Currncy c with (NoLock)
				ON c.CuryID = d.CuryID
			WHERE w.Module = 'AR'
			AND w.UserAddress = @UserAddress
			AND c.CuryID is null

			IF @@ROWCOUNT = 0
			Begin
				-- If ARTran.CuryID does not exist in the currncy table
				INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
					SELECT DISTINCT t.BatNbr, 'AR', 8058, w.UserAddress
					FROM WrkRelease w inner join ARTran t
						ON w.BatNbr = t.BatNbr
					LEFT JOIN Currncy c with (NoLock)
						ON c.CuryID = t.CuryID
					WHERE w.Module = 'AR'
					AND w.UserAddress = @UserAddress
					AND c.CuryID is null
			End
	END

-- Update records with bad curyid then remove the batch from wrkReleaseBad
-- For single currency databases only
if ((Select Count(*) from wrkReleaseBad where MsgID = 8058 and UserAddress = @UserAddress and Module = 'AR') > 0)
    Begin
       If (Select Count(*) from CMSetup) = 0
           Begin
			    Select @BaseCuryID = BaseCuryID from GLSetup with (NoLock)

				Update b
				   set b.CuryID = @BaseCuryID,
					   b.BaseCuryID = @BaseCuryID,
                       b.CuryMultDiv = 'M',
                       b.CuryRate = 1
				  from Batch b
                 inner join wrkReleaseBad wb with (NoLock)
                    on b.Batnbr = wb.Batnbr
                  left join Currncy c with (NoLock)
                    on c.CuryID = b.CuryID
				 where wb.MsgID = 8058
                   and wb.Module = 'AR' and b.Module = 'AR'
                   and wb.UserAddress = @UserAddress
                   and c.CuryID is null

				Update d
				   set d.CuryID = @BaseCuryID,
					   d.RGOLAmt = 0,
                       d.CuryMultDiv = 'M',
                       d.CuryRate = 1
				  from ARDoc d
                 inner join wrkReleaseBad b
                    on d.Batnbr = b.Batnbr
                  left join Currncy c with (NoLock)
                    on c.CuryID = d.CuryID
				 where b.MsgID = 8058
                   and b.Module = 'AR'
                   and b.UserAddress = @UserAddress
                   and c.CuryID is null

                Update t
				   set t.CuryID = @BaseCuryID,
                       t.CuryMultDiv = 'M',
                       t.CuryRate = 1
                  from ARTran t
				 inner join wrkReleaseBad b
                    on t.Batnbr = b.Batnbr
                  left join Currncy c with (NoLock)
                    on c.CuryID = t.CuryID
				 where b.MsgID = 8058
                   and b.Module = 'AR'
                   and b.UserAddress = @UserAddress
                   and c.CuryID is null

			    Delete wrkReleaseBad
                 where MsgID = 8058
                   and Module = 'AR'
                   and UserAddress = @UserAddress
           End
    End

/**
   End checking for valid CuryID in single currency database
**/

IF @@ERROR < > 0 GOTO ABORT

-- Batch totals do not equal the sum of the documents.
INSERT WrkReleaseBad
SELECT v.batnbr, 'AR', 12123, v.UserAddress, Null
  from wrkrelease w, vp_08400ChkSumARDocs v, batch b, currncy c (nolock)
 where w.batnbr = v.batnbr and w.module = 'AR'
   and v.useraddress = @useraddress and w.useraddress = @useraddress
   and b.batnbr = v.batnbr and b.module = 'AR'
   and b.curyid = c.curyid
   and (round(CONVERT(DEC(28,3),b.CuryCrTot), c.decpl) <> round(v.CuryCtrlTot, c.decpl))

IF @@ERROR < > 0 GOTO ABORT

-- Payment currency does not match the denominated account currency of the document.
INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
SELECT DISTINCT w.batnbr, 'AR', 12427, w.UserAddress
  FROM WrkRelease w INNER JOIN ARTran t
                       ON w.Batnbr = t.Batnbr
                    INNER JOIN ARDoc d
                       ON t.Custid = d.Custid AND t.Refnbr = d.Refnbr
                                 AND t.Trantype = d.Doctype
                    INNER JOIN Account a (nolock)
                       ON a.Acct = t.Acct
     WHERE w.module = 'AR' AND w.useraddress = @UserAddress
       AND t.DRCR = 'U' AND a.CuryID <> ' ' AND d.CuryID <> a.CuryID
IF @@ERROR < > 0 GOTO ABORT

-- Payment batch should be released after the corresponding invoice(s) is released.
INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
SELECT DISTINCT(w.BatNbr), 'AR', 12306, w.UserAddress
  FROM WrkRelease w JOIN ARTran t ON w.batnbr = t.batnbr
                    JOIN ARDoc d  ON t.custid = d.custid AND t.SiteID = d.Refnbr
                                 AND t.Costtype = d.doctype
WHERE w.module = 'AR' AND w.useraddress = @UserAddress AND t.drcr = 'U' AND d.rlsed = 0
IF @@ERROR < > 0 GOTO ABORT

-- RA batch should be released after the corresponding AD is released (from Order Management)
INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
SELECT DISTINCT(w.BatNbr), 'AR', 12426, w.UserAddress
  FROM WrkRelease w JOIN ARDoc d ON w.batnbr = d.batnbr AND d.DocType = 'RA'
                    JOIN ARDoc d1  ON d.custid = d1.custid AND d.RefNbr = d1.RefNbr AND d1.DocType = 'AD'
WHERE w.module = 'AR' AND w.useraddress = @UserAddress AND d1.rlsed = 0
IF @@ERROR < > 0 GOTO ABORT

-- Batch is already released
INSERT WrkReleaseBad
SELECT b.batnbr, 'AR', 12008, w.UserAddress, Null
  FROM WrkRelease w JOIN BATCH b
                      ON w.batnbr = b.batnbr
                     And W.module = b.module
 WHERE w.module = 'ar' AND w.useraddress = @UserAddress
   AND B.Rlsed = 1
IF @@ERROR < > 0 GOTO ABORT

IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 300-800:  Remove FROM wrkrelease all wrkreleasebad batches.'
    SELECT w.*
      FROM WrkRelease w INNER JOIN WrkReleaseBad wb
                           ON w.Module = wb.Module
                                 AND w.BatNbr = wb.BatNbr
     WHERE wb.UserAddress = @UserAddress
       AND w.UserAddress = @UserAddress
  END

-- Remove Records from WrkRelease.
DELETE WrkRelease
  FROM WrkRelease w INNER JOIN WrkReleaseBad wb
                       ON w.Module = wb.Module
                           AND w.BatNbr = wb.BatNbr
 WHERE wb.UserAddress = @UserAddress
   AND w.UserAddress = @UserAddress
IF @@ERROR < > 0 GOTO ABORT

UPDATE Batch SET Status = 'S'
  FROM Batch b INNER JOIN WrkReleaseBad w
                  ON w.BatNbr = b.BatNbr
 WHERE w.UserAddress = @UserAddress
   AND w.Module = 'AR'
   AND b.Module = 'AR'
IF @@ERROR < > 0 GOTO ABORT

/*** update batches that were already released and sent back through
     If gltran's exist, reset status to 'U' or 'P'.
     If there are 08030 batches with no GL Trans, set it to 'C';
     Otherwise leave status alone
***/
UPDATE B
   SET b.status  = 'U'
  FROM WrkReleaseBad wb JOIN batch b
                         ON wb.module = b.module
                        AND wb.batnbr = b.batnbr
 WHERE wb.useraddress = @useraddress and Wb.module  = 'AR' and wb.msgid = 12008
   AND (SELECT COUNT(*)
          FROM GLTRAN t
         WHERE b.module = t.module and b.batnbr = t.batnbr and t.posted = 'U') > 0
IF @@ERROR < > 0 GOTO ABORT

UPDATE B
   SET b.status  = 'P'
  FROM WrkReleaseBad wb JOIN batch b
                         ON wb.module = b.module
                        AND wb.batnbr = b.batnbr
 WHERE wb.useraddress = @useraddress and Wb.module  = 'AR' and wb.msgid = 12008
   AND (SELECT COUNT(*)
          FROM GLTRAN t
         WHERE b.module = t.module and b.batnbr = t.batnbr and t.posted = 'P') > 0
IF @@ERROR < > 0 GOTO ABORT

-- Since Payment Application Batch May Have NO GL Trans, reset the PA batch status to 'Closed'.
UPDATE B
   SET b.status  = 'C'
  FROM WrkReleaseBad wb JOIN batch b
                         ON wb.module = b.module
                        AND wb.batnbr = b.batnbr
 WHERE wb.useraddress = @useraddress and Wb.module  = 'AR' and wb.msgid = 12008
       AND B.EditScrnNbr = '08030'
   AND (SELECT COUNT(*)
          FROM GLTRAN t
         WHERE b.module = t.module and b.batnbr = t.batnbr ) = 0
IF @@ERROR < > 0 GOTO ABORT

SELECT @Prep_Result = 1
GOTO FINISH

ABORT:
SELECT @Prep_Result = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400PrepWrk] TO [MSDSL]
    AS [dbo];

