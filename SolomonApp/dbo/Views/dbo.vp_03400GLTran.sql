 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_03400GLTran AS 

/****** File Name: 0307vp_03400GLTran.Sql								******/ 
/****** Last Modified by CSS 12/18/98 at 12:15pm;DCR on 12/10/98 at 7:30pm 				******/
/****** Select all released AP Tran records to be moved to GL ready to be posted.	******/
/****** 12/18/98 - Added t.TranType to Union Select and Group By				******/
/****** 06/02/99 Added check for PPV (AP/PO integration).  PPV offset is always positive *****/
/******		 PPV-Accrued AP is always negative to offset PPV ******/
SELECT  t.recordid,w.UserAddress, t.Acct, AppliedDate = CONVERT(SMALLDATETIME,'1/1/1900'), BalanceType = 'A', t.BatNbr, t.CpnyID, 
	CrAmt = CASE DrCr WHEN 'C' THEN t.Tranamt 
	            	ELSE 0 END, 
	Crtd_DateTime=getdate(), t.Crtd_Prog, t.Crtd_User,
	CuryCrAmt = CASE DrCr WHEN 'C' THEN t.CuryTranAmt
				    ELSE 0 END,
	CuryDrAmt = CASE DrCr WHEN 'D' THEN t.CuryTranAmt
		                ELSE 0 END,
	CuryEffDate = CONVERT(SMALLDATETIME,'1/1/1900'), t.CuryID, t.CuryMultDiv, t.CuryRate, CuryRateType = ' ', 
	DrAmt = CASE DrCr WHEN 'D' THEN t.TranAmt 
	            	ELSE 0 END,  
	EmployeeID = ' ', ExtRefNbr = t.ExtRefNbr, t.FiscYr, IC_Distribution = 0, Id = t.VendID, t.JrnlType, 
	Labor_Class_Cd = ' ', LineId = 0, LineNbr = 0, LineRef = ' ', t.LUpd_DateTime, 
	t.LUpd_Prog, t.LUpd_User, Module = 'AP', NoteID = 0, 
	OrigAcct = SUBSTRING(t.ProjectID, 1, 10), OrigBatNbr = ' ', OrigCpnyID = b.cpnyid, OrigSub = SUBSTRING(t.TaskID, 1, 24), 
	PC_Flag = ' ', PC_ID = ' ', PC_Status = ' ', t.PerEnt, t.PerPost, Posted = 'U', 
	t.ProjectID, Qty = CONVERT(FLOAT, 0), t.RefNbr, RevEntryOption = ' ', Rlsed = 1, t.S4Future01, t.S4Future02, 
	t.S4Future03, t.S4Future04, t.S4Future05, t.S4Future06,t.S4Future07, t.S4Future08,
	t.S4Future09, t.S4Future10, t.S4Future11, t.S4Future12, t.ServiceDate, t.Sub, t.TaskId, 
	TranDate = CONVERT(SMALLDATETIME, t.TranDate), t.TranDesc, t.TranType, 
	Units = CONVERT(FLOAT, 0), t.User1, t.User2, t.User3, t.User4,
	t.User5, t.User6, t.User7, t.User8, 
	FromCpnyID = d.CpnyID, Screen = b.EditScrnNbr + '00'

  FROM APSetup s (NOLOCK) CROSS JOIN
       WrkRelease w JOIN APTran t
                      ON w.BatNbr = t.BatNbr
                    JOIN Account a (NOLOCK)
                      ON a.Acct = t.Acct
                    JOIN APDoc d
                      ON d.BatNbr = t.BatNbr
                     AND d.VendId = t.VendId
                     AND d.RefNbr = t.RefNbr
                     AND (d.DocType <> 'VC' OR d.Status <> 'T')
                    JOIN Batch b
                      ON b.BatNbr = t.BatNbr
                     AND b.Module = w.Module
 WHERE w.Module = 'AP' AND a.SummPost <> 'Y' AND s.GLPostOpt <> 'S'

UNION ALL

SELECT  min(t.recordid),w.UserAddress, t.Acct, AppliedDate = CONVERT(SMALLDATETIME,'1/1/1900'), BalanceType = 'A', t.BatNbr, t.CpnyID,
	CrAmt = SUM(CASE DrCr WHEN 'C' THEN 			
			convert(dec(28,3),t.TranAmt )
		ELSE 0 END ), 
	getdate(), '03400', 'Solomon',
	CuryCrAmt = SUM(CASE DrCr WHEN 'C' THEN 
			convert(dec(28,3),t.CuryTranAmt )
		    ELSE 0 END),
	CuryDrAmt = SUM(CASE DrCr WHEN 'D' THEN
				convert(dec(28,3),t.CuryTranAmt)
		    ELSE 0 END), 
	CuryEffDate = CONVERT(SMALLDATETIME,'1/1/1900'), t.CuryID, MAX(t.CuryMultDiv), 
	MAX(t.CuryRate), CuryRateType = ' ', 
	DrAmt = SUM(CASE DrCr WHEN 'D' THEN 			
				convert(dec(28,3),t.TranAmt )
		ELSE 0 END ), 
	EmployeeID = ' ', ExtRefNbr = ' ', t.FiscYr, 0, ' ', t.JrnlType, 
	Labor_Class_Cd = ' ', LineId = 0, LineNbr = 0, ' ', ' ', ' ', ' ', Module = 'AP', NoteID = 0,
	OrigAcct = ' ', ' ', b.cpnyid, OrigSub = ' ', PC_Flag = ' ', PC_ID = ' ', PC_Status = ' ',
	t.PerEnt, t.PerPost, Posted = 'U', ' ', Qty = CONVERT(FLOAT, 0), ' ', ' ', Rlsed = 1, ' ', ' ', 0, 0, 0, 0, 
	' ', ' ', 0, 0, ' ', ' ', CONVERT(SMALLDATETIME,'1/1/1900'), t.Sub, ' ', CONVERT(char, GETDATE(),101), 'Summary Release', t.trantype, 
	Units = CONVERT(FLOAT, 0), User1 = ' ', User2 = ' ', User3 = CONVERT(FLOAT, 0), User4 = CONVERT(FLOAT, 0), ' ', ' ', 
	User7 = CONVERT(SMALLDATETIME,'1/1/1900'), User8 = CONVERT(SMALLDATETIME,'1/1/1900'), 
	FromCpnyID = d.CpnyID, Screen = min(b.EditScrnNbr) + '00'

  FROM APSetup s (NOLOCK) CROSS JOIN
       WrkRelease w JOIN APTran t
                      ON w.BatNbr = t.BatNbr
                    JOIN Account a (NOLOCK)
                      ON a.Acct = t.Acct
                    JOIN APDoc d
                      ON d.BatNbr = t.BatNbr
                     AND d.VendId = t.VendId
                     AND d.RefNbr = t.RefNbr
                     AND (d.DocType <> 'VC' OR d.Status <> 'T')
                    JOIN Batch b
                      ON b.BatNbr = t.BatNbr
                     AND b.Module = w.Module
 WHERE w.Module = 'AP' AND (a.SummPost = 'Y' OR s.GLPostOpt = 'S')

GROUP BY w.UserAddress, b.cpnyid,t.Acct, t.BatNbr, t.CuryID, t.FiscYr, t.JrnlType, 
	t.PerEnt, t.PerPost, t.Sub, t.CpnyID, d.CpnyID, t.trantype, t.drcr



 
