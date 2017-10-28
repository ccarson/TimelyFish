 

CREATE VIEW vr_01810 AS 
   SELECT
   -- Batch Fields
	Batch_Acct              = b.Acct,
	Batch_AutoRev           = b.AutoRev, 
      Batch_AutoRevCopy       = b.AutoRevCopy,
      Batch_BalanceType       = b.BalanceType,
      Batch_BankAcct          = b.BankAcct,
      Batch_BankSub           = b.BankSub,
      Batch_BaseCuryID        = b.BaseCuryID, 
      Batch_BatNbr            = b.BatNbr,
      Batch_BatType           = b.BatType,
      Batch_CpnyID            = b.CpnyID,
      Batch_CrTot             = b.CrTot,
      Batch_CtrlTot           = b.CtrlTot,
      Batch_CuryCrTot         = b.CuryCrTot,
      Batch_CuryCtrlTot       = b.CuryCtrlTot,
      Batch_CuryDepositAmt    = b.CuryDepositAmt, 
      Batch_CuryDrTot         = b.CuryDrTot,     
      Batch_CuryID            = b.CuryId, 
      Batch_Cycle             = b.Cycle,
      Batch_DateEnt           = b.DateEnt,
      Batch_DepositAmt        = b.DepositAmt,
      Batch_DrTot             = b.DrTot,
      Batch_EditScrnNbr       = b.EditScrnNbr,
      Batch_JrnlType          = b.JrnlType,
      Batch_LedgerID          = b.LedgerID,
      Batch_Module            = b.Module,
      Batch_NbrCycle          = b.NbrCycle,
      Batch_OrigBatNbr        = b.OrigBatNbr,
      Batch_PerEnt            = b.PerEnt,
      Batch_PerPost           = b.PerPost, 
      Batch_Rlsed             = b.Rlsed,	
      Batch_Status            = b.Status,
      Batch_Sub               = b.Sub,
      Batch_User1             = b.User1,
      Batch_User2             = b.User2,
      Batch_User3             = b.User3, 
      Batch_User4             = b.User4,
      Batch_User5             = b.User5,
      Batch_User6             = b.User6,
      Batch_User7             = b.User7,
      Batch_User8             = b.User8,
      -- GLTran Fields
      GLTran_Acct             = t.Acct,  
      GLTran_BaseCuryId       = t.BaseCuryId,
      GLTran_CpnyId           = t.CpnyID,
      GLTran_CrAmt            = t.CrAmt,
      GLTran_CuryCrAmt        = t.CuryCrAmt,
      GLTran_CuryDrAmt        = t.CuryDrAmt, 
      GLTran_CuryEffDate      = t.CuryEffDate,
      GLTran_CuryId           = t.CuryID,
      GLTran_CuryMultDiv      = t.CuryMultDiv,
      GLTran_CuryRate         = t.CuryRate,
      GLTran_CuryRateType     = t.CuryRateType,      
      GLTran_DrAmt            = t.DrAmt,    
      GLTran_EmployeeID       = t.EmployeeID,
      GLTran_ExtRefNbr        = t.ExtRefNbr,   
      GLTran_FiscYr           = t.FiscYr,
      GLTran_IC_Distribution  = t.IC_Distribution,
      GLTran_ID               = t.ID,
      GLTran_JrnlType         = t.JrnlType,
      GLTran_Labor_Class_CD   = t.Labor_Class_CD,
      GLTran_LineNbr          = t.LineNbr,
      GLTran_LineRef          = t.LineRef,
      GLTran_LUpd_DateTime    = t.LUpd_DateTime,
      GLTran_LUpd_Prog        = t.LUpd_Prog,
      GLTran_LUpd_User        = t.Lupd_User,
      GLTran_OrigAcct         = t.OrigAcct,
      GLTran_OrigBatNbr       = t.OrigBatNbr,
      GLTran_OrigCpnyID       = t.OrigCpnyID,
      GLTran_OrigSub          = t.OrigSub,
      GLTran_PC_Flag          = t.PC_Flag,
      GLTran_PC_Status        = t.PC_Status,
      GLTran_Posted           = t.Posted,
      GLTran_ProjectID        = t.ProjectID,
      GLTran_Qty              = t.Qty,
      GLTran_RefNbr           = t.RefNbr,
      GLTran_Sub              = t.Sub,
      GLTran_TaskID           = t.TaskID,
      GLTran_TranDate         = t.TranDate,
      GLTran_TranDesc         = t.TranDesc,
      GLTran_TranType         = t.TranType,	
      GLTran_Units            = t.Units,
      GLTran_User1            = t.User1,
      GLTran_User2            = t.User2,
      GLTran_User3            = t.User3,
      GLTran_User4            = t.User4,
      GLTran_User5            = t.User5, 
      GLTran_User6            = t.User6,
      GLTran_User7            = t.User7,
      GLTran_User8            = t.User8,
      -- RptCompany Fields
      RPT_Company_RI_ID       = c.RI_ID,
      -- Company Fields (for Batch Company)
      Company_City            = p.City,
      Company_Country         = p.Country,
      Company_Batch_CpnyName  = p.CpnyName,
      -- Company Fields (for GLTran Company)
      Company_GLTran_CpnyName = y.CpnyName,
      -- AcctXRef Fields
      AcctXRef_AcctType       = a.AcctType, 
      AcctXRef_Descr          = a.Descr,
	-- View Specific Fields
	InterCmpy_Tran_Flag     = CASE WHEN t.TranType = 'IC' THEN 1 ELSE 0 END
   FROM Batch b INNER JOIN GLTran      t          ON b.BatNbr  = t.BatNbr AND
                                                     b.Module  = t.Module 
                INNER JOIN RptCompany  c (NOLOCK) ON b.CpnyID  = c.CpnyID
                INNER JOIN VS_Company  p (NOLOCK) ON b.CpnyID  = p.CpnyID
                INNER JOIN VS_Company  y (NOLOCK) ON t.CpnyID  = y.CpnyID 
                INNER JOIN VS_AcctXRef a (NOLOCK) ON y.CpnyCOA = a.CpnyID AND
                                                     t.Acct    = a.Acct    
   WHERE b.Status IN ('B',        -- Balanced
                      'H',        -- On Hold
                      'P',        -- Posted
                      'U')        -- Unposted    


 
