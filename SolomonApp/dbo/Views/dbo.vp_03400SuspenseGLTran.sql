 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_03400SuspenseGLTran AS 

/****** File Name: 0307vp_03400SuspenseGLTran.Sql	 */			

SELECT  t.recordid,w.UserAddress, t.Acct, AppliedDate = CONVERT(SMALLDATETIME,'1/1/1900'), BalanceType = 'A', 
	t.BatNbr, t.CpnyID, 
	CrAmt = CASE DrCr WHEN 'C' THEN t.TranAmt			
		            ELSE 0 END,  
	Crtd_DateTime=getdate(), t.Crtd_Prog, t.Crtd_User,
	CuryCrAmt = CASE DrCr WHEN 'C' THEN	t.CuryTranAmt  
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
	Units = CONVERT(FLOAT, 0),  t.User1, t.User2, t.User3, t.User4,
	t.User5, t.User6, t.User7, t.User8,
	FromCpnyID = d.CpnyID, Screen = b.EditScrnNbr + '00'
	
  FROM WrkRelease w INNER LOOP JOIN Batch b
                    ON w.BatNbr = b.BatNbr
                   AND w.Module = b.Module
                  JOIN APDoc d
                    ON d.BatNbr = b.BatNbr
                  JOIN APTran t
                    ON t.BatNbr = d.BatNbr 
                   AND t.VendId = d.VendId
                   AND t.RefNbr = d.RefNbr
                  LEFT OUTER JOIN Account a (NOLOCK)
                    ON t.Acct = a.Acct
     
 WHERE w.Module = 'AP' and a.Acct is NULL


 
