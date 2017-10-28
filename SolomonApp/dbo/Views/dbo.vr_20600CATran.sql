 

CREATE VIEW vr_20600CATran AS

SELECT t.Acct,
       t.AcctDist,
       t.bankacct,
       t.BankCpnyID,
       t.banksub,
       t.batnbr,
       t.ClearAmt,
       t.ClearDate,
       t.CpnyID,
       t.Crtd_DateTime,
       t.Crtd_Prog, 
       t.Crtd_User,
       t.CuryID,
       t.CuryMultDiv,
       t.CuryRate,
       CuryTranAmt = CASE 
                     WHEN t.EntryId = 'TR' 
                     THEN (-1*t.curytranamt) 
                     ELSE t.curytranamt END,
       t.DrCr,
       t.EntryId,
       t.JrnlType,
       t.LineID,
       t.Linenbr,
       t.LineRef,
       t.LUpd_DateTime,
       t.LUpd_Prog,
       t.LUpd_User,
       t.Module,
       t.NoteID,
       t.PayeeID,
       t.PC_Status,
       t.PerClosed,
       t.Perent,
       t.PerPost,
       t.ProjectID,
       RcnclStatus = CASE 
                     WHEN RTRIM(LTRIM(t.RcnclStatus)) = '' 
                     THEN ISNULL(r.RcnclStatus,'')
                     WHEN RTRIM(LTRIM(t.RcnclStatus)) <> '' 
                     THEN ISNULL(t.RcnclStatus,'') END,
       t.RecurId,
       t.RefNbr,
       t.Rlsed,
       t.S4Future01,t.S4Future02,t.S4Future03,t.S4Future04,t.S4Future05,t.S4Future06,t.S4Future07,t.S4Future08,t.S4Future09,t.S4Future10,t.S4Future11,t.S4Future12,
       t.Sub,
       t.TaskID,
       TranAmt = CASE 
                 WHEN t.EntryId = 'TR' 
                 THEN (-1*t.TranAmt) 
                 ELSE t.TranAmt END,
       t.TranDate,
       t.TranDesc,
       t.trsftobankacct,
       t.trsftobanksub,
       t.TrsfToCpnyID,
       t.User1,t.User2,t.User3,t.User4,t.User5,t.User6,t.User7,t.User8

FROM CATran t LEFT OUTER JOIN CATran r ON 
         t.batnbr = r.batnbr AND 
         t.module = r.module AND 
         t.bankcpnyid = r.bankcpnyid AND
         t.EntryID <> 'ZZ' AND 
         isnull(r.EntryID,'') = 'ZZ' 
  
WHERE t.EntryID <> 'ZZ'   


 
