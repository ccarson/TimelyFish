 --USETHISSYNTAX

CREATE PROCEDURE pp_SalesTaxAPRelease @UserAddress VARCHAR(21), @ProgID CHAR(8), @Sol_User CHAR(10), @BaseDecpl int,@Result INT OUTPUT AS

/***** This procedure produces the necessary Sales Tax Entries for the AP Release process. 	*****/

SET NOCOUNT ON

/***** Clear Work Tables *****/

DELETE Wrk_SalesTax WHERE UserAddress = @UserAddress

/***** Update APTran records that have price inclusive tax. *****/
UPDATE APTran SET TranAmt = v.NewTranAmt, CuryTranAmt = v.NewCuryTranAmt, LUpd_DateTime = GETDATE(),
			LUpd_Prog = @ProgID, LUpd_User = @Sol_User
FROM  vp_SalesTaxAPPrcTaxIncl v INNER JOIN APTran t
ON t.RecordID = v.tRecordID AND v.UserAddress = @UserAddress
IF @@ERROR <> 0 GOTO ABORT

/***** Create tax entries for document based taxes. Re-calc group taxes.*****/
INSERT Wrk_SalesTax
SELECT v.CpnyID, convert(int,ascii(v.reftype)), v.RefNbr, v.DocType, v.TaxId, v.TaxRate,'D',v.TaxAcct, v.TaxSub, v.TaxDate,
	     	CuryTaxTot =
			case when v.reftype = 'G' THEN
                        	ROUND(SUM(CONVERT(DEC(28,3),v.CuryTxblAmt) * CONVERT(DEC(25,9),(v.TaxRate/100))),v.DecPl)
			ELSE
				sum(v.curytaxamt)
			END,

		CuryTxblTot =
			ROUND(SUM(CONVERT(DEC(28,3),v.CuryTxblAmt)),v.DecPl),

		TaxTot = ROUND(CASE v.dCuryMultDiv
                	 WHEN 'M' THEN
				case when v.reftype = 'G' THEN
				ROUND((SUM(CONVERT(DEC(28,3),v.CuryTxblAmt)) )
				    * CONVERT(DEC(25,9),v.TaxRate)/100 ,v.DecPl)
			      		* (CONVERT(DEC(25,9), v.dCuryRate))

				else
					sum(v.taxamt)
				END


                	 WHEN 'D' THEN
 				Case when v.reftype = 'G' THEN
				ROUND((ROUND(SUM(CONVERT(DEC(28,3),v.CuryTxblAmt)),v.DecPl) )
					* CONVERT(DEC(25,9),v.TaxRate)/100,v.DecPl)
					/ CONVERT(DEC(25,9),v.dCuryRate)

				ELSE
					sum(v.taxamt)
				END

                	 ELSE 0
        		END,
			@BaseDecPl),
        TxblTot = ROUND(CASE v.dCuryMultDiv
                WHEN 'M' THEN
				ROUND(SUM(CONVERT(DEC(28,3),v.CuryTxblAmt)),v.DecPl)
				* CONVERT(DEC(25,9),v.dCuryRate)
                WHEN 'D' THEN
				ROUND(SUM(CONVERT(DEC(28,3),v.CuryTxblAmt)),v.DecPl)
				 / CONVERT(DEC(25,9),v.dCuryRate)

                ELSE 0
        END, @BaseDecPl),
       GrpTaxID = v.GrpTaxID,
       GrpRate = 0,
       GrpTaxTot = ROUND(SUM(v.taxamt),@BaseDecPl),
       GrpCuryTaxTot = ROUND(SUM(v.curytaxamt),v.DecPl),
       v.VendID,
       v.DecPl,
	@UserAddress, '', ''

FROM vp_SalesTaxAPDocRls v
WHERE  v.TaxCalcType = 'D'
  AND v.UserAddress = @UserAddress

GROUP BY v.CpnyID,v.DocType, v.RefNbr, v.TaxId,  v.TaxDate, v.TaxCalcLvl, v.TaxCalcType, v.DecPl, v.TaxRate,
        v.taxamt, v.curytaxamt, v.dCuryRate, v.dCuryMultDiv, v.TaxAcct, v.TaxSub, v.VendID, v.RefType, v.GrpTaxID
IF @@ERROR <> 0 GOTO ABORT

/***** Create tax entries for item based taxes. Re-calc group taxes*****/
INSERT Wrk_SalesTax
SELECT v.CpnyID, convert(int,ascii(v.reftype))+v.tRecordID, v.RefNbr, v.DocType, v.TaxId, v.TaxRate,'T', v.TaxAcct, v.TaxSub, v.TaxDate,
        CuryTaxTot =
		CASE when v.reftype = 'G'THEN
			ROUND(SUM(CONVERT(DEC(28,3),v.CuryTxblAmt) *
			              (CONVERT(DEC(25,9),v.TaxRate)/100))
					,v.DecPl)
			ELSE
				sum(v.curytaxamt)
			END,

        CuryTxblTot = SUM(ROUND(CONVERT(DEC(28,3),v.CuryTxblAmt), v.DecPl)),
        TaxTot = ROUND(CASE v.dCuryMultDiv
                WHEN 'M' THEN (	CASE WHEN  v.reftype = 'G' THEN
					SUM(ROUND((
						(CONVERT(DEC(28,3),v.CuryTxblAmt)
						*CONVERT(DEC(25,9),v.TaxRate)))/100, v.DecPl))
						  * CONVERT(DEC(25,9),v.dCuryRate)
				ELSE
					sum(v.taxamt)
				END)
                WHEN 'D' THEN (CASE When  v.reftype = 'G' THEN
					SUM(ROUND((
						(CONVERT(DEC(28,3),v.CuryTxblAmt)
						* CONVERT(DEC(25,9),v.TaxRate)))/100, v.DecPl))
						/ CONVERT(DEC(25,9),v.dCuryRate)
				ELSE
					sum(v.taxamt)
				END)
    ELSE 0
        END, @BaseDecPl),

	TxblTot = ROUND(CASE v.dCuryMultDiv
                WHEN 'M' THEN  SUM(ROUND(CONVERT(DEC(28,3),v.CuryTxblAmt), v.DecPl))
                         * CONVERT(DEC(25,9),v.dCuryRate)
                WHEN 'D' THEN SUM(ROUND(CONVERT(DEC(28,3),v.CuryTxblAmt), v.DecPl))
				 / CONVERT(DEC(25,9), v.dCuryRate)

                ELSE 0
        END, @BaseDecPl),
       GrpTaxID = v.GrpTaxID,
       GrpRate  = 0,
       GrpTaxTot = v.TaxAmt,
       GrpCuryTaxTot = v.CuryTaxAmt,
       v.VendID,
       v.DecPl,
@UserAddress,
v.projectID,
v.taskID
FROM vp_SalesTaxAPTranRls v
WHERE v.TaxCalcType = 'I'
  AND v.UserAddress = @UserAddress
GROUP BY v.tRecordID, v.CpnyID, v.DocType, v.RefNbr, v.TaxId,  v.tRecordID, v.TaxDate, v.TaxCalcLvl, v.TaxCalcType, v.DecPl,
        v.TaxAmt, v.CuryTaxAmt, v.TaxRate, v.dCuryRate, v.dCuryMultDiv, v.TaxAcct, v.TaxSub, v.reftype, v.VendID, v.GrpTaxID, v.projectID, v.taskID
IF @@ERROR <> 0 GOTO ABORT

-- First Set the Group Rate
-- Since Exceptions can exclude some taxes from some lines, need to get the group rate
-- by each usage.
UPDATE WS
   SET GrpRate = ( SELECT SUM(TaxRate)
                     FROM Wrk_SalesTax ws2
                    WHERE ws.UserAddress = ws2.UserAddress
                      AND ws.RecordID = ws2.RecordID
                      AND ws.CustVend = ws2.CustVend
                      AND ws.DocType = ws2.DocType
                      AND ws.Refnbr = ws2.Refnbr
                      AND ws.GrpTaxID = ws2.GrpTaxID )
  FROM Wrk_SalesTax ws
 WHERE ws.UserAddress = @UserAddress
   AND ws.GrpTaxID <> ' '

IF @@ERROR <> 0 GOTO ABORT

-- Apply rounding difference if any to first tax
UPDATE ws
   SET TaxTot = ws.TaxTot - Diff,
       CuryTaxTot = ws.CuryTaxTot - CuryDiff
  FROM Wrk_SalesTax ws JOIN (SELECT RecordID,CustVend,
                                    DocType,RefNbr,GrpTaxID,
                                    TaxID = MIN(TaxID),
                                    Diff = Sum(TaxTot) - MIN(GrpTaxTot),
                                    CuryDiff = Sum(CuryTaxTot) - MIN(GrpCuryTaxTot)
                               FROM Wrk_SalesTax
                              WHERE UserAddress = @UserAddress AND GrpTaxID <> ' '
                              GROUP BY RecordID,CustVend,
                                       DocType,RefNbr,GrpTaxID
                             HAVING SUM(TaxTot) - MIN(GrpTaxTot) <> 0
                                 OR SUM(CuryTaxtot) - MIN(GrpCuryTaxTot) <> 0) ws2
                         ON ws.RecordID = ws2.RecordID
                        AND ws.CustVend = ws2.CustVend
                        AND ws.DocType = ws2.DocType
                        AND ws.Refnbr = ws2.Refnbr
                        AND ws.GrpTaxID = ws2.GrpTaxID
                        AND ws.TaxID    = ws2.TaxID
 WHERE ws.UserAddress = @UserAddress
   AND ws.GrpTaxID <> ' '

IF @@ERROR <> 0 GOTO ABORT

/***** Insert APTran records for Sales Tax activity. *****/
DECLARE @CpnyID Char(10), @RefNbr Char(10), @DocType Char(2), @TaxID Char(10), @Acct Char(10),
        @Sub Char(24), @YrMon Char(6), @CuryTaxTot Float(30), @CuryTxblTot Float(30), @TaxTot Float(30), @TxblTot Float(30),
        @ProjectID Char(16), @TaskID Char(32), @TaxCalcType Char(1)

DECLARE @ProjectDefaultTask AS CHAR(32) -- Needed when the tax APTran is flagged for project
SET @ProjectDefaultTask = ISNULL((SELECT control_data FROM PJCONTRL (NOLOCK) WHERE control_type = 'PA' AND control_code = 'DEFAULT-TASK'), '')

DECLARE @NonPostProject AS CHAR (32)
set @NonPostProject = (Select Control_data From PJContrl Where Control_Code= 'NO-POST-PROJECT')
DECLARE TranCursor INSENSITIVE CURSOR FOR
        SELECT CpnyID,Refnbr,DocType,TaxID,Acct,
               Sub,YrMon,CuryTaxTot,CuryTxblTot,
               TaxTot,TxblTot, ProjectID, TaskID, TaxCalcType
          FROM Wrk_SalesTax
         where UserAddress = @UserAddress

OPEN TranCursor

FETCH NEXT FROM TranCursor INTO @CpnyID, @RefNbr, @DocType, @TaxID, @Acct, @Sub, @YrMon, @CuryTaxTot, 
        @CuryTxblTot, @TaxTot, @TxblTot, @ProjectID, @TaskID, @TaxCalcType
IF @@ERROR <> 0
Begin
  CLOSE TranCursor
  DEALLOCATE TranCursor
  GOTO ABORT
End

WHILE (@@FETCH_STATUS <> -1)
        BEGIN
                IF @@FETCH_STATUS <> -2
                        INSERT APTran (Acct, AcctDist,  Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,
                                Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId, CuryMultDiv, CuryRate,

                                CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
                                CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,

                                EmployeeID, Excpt, ExtRefNbr, FiscYr, InstallNbr, InvcTypeId,
                                JobRate, JrnlType, Labor_Class_Cd, LineId, LineNbr,
                                LineRef, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
                                NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PmtMethod, POLineRef,
                                ProjectID, Qty, Rcptnbr, RefNbr,        Rlsed,
                                S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                                S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
                                Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
                                TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
                                TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
                                UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, VendId,
				AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
				PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
				SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

                        SELECT @Acct, 1, '', d.BatNbr, '', '', '', '', d.CpnyID, GETDATE(), @ProgID, @Sol_User, d.CuryId,
                                d.CuryMultDiv, d.CuryRate, 0, 0, 0, 0, ROUND(@CuryTaxTot, c.DecPl), 0, 0, 0, 0, 0,
                                CASE d.DocType
                                        WHEN "VO" THEN "D"
                                        WHEN "AC" THEN "D"
					WHEN "PP" THEN "D"
                                        ELSE "C"
                                END, '', '', 0, d.InvcNbr, SUBSTRING(d.PerPost, 1, 4), d.InstallNbr, '', 0, 'AP',
                                '', 0, (SELECT MAX(LineNbr) FROM APTran
                                        WHERE LineNbr < 32765 AND RefNbr = @RefNbr AND TranType = @DocType) + 1,
                                '', 'T', GETDATE(), @ProgID, @Sol_User, d.MasterDocNbr, 0, '', '', -- PC_ID
                         CASE when @ProjectID = @NonPostProject then
								''
                         else
                          CASE when @TaxCalcType = 'T' then
                                
                                CASE
                                        WHEN (p.gl_acct IS NULL OR RTRIM(@ProjectID) = '') THEN ''
                                        ELSE '1'
                                END
                                
                           else
                                
                                 CASE when @TaxCalcType = 'D' then
										CASE
												WHEN (p.gl_acct IS NULL OR RTRIM(d.ProjectID) = '') THEN ''
												ELSE '1'
										END
                                ELSE 
                                ''
                                End
                           END
                           END, -- PC_Status
                                d.PerEnt, d.PerPost,
                                '', '',
                          CASE 
                                when @TaxCalcType = 'T' then
                                CASE
                                        WHEN (p.gl_acct IS NULL OR RTRIM(@projectid) = '') THEN ''
                                        ELSE @ProjectID
                                END
                          Else
                                CASe when @TaxCalcType = 'D' Then
                                CASE
                                        WHEN (p.gl_acct IS NULL OR RTRIM(d.ProjectID) = '') THEN ''
                                        ELSE d.ProjectID
                                END
                                
                                Else ''
                                End
                           END,  ---- ProjectID
                                0, '', d.RefNbr, 0, '', '', 0, 0, 0, 0, '', '', 0, 0,
				CASE d.s4future11
					WHEN "VM" THEN d.s4future11
					ELSE ''
				END,
 				CASE d.s4future11
					WHEN "VM" THEN d.s4Future12
					ELSE ''
				END,
				'', @Sub,
                        
                        CASe when @TaxCalcType = 'T' then
                                CASE
                                        WHEN (p.gl_acct IS NULL OR RTRIM(@ProjectID) = '') THEN ''
                                        ELSE @TaskID
                                END
                        Else
                            CASe when @TaxCalcType = 'D' then
                                   CASE
                                           WHEN (p.gl_acct IS NULL OR RTRIM(d.ProjectID) = '') THEN ''
                                           ELSE @ProjectDefaultTask
                                   END
                             ELSE ''
                             End
                        END, -- TaskID
                                0, 0, 0, 0, '', '', '', '', '', '', '', ROUND(@TaxTot, @BaseDecPl), 'T',
                                d.DocDate, s.Descr, d.DocType, 0, 0, 0, 0, '', 0, '', '', 0, 0, '', '', '', '', d.VendId,
				"","",0,0,0,"",0,"",0,0,0,0,"",0,"","","","","",""
                        FROM APDoc d, SalesTax s, Currncy c LEFT OUTER JOIN PJ_Account p (NOLOCK) ON p.gl_acct = @Acct
                        WHERE d.DocType = @DocType AND d.RefNbr = @RefNbr AND s.TaxId = @TaxId AND d.CuryId = c.CuryId
                        IF @@ERROR <> 0
                        Begin
                          CLOSE TranCursor
                          DEALLOCATE TranCursor
                          GOTO ABORT
                        End

                FETCH NEXT FROM TranCursor INTO @CpnyID, @RefNbr, @DocType, @TaxID, @Acct, @Sub, @YrMon, @CuryTaxTot,
                        @CuryTxblTot, @TaxTot, @TxblTot, @ProjectID, @TaskID, @TaxCalcType
                        IF @@ERROR <> 0
                        Begin
                          CLOSE TranCursor
                          DEALLOCATE TranCursor
                          GOTO ABORT
                        End

        END
CLOSE TranCursor
DEALLOCATE TranCursor

/*COMMIT TRANSACTION*/
SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0
/*ROLLBACK TRANSACTION*/

FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_SalesTaxAPRelease] TO [MSDSL]
    AS [dbo];

