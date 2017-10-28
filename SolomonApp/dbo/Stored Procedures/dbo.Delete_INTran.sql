 Create Proc Delete_INTran
    @PerPost 		varchar ( 6), 		-- Period to Purge from InTran
    @Archive_PerPost    varchar ( 6),	        -- Fiscal Year to Purge from InArchTran
    @Cpnyid 		varchar (10)		-- Company ID

as

    Create Table #IN10580_Wrk (
            CpnyId Character ( 10),
            InvtId Character ( 30),
            SiteId Character ( 10),
            WhseLoc Character ( 10),
            Qty Float,
            Cost Float,
            BMICost Float)

    Insert Into #IN10580_Wrk (CpnyId, InvtId, Siteid, WhseLoc, Qty, Cost, BMICost)
        Select CpnyId,
               InvtId,
               SiteId,
               WhseLoc,
      	   Qty = Sum(Case When CnvFact = 0
                              Then Round(Qty * InvtMult, i.DecPlQty)
                              Else Case When UnitMultDiv = 'D'
                                         Then (Round((Qty / CnvFact), i.DecPlQty)* InvtMult)
                                         Else (Round((Qty * CnvFact), i.DecPlQty)* InvtMult)
                                   End
                         End),
               Cost = Sum(Case When Trantype IN ('IN','DM','CM', 'RI') or (Trantype = 'AS' and Len(Rtrim(KitId)) > 0)
                               Then (ExtCost * InvtMult)
                               Else (Tranamt * Invtmult)
                          End),
               BMICost = Sum(Case When Trantype IN ('IN','DM','CM', 'RI') or (Trantype = 'AS' and Len(Rtrim(KitId)) > 0)
                               Then (BMIExtCost * InvtMult)
                               Else (BMITranamt * Invtmult)
                          End)
               From INTran
		   Join (Select DecPlQty  from INSetup) as i on 0 = 0       -- There isn't any Field to join Intran and INSetup therefore using 0=0
               Where TranType not in ('CT', 'CG')
                 And Rlsed = 1
                 And S4Future09 = 0
                 And InSuffQty = 0
                 And Cpnyid = @Cpnyid
                 And PerPost <= @PerPost
               Group by CpnyId, InvtId, SiteId, WhseLoc

    Insert Into INArchTran (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate, BMIExtCost,
                            BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct, Kitid, CnvFact, COGSAcct,
                            COGSSub, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, Excpt, ExtCost,
                            ExtRefNbr, FiscYr, Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub, JrnlType, LineId,
                            LineNbr, LineRef, LotSerCntr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, OvrhdAmt,
                            OvrhdFlag, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, QtyUnCosted, RcptDate,
                            RcptNbr, ReasonCd, RefNbr,Recordid, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04,
                            S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                            ShortQty, SiteId, SlsperId, SpecificCostID, Sub, TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate,
                            TranDesc, TranType, UnitDesc, UnitMultDiv, UnitPrice, User1, User2, User3, User4, User5, User6,
                            User7, User8, WhseLoc)
        Select Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate, BMIExtCost, BMIMultDiv, BMIRate, BMIRtTp,
                            BMITranAmt, BMIUnitPrice, CmmnPct, KitID, CnvFact, COGSAcct, COGSSub, CostType, CpnyID,
                            Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, Excpt, ExtCost, ExtRefNbr, FiscYr, Id, InsuffQty,
                            InvtAcct, InvtId, InvtMult, InvtSub, JrnlType, LineId, LineNbr, LineRef, LotSerCntr,
                            LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, OvrhdAmt, OvrhdFlag, PC_Flag, PC_ID, PC_Status,
                            PerEnt, PerPost, ProjectID, Qty, QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr,Recordid,
                            Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
                            S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ShortQty, SiteId, SlsperId,
                            SpecificCostID, Sub, TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc, TranType, UnitDesc,
                            UnitMultDiv, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc
               From InTran
               where Rlsed = 1
                 And InSuffQty = 0
                 And PerPost <= @PerPost
                 And Cpnyid = @Cpnyid
                 And TranType <> 'AB'

    Delete INTran from INTran
        Where Rlsed = 1
          And InSuffQty = 0
          And PerPost <= @PerPost
          And Cpnyid = @Cpnyid
           Or TranType = 'AB'

    Insert Into INTran (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate, BMIExtCost, BMIMultDiv,
                        BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct, KitID, CnvFact, COGSAcct, COGSSub,
                        CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, Excpt, ExtCost, ExtRefNbr, FiscYr,
                        Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub, JrnlType, LineId, LineNbr, LineRef,
                        LotSerCntr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, OvrhdAmt, OvrhdFlag, PC_Flag, PC_ID,
                        PC_Status, PerEnt, PerPost, ProjectID, Qty, QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr,
                        Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
                        S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ShortQty, SiteId, SlsperId,
                        SpecificCostId, Sub, TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc, TranType,
                        UnitDesc, UnitMultDiv, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, WhseLoc)
                Select  '', 0, 0, '', '000000', '', '', BMICost, '', 0, '', BMICost, 0, 0, '', 0, Space(1),
                        Space(1), '', CpnyID, GetDate(), '1099000', USER_NAME(), DrCr = Case When Qty < 0 Then 'C' Else 'D' End,
                        0, Cost, '', '', '', 0, '', InvtId, InvtMult = Case When Qty < 0 Then -1 Else 1 End,
                        '', 'IN', 0, 0, '', 0, GetDate(), '1058000', USER_NAME(), 0, 0, 0, '', '', '', '', '', '',
                        Qty =Case When Qty < 0 Then (Qty * -1) Else Qty End, 0, '', '', '', '', 1, '', '', 0, 0,
                        0, 0, GetDate(), GetDate(), 0, 0, '', '', 0, SiteId, '', '', '', '', '', '', Cost, '', '',
                        'AB', '', '', 0, '', '', 0, 0, '', '', GetDate(), GetDate(), WhseLoc
                From #IN10580_Wrk

    Delete from INArchTran
        Where Rlsed = 1
          And PerPost <= @Archive_PerPost
          And Cpnyid = @Cpnyid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_INTran] TO [MSDSL]
    AS [dbo];

