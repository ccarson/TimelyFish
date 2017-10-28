 Create Proc Restore_INTran
    @parm1 varchar ( 6),	-- Period to Restore from
    @Parm2 varchar (10)		-- Company Id
as

    Create Table #IN10580A_Wrk (
            CpnyId Character ( 10),
            DrCr Character ( 1),
            InvtId Character ( 30),
            Qty Float,
            SiteId Character ( 10),
            WhseLoc Character ( 10))

    Create Table #IN10580B_Wrk (
            CpnyId Character ( 10),
            DrCr Character ( 1),
            InvtId Character ( 30),
            Qty Float,
            SiteId Character ( 10),
            WhseLoc Character ( 10))

    Insert Into #IN10580A_Wrk (CpnyId, DrCr, InvtId, Qty, Siteid, WhseLoc)
        Select CpnyId,
               DrCr,
               InvtId,
               Qty = Case(DrCr)
                    When 'C' Then Sum(Qty)
                    When 'D' Then Sum(Qty * -1)
               End,
               SiteId,
               WhseLoc
               From INArchTran
               Where Qty <> 0
                 And PerPost >= @parm1
                 And Cpnyid = @Parm2
               Group by CpnyId, DrCr, InvtId, SiteId, WhseLoc
        Union
        Select CpnyId,
               DrCr,
               InvtId,
               Qty = Case(DrCr)
                    When 'C' Then Sum(Qty * -1)
                    When 'D' Then Sum(Qty)
               End,
               SiteId,
               WhseLoc
               From INTran
               Where TranType = 'AB'
                 And Cpnyid = @Parm2
               Group by CpnyId, DrCr, InvtId, SiteId, WhseLoc

    Truncate Table #IN10580B_Wrk

    Insert Into #IN10580B_Wrk (CpnyId, DrCr, InvtId, Qty, Siteid, WhseLoc)
        Select CpnyId,
               DrCr = Case When Sum(Qty) >= 0
                         Then 'D'
                         Else 'C'
                      End,
               InvtId,
               Qty = Case When Sum(Qty) >= 0
                          Then Sum(Qty)
                          Else (Sum(Qty)* -1 )
                     End,
               SiteId,
               WhseLoc
               From #IN10580A_Wrk
               Group by CpnyId, InvtId, SiteId, WhseLoc

    Insert Into INTran     (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate, BMIExtCost,
                            BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct,
                            CnvFact, COGSAcct, COGSSub, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, Excpt,
                            ExtCost, ExtRefNbr, FiscYr, Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub, JrnlType, KitID, KitStdQty,
			    LayerType, LineId, LineNbr,
                            LineRef, LotserCntr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, OrigBatNbr, OrigJrnlType,
			    OrigLineRef, OrigRefNbr, OvrhdAmt, OvrhdFlag, PC_Flag, PC_ID, PC_Status,
                            PerEnt, PerPost, PostingOption, ProjectID, Qty, QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr, Retired,
                            Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
                            S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ShortQty, SiteId, SlsperId, SpecificCostID, StdTotalQty, Sub,
                            TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc, TranType, UnitCost, UnitDesc, UnitMultDiv,
                            UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, UseTranCost, WhseLoc)
    Select Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate, BMIExtCost,
                            BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct,
                            CnvFact, COGSAcct, COGSSub, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, Excpt,
                            ExtCost, ExtRefNbr, FiscYr, Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub, JrnlType, KitID, KitStdQty,
			    LayerType = Case When LayerType = '' Then 'S' Else LayerType End, LineId, LineNbr,
                            LineRef, LotserCntr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, OrigBatNbr, OrigJrnlType,
			    OrigLineRef, OrigRefNbr, OvrhdAmt, OvrhdFlag, PC_Flag, PC_ID, PC_Status,
                            PerEnt, PerPost, PostingOption, ProjectID, Qty, QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr, Retired,
                            Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
                            S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ShortQty, SiteId, SlsperId, SpecificCostID, StdTotalQty, Sub,
                            TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc, TranType, UnitCost, UnitDesc, UnitMultDiv,
                            UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, UseTranCost, WhseLoc
               From InArchTran
               where PerPost >= @parm1
                 And Cpnyid = @Parm2

    Delete INTran from INTran
        where TranType = 'AB'
          And Cpnyid = @Parm2

    Insert Into INTran     (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate, BMIExtCost,
                            BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct,
                            CnvFact, COGSAcct, COGSSub, CostType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, Excpt,
                            ExtCost, ExtRefNbr, FiscYr, Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub, JrnlType, KitID, KitStdQty,
		            LayerType, LineId, LineNbr,
                            LineRef, LotserCntr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID, OrigBatNbr, OrigJrnlType,
			    OrigLineRef, OrigRefNbr, OvrhdAmt, OvrhdFlag, PC_Flag, PC_ID, PC_Status,
                            PerEnt, PerPost, PostingOption, ProjectID, Qty, QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr, Retired,
                            Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
                            S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ShortQty, SiteId, SlsperId, SpecificCostID, StdTotalQty, Sub,
                            TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc, TranType, UnitDesc, UnitMultDiv,
                            UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, UseTranCost, WhseLoc)
        Select '', 0, 0, '', '000000', '', '', 0,
			    '', 0, '', 0, 0, 0,
			    0, Space(1),Space(1), '', Site.CpnyID, GetDate(), '1099000', USER_NAME(), DrCr = Case When Qty < 0 Then 'C' Else 'D' End, 0,
                   	    0, '', '', '', 0, ' ', InvtId, 1, ' ', 'IN', '', 0,
			    'S', 0, 0,
			    '', 0, GetDate(), '1058000', USER_NAME(), 0, '', '',
			    '', '', 0, 0, '', '', '',
                   	    '', '', '', '', Qty, 0, '', '', '', '', '',
			    0, ' ', ' ', 0, 0, 0, 0, GetDate(),
			    GetDate(), 0, 0, ' ', ' ', 0, #IN10580B_Wrk.SiteId, '', '', 0, '',
			    '', '', '', 0, '', '', 'AB', '', '',
			    0, '', '', 0, 0, ' ', ' ', GetDate(), GetDate(), 0, WhseLoc
               From #IN10580B_Wrk, Site
               Where #IN10580B_Wrk.SiteId = Site.SiteId

    Delete INArchTran from INArchTran
        where PerPost >= @parm1
          And Cpnyid = @Parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Restore_INTran] TO [MSDSL]
    AS [dbo];

