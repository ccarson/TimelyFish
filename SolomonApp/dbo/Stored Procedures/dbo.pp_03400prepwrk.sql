 CREATE PROCEDURE pp_03400prepwrk @UserAddress VARCHAR(21), @ProgID CHAR(8), @Sol_User CHAR(10), @perpost char(6), @Result INT OUTPUT AS

Declare @BaseCuryID char(4)

/***** File Name: 0370vp_03400PrepWrk.Sql					*****/

/*********************************/
/***** Remove Void Batches *******/
/*********************************/
Begin Tran
Update apd
   set LUpd_DateTime = GETDATE(),
	 LUpd_Prog = @ProgID,
	 LUpd_User = @Sol_User,
	 status = 'V'
  from apdoc apd,batch b,wrkrelease w
 where apd.batnbr =b.batnbr and b.batnbr = w.batnbr
   and b.module = 'AP' and w.module = 'AP'
   and useraddress = @useraddress
   and b.status = 'I' and b.editscrnNbr in ('03010','03020')


delete  apd
  from apdoc apd,batch b,wrkrelease w
 where apd.batnbr =b.batnbr and b.batnbr = w.batnbr and b.module = 'AP' and w.module = 'AP'
   and useraddress = @useraddress
   and b.status = 'I' and b.editscrnNbr = '03030'

Delete apt
  from APTran apt, batch b,wrkrelease w
 where apt.batnbr = b.batnbr and b.batnbr = w.batnbr and b.module = 'AP' and w.module = 'AP'
   and useraddress = @useraddress
   and b.status = 'I'

---update prtrans linked to this voucher (created in PR)
update pr
	set APBatch = '', APRefnbr = '', APLineID = 0
	from prtran pr, batch b, wrkrelease w
	where b.batnbr = w.batnbr and
		b.module = 'AP' and
		w.module = 'AP' and
		useraddress = @useraddress and
		b.jrnltype = 'PR' and
		pr.APBatch = b.batnbr and
		b.status = 'I'

Update b
   Set AutoRev=0,AutoRevCopy=0,battype='',CrTot=0,CtrlTot=0,Cycle=0,
      Descr='',DrTot=0,EditScrnNbr='',GlPostOpt='',JrnlType='',LUpd_DateTime=GETDATE(),LUpd_Prog=@ProgID,LUpd_User=@Sol_User,Module='AP',
      NbrCycle=0,PerEnt='',Rlsed=1,Status ='V',perpost = @perpost
  from batch b, wrkrelease w
 where b.batnbr= w.batnbr and b.module = 'AP' and w.module = 'AP'
   and useraddress = @useraddress
   and b.status = 'I'

Delete W
  from Wrkrelease w ,Batch b
 where Useraddress = @UserAddress and b.module = 'AP' and w.module = 'AP'
   and w.batnbr = b.batnbr and b.status = 'V'

Commit

/**  Begin checking for valid CuryID   **/

-- If Batch.CuryID does not exist in the currncy table
INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
    SELECT DISTINCT b.BatNbr, 'AP', 8058, w.UserAddress
      FROM WrkRelease w inner join Batch b
        ON w.BatNbr = b.BatNbr
      LEFT JOIN Currncy c with (NoLock)
        ON c.CuryID = b.CuryID
     WHERE w.Module = 'AP' and b.Module = 'AP'
       AND w.UserAddress = @UserAddress
       AND c.CuryID is null

	IF @@ROWCOUNT = 0
	BEGIN

		-- If APDoc.CuryID does not exist in the currncy table
		INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
			SELECT DISTINCT d.BatNbr, 'AP', 8058, w.UserAddress
			   FROM WrkRelease w inner join APDoc d
				   ON w.BatNbr = d.BatNbr
			     LEFT JOIN Currncy c with (NoLock)
				   ON c.CuryID = d.CuryID
			    WHERE w.Module = 'AP'
			     AND w.UserAddress = @UserAddress
			     AND c.CuryID is null

			IF @@ROWCOUNT = 0
			Begin
				-- If APTran.CuryID does not exist in the currncy table
				INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
					SELECT DISTINCT t.BatNbr, 'AP', 8058, w.UserAddress
					   FROM WrkRelease w inner join APTran t
					  	 ON w.BatNbr = t.BatNbr
					   LEFT JOIN Currncy c with (NoLock)
					     ON c.CuryID = t.CuryID
					  WHERE w.Module = 'AP'
					    AND w.UserAddress = @UserAddress
					    AND c.CuryID is null
			End
	END

-- Update records with bad curyid then remove the batch from wrkReleaseBad
-- For single currency databases only
if ((Select Count(*) from wrkReleaseBad where MsgID = 8058 and UserAddress = @UserAddress and Module = 'AP') > 0)
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
                   and wb.Module = 'AP' and b.Module = 'AP'
                   and wb.UserAddress = @UserAddress
                   and c.CuryID is null

				Update d
				   set d.CuryID = @BaseCuryID,
					   d.RGOLAmt = 0,
                       d.CuryMultDiv = 'M',
                       d.CuryRate = 1
				  from APDoc d
                 inner join wrkReleaseBad b
                    on d.Batnbr = b.Batnbr
                  left join Currncy c with (NoLock)
                    on c.CuryID = d.CuryID
				 where b.MsgID = 8058
                   and b.Module = 'AP'
                   and b.UserAddress = @UserAddress
                   and c.CuryID is null

                Update t
				   set t.CuryID = @BaseCuryID,
                       t.CuryMultDiv = 'M',
                       t.CuryRate = 1
                  from APTran t
				 inner join wrkReleaseBad b
                    on t.Batnbr = b.Batnbr
                  left join Currncy c with (NoLock)
                    on c.CuryID = t.CuryID
				 where b.MsgID = 8058
                   and b.Module = 'AP'
                   and b.UserAddress = @UserAddress
                   and c.CuryID is null

			    Delete wrkReleaseBad
                 where MsgID = 8058
                   and Module = 'AP'
                   and UserAddress = @UserAddress
           End
    End

/**  End checking for valid CuryID  **/

/*****************************/
/***** Remove Exceptions *****/
/*****************************/
/* First remove records already processed and remove from wrkrelease */
/* so that they don't get caught in the balancing exception checks  */
INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
SELECT b.batnbr, 'AP', 12008, w.UserAddress
  FROM WrkRelease w JOIN BATCH b
                      ON w.batnbr = b.batnbr
                     And W.module = b.module
 WHERE w.module = 'AP' AND w.useraddress = @UserAddress
   AND B.Rlsed = 1

IF @@ERROR < > 0 GOTO ABORT

/***** Remove Already processed Records from WrkRelease *****/

DELETE W
  FROM WrkRelease w, WrkReleaseBad v
 WHERE w.Module = v.Module AND w.BatNbr = v.BatNbr AND
	v.UserAddress = @UserAddress AND w.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

/***** Batch Out of Balance ******/

INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
SELECT BatNbr, Module, Situation, UserAddress
  FROM vp_03400Exception1
 WHERE UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

/***** No vender, No sales tax ID *****/

INSERT WrkReleaseBad (BatNbr, Module, MsgID, UserAddress)
SELECT BatNbr, Module, Situation, UserAddress
  FROM vp_03400Exception2
 WHERE UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

INSERT INTO WRKRELEASEBAD (BatNbr, Module, MsgID , UserAddress)
SELECT DISTINCT  d.BatNbr, w.Module,  Situation = 6019, w.UserAddress
  FROM  WrkRelease w inner loop join APDoc d on w.batnbr = d.BatNbr
 WHERE w.Module = 'AP' AND w.UserAddress = @UserAddress
   AND d.DocType IN ('VO', 'AD', 'AC')
   AND (ROUND(Convert(dec(28,3),d.CuryOrigDocAmt)
            - Convert(dec(28,3),d.CuryTaxTot00)
            - Convert(dec(28,3),d.CuryTaxTot01)
            - Convert(dec(28,3),d.CuryTaxTot02)
            - Convert(dec(28,3),d.CuryTaxTot03), 3)
                       <>
            (SELECT ROUND(SUM(Convert(dec(28,3),t.CuryTranAmt)) ,3)
               FROM ApTran t
              WHERE w.batnbr = t.batnbr
                AND d.refnbr = t.refnbr
            )
	    -  ---less taxes from price inclusive tax
            isnull ((SELECT round( SUM(Convert(dec(28,3),tTrantot)) ,3)
                 FROM vp_ExceptionAPPrcTaxIncl  v
               WHERE d.RefNbr = v.tRefNbr
                 AND w.BatNbr = v.tBatNbr --REH changed d. to w.batnbr
		     AND v.useraddress = @UserAddress ),0)
	 )

IF @@ERROR < > 0 GOTO ABORT
IF @@ERROR < > 0 GOTO ABORT
/***** Remove Exception Records in WrkRelease *****/

DELETE W
  FROM WrkRelease w, WrkReleaseBad v
 WHERE w.Module = v.Module AND w.BatNbr = v.BatNbr AND
	v.UserAddress = @UserAddress AND w.UserAddress = @UserAddress
IF @@ERROR < > 0 GOTO ABORT

/***** Change Batch Status to 'S' in Batch *****/

UPDATE B
   SET LUpd_DateTime = GETDATE(),
	 LUpd_Prog = @ProgID,
	 LUpd_User = @Sol_User,
	 Status = 'S'
  FROM Batch b, WrkReleaseBad w
 WHERE w.UserAddress = @UserAddress AND w.BatNbr = b.BatNbr
       AND w.Module = 'AP' AND b.Module = 'AP'
	 AND b.Rlsed = 0

IF @@ERROR < > 0 GOTO ABORT

UPDATE B
   SET b.status  = 'U'
  FROM WrkReleaseBad wb JOIN batch b
                         ON wb.module = b.module
                        AND wb.batnbr = b.batnbr
 WHERE wb.useraddress = @useraddress and Wb.module  = 'AP' and wb.msgid = 12008
   AND (SELECT COUNT(*)
          FROM GLTRAN t
         WHERE b.module = t.module AND b.batnbr = t.batnbr AND t.Posted = 'U') > 0

IF @@ERROR < > 0 GOTO ABORT
UPDATE B
   SET b.status  = 'P'
  FROM WrkReleaseBad wb JOIN Batch b
                         ON wb.module = b.module
                        AND wb.batnbr = b.batnbr
 WHERE wb.useraddress = @useraddress
   AND Wb.module  = 'AP' AND wb.msgid = 12008
   AND (SELECT COUNT(*)
          FROM GLTRAN t
         WHERE b.module = t.module AND b.batnbr = t.batnbr AND t.posted = 'P') > 0

IF @@ERROR < > 0 GOTO ABORT

SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_03400prepwrk] TO [MSDSL]
    AS [dbo];

