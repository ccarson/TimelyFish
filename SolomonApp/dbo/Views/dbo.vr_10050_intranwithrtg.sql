 

Create view vr_10050_intranwithrtg as 
SELECT operationid = ' ',DirOthAmt = 0, DirLbrAmt = 0, Ovhlbramt = 0, Ovhmachamt = 0, Acct, AcctDist, ARDocType, ARLineID, ARLineRef, 
       BatNbr, BMICuryID, BMIEffDate, BMIEstimatedCost, BMIExtCost, BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct, 
       CnvFact, COGSAcct, COGSSub, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, EstimatedCost, Excpt, ExtCost, 
       ExtRefNbr, FiscYr, FlatRateLineNbr, ID, InsuffQty, InvtAcct, InvtID, InvtMult, InvtSub, IRProcessed, JrnlType, KitID, KitStdQty, 
       LayerType, LineID, LineNbr, LineRef, LotSerCntr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, OrigBatNbr, OrigJrnlType, 
       OrigLineRef, OrigRefNbr, OvrhdAmt, OvrhdFlag, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PostingOption, ProjectID, Qty, 
       QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr, Retired, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, 
       S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceCallID, ShipperCpnyID, ShipperID, 
       ShipperLineRef, ShortQty, SiteID, SlsperID, SpecificCostID, StdTotalQty, Sub, SvcContractID, SvcLineNbr, TaskID, ToSiteID, 
       ToWhseLoc, TranAmt, TranDate, TranDesc, TranType, UnitCost, UnitDesc, UnitMultDiv, UnitPrice, User1, User2, User3, User4, User5, 
       User6, User7, User8, UseTranCost, WhseLoc

 FROM intran
UNION
SELECT operationid, DirOthAmt,Dirlbramt,Ovhlbramt,Ovhmachamt, '',0,'',0,'', r.BatNbr,'','01/01/1900',0,0, '',0,'',0,0, 0,0,'','','', '',
       '01/01/1900','','','', 0,0,0,'','', 0,'',0,'','', 0,'',0,'','', 0,'',0,0,'', 0,'01/01/1900','','',0, '','','','',0, 0,'','','','', 
       '',0,'',0,0, '01/01/1900','','','',0, 1,'','',0,0, 0,0,'01/01/1900','01/01/1900',0, 0,'','','','', '','',0,'','', '',0,'','',0, 
       '','','',0,'01/01/1900', '','AS',0,'','', 0,'','',0,0, '','','01/01/1900','01/01/1900',0, ''
 FROM rtgtran r

 
