 
CREATE VIEW vp_08400SuspenseGLTran AS 

SELECT  t.Recordid, 
        w.UserAddress, t.Acct, AppliedDate = CONVERT(SMALLDATETIME,'1/1/1900'),
        BalanceType = 'A', t.BatNbr, t.CpnyID, 
        CrAmt = CASE DrCr WHEN 'C' 
                       THEN CONVERT(dec(28,3),t.TranAmt) 
                       ELSE 0 END, 
        crtd_datetime =  GETDATE() , t.Crtd_Prog, t.Crtd_User,
        CuryCrAmt = CASE DrCr WHEN 'C' 
                       THEN CONVERT(dec(28,3),t.CuryTranAmt) 
                       ELSE 0 END,
        CuryDrAmt = CASE DrCr WHEN 'D' 
                       THEN CONVERT(dec(28,3),t.CuryTranAmt) 
                       ELSE 0 END, 
        CuryEffDate = CONVERT(SMALLDATETIME,'1/1/1900'), t.CuryID, 
        t.CuryMultDiv, t.CuryRate, CuryRateType = ' ', 
        DrAmt = CASE DrCr WHEN 'D' 
                       THEN CONVERT(dec(28,3),t.TranAmt) 
                       ELSE 0 END, 
        EmployeeID = ' ', ExtRefNbr = ' ', t.FiscYr, IC_Distribution = 0, 
        Id = t.CustID, t.JrnlType, 
        Labor_Class_Cd = ' ', LineId = 0, LineNbr = 0, LineRef = ' ', t.LUpd_DateTime, 
        t.LUpd_Prog, t.LUpd_User, Module = 'AR', NoteID = 0, 
        OrigAcct = SUBSTRING(t.ProjectID, 1, 10), OrigBatNbr = ' ', 
        origcpnyid = CASE WHEN (d.doctype IN  ('IN','DM','CM','CS')) 
                       THEN d.cpnyid
	               ELSE   t.cpnyid END ,   	
        OrigSub = SUBSTRING(t.TaskID, 1, 24), 
        PC_Flag = ' ', PC_ID = ' ', PC_Status = ' ', t.PerEnt, t.PerPost, Posted = 'U', 
        t.ProjectID, Qty = 0, t.RefNbr, RevEntryOption = ' ', 
        Rlsed = 1, t.S4Future01, t.S4Future02, 
        t.S4Future03, t.S4Future04, t.S4Future05, t.S4Future06,t.S4Future07, 
        t.S4Future08,t.S4Future09, t.S4Future10, t.S4Future11, t.S4Future12, 
        ServiceDate = CONVERT(SMALLDATETIME,'1/1/1900'), t.Sub, t.TaskId, 
        TranDate = CONVERT(SMALLDATETIME, t.TranDate), t.TranDesc, t.TranType, 
        Units =  0, t.User1, t.User2, t.User3, t.User4, t.User5, t.User6, 
        t.User7, t.User8, FromCpnyID = d.CpnyID, Screen = RTRIM(b.Crtd_Prog) + '00'
  FROM  WrkRelease w INNER JOIN Batch b
                           ON w.batnbr = b.batnbr     
                           AND w.module = b.module
                     INNER JOIN ARTran t 
                           ON b.batnbr = t.batnbr
                     INNER JOIN ARDoc d
                           ON d.RefNbr = t.RefNbr
                           AND d.CustID = t.CustID
                           AND d.DocType = t.TranType
                     LEFT OUTER JOIN Account a 
                           ON a.Acct = t.Acct   
         
        
 WHERE w.Module = 'AR' 
    AND (d.batnbr = t.batnbr 
	OR (d.applbatnbr = t.batnbr AND d.doctype IN ('PA','PP')))
    AND a.SummPost IS NULL


 
