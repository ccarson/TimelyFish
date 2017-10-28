 
CREATE VIEW vp_08400GLTran AS 
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400GLTran
*
*++* Narrative: Selects the gltran amounts and accounts from the AR tran lines.
*++*            The view has two parts. The first select returns non-summarized account 
*++*            information. The select after the union returns summarized information.
*++*            To summarize or not is determined by the ShareAcctPostType view.
*

*
*   Called by: pp_08400
* 
*/


SELECT t.Recordid, w.UserAddress, t.Acct, 
        AppliedDate = CONVERT(SMALLDATETIME,'1/1/1900'),
        BalanceType = 'A', t.BatNbr, t.CpnyID, 
	CrAmt = CASE DrCr WHEN 'C' THEN CONVERT(DEC(28,3),t.TranAmt) ELSE 0 END, 
	crtd_datetime =  getdate() , t.Crtd_Prog, t.Crtd_User,
	CuryCrAmt = CASE DrCr WHEN 'C' THEN CONVERT(DEC(28,3),t.CuryTranAmt) ELSE 0 END,
	CuryDrAmt = CASE DrCr WHEN 'D' THEN CONVERT(DEC(28,3),t.CuryTranAmt) ELSE 0 END, 
	CuryEffDate = CONVERT(SMALLDATETIME,'1/1/1900'), t.CuryID, 
        t.CuryMultDiv, t.CuryRate, CuryRateType = ' ', 
	DrAmt = CASE DrCr WHEN 'D' THEN CONVERT(DEC(28,3),t.TranAmt) ELSE 0 END, 
	EmployeeID = ' ', t.ExtRefNbr, t.FiscYr, IC_Distribution = 0, 
        Id = t.CustID, t.JrnlType, 
	Labor_Class_Cd = ' ', LineId = 0, LineNbr = 0, LineRef = ' ', t.LUpd_DateTime, 
	t.LUpd_Prog, t.LUpd_User, Module = 'AR', NoteID = 0, 
	OrigAcct = SUBSTRING(t.ProjectID, 1, 10), OrigBatNbr = ' ', 
	CASE WHEN (d.doctype IN  ('IN','DM','CM','CS','AD')) 
               THEN   d.cpnyid
	     ELSE   t.cpnyid
             END origcpnyid,   	
 	OrigSub = SUBSTRING(t.TaskID, 1, 24), 
	PC_Flag = ' ', PC_ID = ' ', PC_Status = ' ', t.PerEnt, t.PerPost, Posted = 'U', 
	t.ProjectID, Qty = CASE WHEN b.EditScrnNbr = '08010' 
                                  THEN CONVERT(DEC(28,9),t.qty) 
                                ELSE  0 END, 
        t.RefNbr, RevEntryOption = ' ', 
        Rlsed = 1, t.S4Future01, t.S4Future02, 
	t.S4Future03, t.S4Future04, t.S4Future05, t.S4Future06,t.S4Future07, 
        t.S4Future08,t.S4Future09, t.S4Future10, t.S4Future11, t.S4Future12, 
        ServiceDate = CONVERT(SMALLDATETIME,'1/1/1900'), t.Sub, t.TaskId, 
	TranDate = CONVERT(SMALLDATETIME, t.TranDate), t.TranDesc, t.TranType, 
	Units = CASE WHEN b.EditScrnNbr = '08010' 
                       THEN CONVERT(DEC(28,3),t.unitprice) 
                     ELSE 0 
                     END, 
        t.User1, t.User2, t.User3, t.User4, t.User5, t.User6, 
        t.User7, t.User8, FromCpnyID = d.CpnyID, Screen = RTRIM(b.Crtd_Prog) + '00'
  FROM ARSetup s (NOLOCK) CROSS JOIN 
       WrkRelease w JOIN Batch b
                      ON w.BatNbr = b.BatNbr
                     AND w.module = b.module
                    JOIN ARTran t 
                      ON b.BatNbr = t.BatNbr
                    JOIN Account a (NOLOCK) 
                      ON t.Acct = a.Acct
                    JOIN ARDoc d 
                      ON (d.batnbr = t.batnbr 
                          OR (d.applbatnbr = t.batnbr 
                         AND d.doctype IN ('PA','PP','CM')))
                     AND d.CustID = t.CustID
                     AND d.DocType = t.TranType
                     AND d.RefNbr = t.RefNbr
                     
 WHERE w.Module = 'AR' AND a.SummPost <> 'Y' AND s.GLPostOpt <> 'S'

UNION ALL

SELECT MIN(t.Recordid+0),
       w.UserAddress, t.Acct, 
       AppliedDate = CONVERT(SMALLDATETIME,'1/1/1900'), BalanceType = 'A', t.BatNbr, t.CpnyID,
       CrAmt = SUM(CASE DrCr WHEN 'C' THEN CONVERT(DEC(28,3),t.TranAmt) ELSE 0 END), 
       getdate(), '08400', 'Solomon',
       CuryCrAmt = SUM(CASE DrCr WHEN 'C' THEN CONVERT(DEC(28,3),t.CuryTranAmt) ELSE 0 END),
       CuryDrAmt = SUM(CASE DrCr WHEN 'D' THEN CONVERT(DEC(28,3),t.CuryTranAmt) ELSE 0 END), 
       CuryEffDate = CONVERT(SMALLDATETIME,'1/1/1900'), t.CuryID, MAX(t.CuryMultDiv), 
       MAX(t.CuryRate), CuryRateType = ' ', 
       DrAmt = SUM(CASE DrCr WHEN 'D' THEN CONVERT(DEC(28,3),t.TranAmt) ELSE 0 END), 
       EmployeeID = ' ', ExtRefNbr = ' ', t.FiscYr, 0, ' ', t.JrnlType, 
       Labor_Class_Cd = ' ', LineId = 0, LineNbr = 0, ' ', getdate(), '08400', 'Solomon', Module = 'AR', NoteID = 0,
       OrigAcct = ' ', ' ', 
       CASE 
           WHEN (d.doctype IN  ('IN','DM','CM','CS', 'AD')) then   d.cpnyid
	   ELSE t.cpnyid
           END  origcpnyid,
       OrigSub = ' ', PC_Flag = ' ', PC_ID = ' ', PC_Status = ' ',
       t.PerEnt, t.PerPost, Posted = 'U', ' ', 
       Qty = SUM(CASE WHEN b.EditScrnNbr = '08010' 
                                  THEN CONVERT(DEC(28,9),t.qty) 
                                ELSE  0 END), ' ', ' ', Rlsed = 1, ' ', ' ', 0, 0, 0, 0, 
       ' ', ' ', 0, 0, ' ', ' ', CONVERT(SMALLDATETIME,'1/1/1900'), t.Sub, ' ',
       CONVERT(SMALLDATETIME, GETDATE()), 'Summary Release', t.TranType,
       Units = 0, 
       User1 = ' ', User2 = ' ', 
       User3 = 0, User4 = 0, ' ', ' ', User7 = CONVERT(SMALLDATETIME,'1/1/1900'), 
       User8 = CONVERT(SMALLDATETIME,'1/1/1900'), 
       FromCpnyID = d.CpnyID, Screen = min(b.EditScrnNbr) + '00'

  FROM ARSetup s (NOLOCK) CROSS JOIN 
       WrkRelease w JOIN Batch b
                      ON w.BatNbr = b.BatNbr
                     AND w.module = b.module
                    JOIN ARTran t 
                      ON b.BatNbr = t.BatNbr
                    JOIN Account a (NOLOCK) 
                      ON t.Acct = a.Acct
                    JOIN ARDoc d 
                      ON (d.batnbr = t.batnbr 
                          OR (d.applbatnbr = t.batnbr 
                         AND d.doctype IN ('PA','PP','CM')))
                     AND d.CustID = t.CustID
                     AND d.DocType = t.TranType
                     AND d.RefNbr = t.RefNbr
 WHERE  w.Module = 'AR' AND (a.SummPost = 'Y' OR s.GLPostOpt = 'S')

 GROUP BY w.UserAddress, t.Acct, t.BatNbr, t.CuryID, t.FiscYr, t.JrnlType, d.doctype,
	t.PerEnt, t.PerPost, t.Sub, t.CpnyID, t.TranType, d.CpnyID,t.drcr

 
