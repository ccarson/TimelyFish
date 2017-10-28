 /****** Object:  Stored Procedure dbo. Build_AB_INTran Script Date: 4/17/98 10:58:16 AM ******/
Create Proc Build_AB_INTran as

     Create Table #Wrk10990A (
            InvtId Character ( 30),
            Qty Float,
            SiteId Character ( 10),
            WhseLoc Character ( 10))

    Create Table #Wrk10990B (
            InvtId Character ( 30),
            Qty Float,
            SiteId Character ( 10),
            WhseLoc Character ( 10))

    Insert Into #Wrk10990A (InvtId, Qty, Siteid, WhseLoc)
        Select InvtId,
               Qty = Case(DrCr)
                    When 'C' Then Sum(Qty * -1)
                    Else Sum(Qty)
               End,
               SiteId,
               WhseLoc
               From INTran
               Where Qty <> 0
               Group by DrCr, InvtId, SiteId, WhseLoc
        Union
        Select InvtId,
               QtyOnHand,
               SiteId,
               WhseLoc
               From Location

    Insert Into #Wrk10990B (InvtId, Qty, Siteid, WhseLoc)
        Select InvtId,
               Sum(Qty),
               SiteId,
               WhseLoc
               From #Wrk10990A
               Group by InvtId, SiteId, WhseLoc

    Delete INTran from INTran
        where TranType = 'AB'

    Insert Into INTran     (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate, BMIExtCost,
                            BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct, KitID,
                            CnvFact, COGSAcct, COGSSub, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, Excpt,
                            ExtCost, ExtRefNbr, FiscYr, Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub, JrnlType, LineId, LineNbr,
                            LineRef, LotSerCntr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, OvrhdAmt, Ovrhdflag, PC_Flag, PC_ID,
                            PC_Status, PerEnt, PerPost, ProjectID, Qty, QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr,
                            Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
                            S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ShortQty, SiteId, SlsperId,
                            SpecificCostId, Sub, TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc, TranType,
                            UnitDesc, UnitMultDiv, UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8,WhseLoc)
        Select '', 0, 0, '', '000000', '', '', 0, '', 0, '', 0, 0, 0, '', 0, Space(1),Space(1),'', Site.CpnyID,
                   GetDate(), '1099000', USER_NAME(), DrCr = Case When Qty < 0 Then 'C' Else 'D' End,
                   0, 0, '', '', '', 0, '',InvtId, 1, '', 'IN', 0, 0, '', 0, GetDate(), '1099000', USER_NAME(), 0, 0, 0, '', '', '',
                   '', '', '', Qty, 0, '', '', '', '', 0, '','',0,0,0,0,'','',0,0,'','',0, #Wrk10990B.SiteId, '', '', '', '', '', '', 0,
                   '', '', 'AB', '', '', 0, '', '', 0, 0, '','','','',WhseLoc
               From #Wrk10990B, Site
               Where #Wrk10990B.SiteId = Site.SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Build_AB_INTran] TO [MSDSL]
    AS [dbo];

