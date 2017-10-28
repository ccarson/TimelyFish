 Create Proc pp_10530_Process
            @UserAddress VARCHAR (21),
            @CpnyId VARCHAR (10),
            @Module VARCHAR (10),
            @ProgName VARCHAR (8),
            @UserName VARCHAR (10),
            @AllItems VARCHAR (1),
            @SelectionOption VARCHAR (1),
            @RevalINTran VARCHAR (1),
            @RevalEffDate SmallDateTime
As

	Set	NoCount On

	Declare	@BaseDecPl	SmallInt,
		@BMIDecPl	SmallInt,
		@DecPlPrcCst	SmallInt,
		@DecPlQty	SmallInt

	Select	@BaseDecPl = BaseDecPl,
		@BMIDecPl = BMIDecPl,
		@DecPlPrcCst = DecPlPrcCst,
		@DecPlQty = DecPlQty
		From	vp_DecPl (NoLock)

    DECLARE @BatNbr          CHAR(10)
    DECLARE @BatNbrLen       Int
    DECLARE @Batch_Created   CHAR(1)
    DECLARE @Process_Flag    CHAR(1)
    DECLARE @FiscYr          CHAR(4)
    DECLARE @PerNbr          CHAR(6)
    DECLARE @MatlOvhCalc     CHAR(1)
    DECLARE @DfltInvtAcct    CHAR(10)
    DECLARE @DfltInvtSub     CHAR(24)
    DECLARE @StdCstRevalAcct CHAR(10)
    DECLARE @StdCstRevalSub  CHAR(24)
    DECLARE @CtrlTot         Float
    DECLARE @CrTot           Float
    DECLARE @DrTot           Float
    DECLARE @RecordCount     Int
    DECLARE @ErrorFlag       CHAR(1)
    DECLARE @BMIEnabled      VarChar(1)

/*	Since the IN10530_Return table does not have a CpnyID field, we will use
	ErrorInvtID for now.  This field is not populated by any of the 10530 routines
*/
	DELETE 	FROM IN10530_Return
		WHERE	ComputerName = @UserAddress
			OR DateAdd(Day,2,Crtd_DateTime) < getdate()

	Select @BatNbr = '', @Batch_Created = '0', @Process_Flag = '0', @ErrorFlag = ''

	Select	@DfltInvtAcct    = DfltInvtAcct,
		@DfltInvtSub     = DfltInvtSub,
		@PerNbr          = PerNbr,
		@MatlOvhCalc     = MatlOvhCalc,
		@StdCstRevalAcct = StdCstRevalAcct,
		@StdCstRevalSub  = StdCstRevalSub,
		@BMIEnabled      = BMIEnabled
		From	INSetup (NoLock)

    BEGIN TRANSACTION

--  Process Inventory Revaluation and ItemSite Cost Updates

    IF @SelectionOption = 'P'
        Begin
            Exec pp_10530_ProductClass @UserAddress, @ProgName, @UserName, @AllItems, @Process_Flag, @ErrorFlag
            IF @@ERROR <> 0 OR @ErrorFlag = 'Y' GOTO ABORT
            COMMIT TRANSACTION
            Goto Finish
        End

    Select @FiscYr = SUBSTRING(@PerNbr,1,4)

    CREATE TABLE #Wrk10530A (
            Acct                 char (10),
            AcctDist             smallint,
            ARLineId             int,
            ARLineRef            char (5),
            BatNbr               char (10),
            BMICuryID            char (4),
            BMIEffDate           smalldatetime,
            BMIExtCost           float,
            BMIMultDiv           char (1),
            BMIRate              float,
            BMIRtTp              char (6),
            BMITranAmt           float,
            BMIUnitPrice         float,
            CmmnPct              float,
            CmpnentId            char (30),
            CnvFact              float,
            CostType             char (8),
            CpnyID               char (10),
            DrCr                 char (1),
            Excpt                smallint,
            ExtCost              float,
            ExtRefNbr            char (15),
            FiscYr               char (4),
            Id                   char (10),
            InsuffQty            smallint,
            InvtAcct             char (10),
            InvtId               char (30),
            InvtMult             smallint,
            InvtSub              char (24),
            JrnlType             char (3),
	LayerType		Char(1),
            LineId               int,
            LineNbr              smallint,
            LineRef              char (5),
            NoteID               int,
            PC_Flag              char (1),
 PC_ID                char (20),
            PC_Status            char (1),
            PerEnt               char (6),
            PerPost              char (6),
            ProjectID            char (16),
            Qty                  float,
            QtyUnCosted          float,
            RcptDate             smalldatetime,
            RcptNbr              char (10),
            ReasonCd             char (6),
            RecordID             int identity(1,1),
            RefNbr               char (10),
            Rlsed                smallint,
            S4Future01           char (30),
            S4Future02           char (30),
            S4Future03           float,
            S4Future04           float,
            S4Future05           float,
            S4Future06           float,
            S4Future07           smalldatetime,
            S4Future08           smalldatetime,
            S4Future09           int,
            S4Future10           int,
            S4Future11           char (10),
            S4Future12           char (10),
            ShortQty             float,
            SiteId               char (10),
            SlsperId             char (10),
            SpecificCostID       char (25),
            Sub                  char (24),
            TaskID               char (32),
            ToSiteID             char (10),
            ToWhseLoc            char (10),
            TranAmt              float,
            TranDate             smalldatetime,
            TranDesc             char (30),
            TranType             char (2),
            UnitDesc             char (6),
            UnitMultDiv          char (1),
            UnitPrice            float,
            User1                char (30),
            User2                char (30),
            User3                float,
            User4                float,
            User5                char (10),
            User6                char (10),
            User7                smalldatetime,
            User8                smalldatetime,
            WhseLoc              char (10),
            Wrk_Qty              Float,
            Wrk_TranAmt          Float,
            Wrk_BMITranAmt       Float,
            tstamp timestamp)
    IF @@ERROR <> 0 GOTO ABORT

    CREATE TABLE #Wrk10530A_Sum (
            InvtId               Char ( 30),
            SiteId               Char ( 10),
	LayerType		Char(1),
            TranAmt              float,
            BMITranAmt           float,
            tstamp timestamp)
    IF @@ERROR <> 0 GOTO ABORT

    CREATE TABLE #Wrk10530B (
            Acct                 Char ( 10),
            DrCr                 Char (  1),
            InvtId               Char ( 30),
            InvtAcct             Char ( 10),
            InvtSub              Char ( 24),
            RevalAmt             Float,
            BMIRevalAmt          Float,
            RecordCount          Int Identity(1,1),
            SiteId               Char ( 10),
            Sub                  Char ( 24),
            TranType             Char (  2),
	    UnitCost		 Float,
            UnitDesc             Char (  6),
            WhseLoc              char (10))
    IF @@ERROR <> 0 GOTO ABORT

--  Create Revalue Inventory Transactions Records
    IF @RevalINTran <> '0'              -- Revalue Inventory Transactions
        BEGIN
            IF @AllItems <> '0'      -- All Items
                BEGIN
                    INSERT #Wrk10530A (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate,
                                       BMIExtCost, BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice,
                                       CmmnPct, CmpnentId, CnvFact, CostType, CpnyID, DrCr, Excpt, ExtCost,
                                       ExtRefNbr, FiscYr, Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub,
                                       JrnlType, LayerType, LineId, LineNbr, LineRef, NoteID,
                                       PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty,
                                       QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr, Rlsed,
                                       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
                                       S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
                                       S4Future11, S4Future12, ShortQty, SiteId, SlsperId, SpecificCostID,
                                       Sub, TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc,
                                       TranType, UnitDesc, UnitMultDiv, UnitPrice, User1, User2, User3,
                                       User4, User5, User6, User7, User8, WhseLoc, Wrk_Qty, Wrk_TranAmt,
                                       Wrk_BMITranAmt)
                         Select T.Acct, T.AcctDist, T.ARLineId, T.ARLineRef, @BatNbr, T.BMICuryID, T.BMIEffDate,
                                T.BMIExtCost, T.BMIMultDiv, T.BMIRate, T.BMIRtTp,
                                BMITranAmt = Case When @BMIEnabled = 1
                                                  Then CASE When @MatlOvhCalc = 'R'
                                                       Then Case When S.BMIStdCost Is Not Null And S.BMIStdCost <> 0
                                                                      Then Case When S.BMIPStdCst Is Not Null And S.BMIPStdCst <> 0
                                                                                     Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * S.BMIPStdCst)
                                                                                          - (Round(T.Qty * T.CnvFact, @DecPlQty) * S.BMIStdCost)), @BMIDecPl)
                                                                                     Else 0
                                                                           End
                                                                 When I.BMIStdCost Is Not Null And I.BMIStdCost <> 0
                                                                      Then Case When I.BMIPStdCost Is Not Null And I.BMIPStdCost <> 0
                                                                                     Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * I.BMIPStdCost)
                                                                                          - (Round(T.Qty * T.CnvFact, @DecPlQty) * I.BMIStdCost)), @BMIDecPl)
                                                                                     Else 0
                                                                           End
                                                                      Else 0
                                                            End
                                                       Else Case When S.BMIDirStdCst Is Not Null And S.BMIDirStdCst <> 0
                                                                      Then Case When S.BMIPDirStdCst Is Not Null And S.BMIPDirStdCst <> 0
                                                                                     Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * S.BMIPDirStdCst)
                                                                                          - (Round(T.Qty * T.CnvFact, @DecPlQty) * S.BMIDirStdCst)), @BMIDecPl)
                                                                                     Else 0
                                                                           End
                                                                 When I.BMIDirStdCost Is Not Null And I.BMIDirStdCost <> 0
                                                                      Then Case When I.BMIPDirStdCost Is Not Null And I.BMIPDirStdCost <> 0
                                                                              Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * I.BMIPDirStdCost)
                                                                                          - (Round(T.Qty * T.CnvFact, @DecPlQty) * I.BMIDirStdCost)), @BMIDecPl)
                                                                                     Else 0
                                                                           End
                                                                      Else 0
                                                            End
                                                       End
                                                  Else 0
                                             END,
                                T.BMIUnitPrice, T.CmmnPct, T.KitID, T.CnvFact, T.CostType, T.CpnyID, T.DrCr, T.Excpt,
                                T.ExtCost, T.ExtRefNbr, T.FiscYr, T.Id, T.InsuffQty, T.InvtAcct, T.InvtId, T.InvtMult,
                                T.InvtSub, T.JrnlType, T.LayerType, T.LineId, T.LineNbr, T.LineRef, T.NoteID, T.PC_Flag, T.PC_ID,
                                T.PC_Status, T.PerEnt, T.PerPost, T.ProjectID, 0, 0, T.RcptDate, T.RcptNbr, T.ReasonCd,
                                T.RefNbr, 0, T.S4Future01, T.S4Future02, T.S4Future03,
				S4Future04 = COALESCE(S.PStdCst, 0),
                                T.S4Future05, T.S4Future06, T.S4Future07, T.S4Future08, T.S4Future09, T.S4Future10, T.S4Future11,
                                T.S4Future12, 0, T.SiteId, T.SlsperId, T.SpecificCostID, T.Sub, T.TaskID, T.ToSiteID, T.ToWhseLoc,
                                TranAmt = CASE When @MatlOvhCalc = 'R'
                                                   Then Case When S.StdCost Is Not Null And S.StdCost <> 0
                                                                 Then Case When S.PStdCst Is Not Null And S.PStdCst <> 0
                                                                               Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * S.PStdCst)
                                                                                    - (Round(T.Qty * T.CnvFact, @DecPlQty) * S.StdCost)), @BaseDecPl)
                                                                           Else 0
                                                                      End
                                                             When I.StdCost Is Not Null And I.StdCost <> 0
                                                                 Then Case When I.PStdCost Is Not Null And I.PStdCost <> 0
                                                                               Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * I.PStdCost)
                                                                                    - (Round(T.Qty * T.CnvFact, @DecPlQty) * I.StdCost)), @BaseDecPl)
                                                                           Else 0
                                                                      End
                                                             Else 0
                                                        End
                                                   Else Case When S.DirStdCst Is Not Null And S.DirStdCst <> 0
                                                                 Then Case When S.PDirStdCst Is Not Null And S.PDirStdCst <> 0
                                                                               Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * S.PDirStdCst)
                                                                                    - (Round(T.Qty * T.CnvFact, @DecPlQty) * S.DirStdCst)), @BaseDecPl)
                                                                           Else 0
                                                                      End
                                                When I.DirStdCost Is Not Null And I.DirStdCost <> 0
                                                                 Then Case When I.PDirStdCost Is Not Null And I.PDirStdCost <> 0
                                                                               Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * I.PDirStdCost)
                                                                                    - (Round(T.Qty * T.CnvFact, @DecPlQty) * I.DirStdCost)), @BaseDecPl)
                                                                           Else 0
                                                                      End
                                                             Else 0
                                                        End
                                          END,
                                T.TranDate, T.TranDesc, T.TranType, T.UnitDesc, T.UnitMultDiv, T.UnitPrice, T.User1,
                                T.User2, T.User3, T.User4, T.User5, T.User6, T.User7, T.User8, T.WhseLoc, 0, 0, 0
			From	INTran T (NoLock) Inner Join ItemSite S (NoLock)
				On T.InvtID = S.InvtID
				And T.SiteID = S.SiteID
				Inner Join Inventory I (NoLock)
				On I.InvtID = T.InvtID
                            WHERE T.CpnyID = @CpnyID
			      AND T.Qty <> 0
                              AND T.Rlsed = 1
			      AND T.LayerType = 'S'
                              AND T.TranDate >= @RevalEffDate
                              AND I.Valmthd = 'T'

                    IF @@ERROR <> 0 GOTO ABORT

                END
            ELSE       -- Selected Items
                BEGIN
                    INSERT #Wrk10530A (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate, BMIExtCost,
                                       BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice, CmmnPct, CmpnentId, CnvFact,
                                       CostType, CpnyID, DrCr, Excpt, ExtCost, ExtRefNbr, FiscYr, Id, InsuffQty, InvtAcct,
                                       InvtId, InvtMult, InvtSub, JrnlType, LayerType, LineId, LineNbr, LineRef, NoteID, PC_Flag,
                                       PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, QtyUnCosted, RcptDate, RcptNbr,
                                       ReasonCd, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
                                       S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                                       ShortQty, SiteId, SlsperId, SpecificCostID, Sub, TaskID, ToSiteID, ToWhseLoc, TranAmt,
                                       TranDate, TranDesc, TranType, UnitDesc, UnitMultDiv, UnitPrice, User1, User2, User3,
                                       User4, User5, User6, User7, User8, WhseLoc, Wrk_Qty, Wrk_TranAmt, Wrk_BMITranAmt)
                         Select T.Acct, T.AcctDist, T.ARLineId, T.ARLineRef, @BatNbr, T.BMICuryID, T.BMIEffDate,
                                T.BMIExtCost, T.BMIMultDiv, T.BMIRate, T.BMIRtTp,
                                BMITranAmt = Case When @BMIEnabled = 1 Then
                                                  CASE When @MatlOvhCalc = 'R'
                                                       Then Case When S.BMIStdCost Is Not Null And S.BMIStdCost <> 0
                                                                     Then Case When S.BMIPStdCst Is Not Null And S.BMIPStdCst <> 0
                                                                                    Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * S.BMIPStdCst)
                                                                                         - (Round(T.Qty * T.CnvFact, @DecPlQty) * S.BMIStdCost)), @BMIDecPl)
                                                                                    Else 0
                                                                         End
                                                                When I.BMIStdCost Is Not Null And I.BMIStdCost <> 0
                                                                     Then Case When I.BMIPStdCost Is Not Null And I.BMIPStdCost <> 0
                                                                                    Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * I.BMIPStdCost)
                                                                                         - (Round(T.Qty * T.CnvFact, @DecPlQty) * I.BMIStdCost)), @BMIDecPl)
                                                                                    Else 0
                                                                          End
                                                                     Else 0
                                                           End
                                                       Else Case When S.BMIDirStdCst Is Not Null And S.BMIDirStdCst <> 0
                                                                     Then Case When S.BMIPDirStdCst Is Not Null And S.BMIPDirStdCst <> 0
                                                                                    Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * S.BMIPDirStdCst)
                                                                                         - (Round(T.Qty * T.CnvFact, @DecPlQty) * S.BMIDirStdCst)), @BMIDecPl)
                                                                                    Else 0
                                                                          End
                                                                When I.BMIDirStdCost Is Not Null And I.BMIDirStdCost <> 0
                                                                     Then Case When I.BMIPDirStdCost Is Not Null And I.BMIPDirStdCost <> 0
                                                                                    Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * I.BMIPDirStdCost)
                                                                                         - (Round(T.Qty * T.CnvFact, @DecPlQty) * I.BMIDirStdCost)), @BMIDecPl)
                                                                                    Else 0
                                                                          End
                                                                Else 0
                                                           End
                                                  End
                                                Else 0
                                             END,
                                T.BMIUnitPrice, T.CmmnPct, T.KitID, T.CnvFact, T.CostType, T.CpnyID, T.DrCr, T.Excpt,
                                T.ExtCost, T.ExtRefNbr, T.FiscYr, T.Id, T.InsuffQty, T.InvtAcct, T.InvtId, T.InvtMult,
                                T.InvtSub, T.JrnlType, T.LayerType, T.LineId, T.LineNbr, T.LineRef, T.NoteID, T.PC_Flag, T.PC_ID,
                                T.PC_Status, T.PerEnt, T.PerPost, T.ProjectID, 0, 0, T.RcptDate, T.RcptNbr, T.ReasonCd,
                                T.RefNbr, 0, T.S4Future01, T.S4Future02, T.S4Future03,
				S4Future04 = COALESCE(S.PStdCst, 0),
                                T.S4Future05, T.S4Future06, T.S4Future07, T.S4Future08, T.S4Future09, T.S4Future10, T.S4Future11,
                                T.S4Future12, 0, T.SiteId, T.SlsperId, T.SpecificCostID, T.Sub, T.TaskID, T.ToSiteID, T.ToWhseLoc,
                                TranAmt = CASE When @MatlOvhCalc = 'R'
                                                   Then Case When S.StdCost Is Not Null And S.StdCost <> 0
                                                                 Then Case When S.PStdCst Is Not Null And S.PStdCst <> 0
                                                Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * S.PStdCst)
                                                                                    - (Round(T.Qty * T.CnvFact, @DecPlQty) * S.StdCost)), @BaseDecPl)
                                                                               Else 0
                                                                      End
                                                             When I.StdCost Is Not Null And I.StdCost <> 0
                                                                 Then Case When I.PStdCost Is Not Null And I.PStdCost <> 0
                                                                               Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * I.PStdCost)
                                                                                    - (Round(T.Qty * T.CnvFact, @DecPlQty) * I.StdCost)), @BaseDecPl)
                                                                               Else 0
                                                                      End
                                                             Else 0
                                                        End
                                                   Else Case When S.DirStdCst Is Not Null And S.DirStdCst <> 0
                                                                 Then Case When S.PDirStdCst Is Not Null And S.PDirStdCst <> 0
                                                                               Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * S.PDirStdCst)
                                                                                    - (Round(T.Qty * T.CnvFact, @DecPlQty) * S.DirStdCst)), @BaseDecPl)
                                                                               Else 0
                                                                      End
                                                             When I.DirStdCost Is Not Null And I.DirStdCost <> 0
                                                                 Then Case When I.PDirStdCost Is Not Null And I.PDirStdCost <> 0
                                                                               Then Round(((Round(T.Qty * T.CnvFact, @DecPlQty) * I.PDirStdCost)
                                                                                    - (Round(T.Qty * T.CnvFact, @DecPlQty) * I.DirStdCost)), @BaseDecPl)
                                                                               Else 0
                                                                      End
                                                             Else 0
                                                        End
                                           END,
                                T.TranDate, T.TranDesc, T.TranType, T.UnitDesc, T.UnitMultDiv, T.UnitPrice, T.User1,
                                T.User2, T.User3, T.User4, T.User5, T.User6, T.User7, T.User8, T.WhseLoc, 0, 0, 0
			From	INTran T (NoLock) Inner Join ItemSite S (NoLock)
				On T.InvtID = S.InvtID
				And T.SiteID = S.SiteID
				Inner Join Inventory I (NoLock)
				On I.InvtID = T.InvtID
				Inner Join IN10530_Wrk W
				On T.InvtID = W.InvtID
			Where	T.CpnyID = @CpnyID
				And T.Qty <> 0
				And T.LayerType = 'S'
				And T.Rlsed = 1
				AND T.TranDate >= @RevalEffDate
				And I.Valmthd = 'T'
				And @UserAddress = W.ComputerName

                    IF @@ERROR <> 0 GOTO ABORT
                END

                DELETE From #Wrk10530A
                   Where TranAmt = 0

                UPDATE #WRK10530A
                       SET DrCr = Case When TranAmt <  0 Then 'C' Else 'D' End,
                           Wrk_Qty = Case When TranType IN ('CG', 'CT', 'AS') Then  (-1 * Round(Qty * CnvFact, @DecPlQty)) Else Round(Qty * CnvFact, @DecPlQty) End,
                           Wrk_TranAmt = Case When TranType IN ('CG', 'CT', 'AS') Then  (-1 * TranAmt) Else TranAmt End,
                           Wrk_BMITranAmt = Case When TranType IN ('CG', 'CT', 'AS') Then  (-1 * BMITranAmt) Else BMITranAmt End
               IF @@ERROR <> 0 GOTO ABORT
                Insert #Wrk10530A_Sum (InvtId, SiteId, LayerType, TranAmt, BMITranAmt)
                      Select InvtId, SiteId, LayerType,
                             TranAmt = SUM(Wrk_TranAmt),
                             BMITranAmt = SUM(Wrk_BMITranAmt)
                        FROM #Wrk10530A
                        GROUP BY InvtId, SiteId, LayerType
               IF @@ERROR <> 0 GOTO ABORT

        END

--  Create ItemSite Revalue Records
    IF @AllItems <> '0' -- All Items
        BEGIN
            INSERT #Wrk10530B (Acct, DrCr, InvtId, InvtAcct, InvtSub, RevalAmt, BMIRevalAmt,
                               SiteId, Sub, TranType, UnitCost, UnitDesc, WhseLoc)
                Select Case When LTRIM(S.InvtAcct) = '' Or LTRIM(S.InvtAcct) is Null
                                 THEN Case When LTRIM(I.InvtAcct) = '' Or LTRIM(I.InvtAcct) is Null
                                                THEN @DfltInvtAcct
                                                ELSE I.InvtAcct
                                      END
                                 ELSE S.InvtAcct
                       END,
                       'D',
                       S.InvtId,
                       @StdCstRevalAcct,
                       @StdCstRevalSub,
                       CASE WHEN @SelectionOption = 'I'
                            Then CASE When S.PStdCst <> 0
                                      Then CASE When @MatlOvhCalc = 'R'
                                             Then Round(((L.QtyOnHand * S.PStdCst) - Case When S.QtyOnHand <> 0
                                                                                             Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                             Else 0
                                                                                             End)
                                                                                             , @BaseDecPl)
                                                ELSE Round(((L.QtyOnHand * S.PDirStdCst) - Case When S.QtyOnHand <> 0
                                                                                             Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                             Else 0
                                                                                             End)
                                                                                             , @BaseDecPl)
                                                END
                                      ELSE 0
                                      END
                            ELSE CASE When @MatlOvhCalc = 'R'
					 Then Round(((L.QtyOnHand * S.StdCost) - Case When S.QtyOnHand <> 0
                                                                                             Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                             Else 0
                                                                                             End)
                                                                                             , @BaseDecPl)
					 ELSE Round(((L.QtyOnHand * S.DirStdCst) - Case When S.QtyOnHand <> 0
                                                                                             Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                             Else 0
                            End)
                                                                                             , @BaseDecPl)
                                     END
                            END,
                       Case When @BMIEnabled = 1
                            Then CASE WHEN @SelectionOption = 'I'
                                      Then CASE When S.BMIPStdCst <> 0
                                                Then CASE When @MatlOvhCalc = 'R'
							      Then Round(((L.QtyOnHand * S.BMIPStdCst)- Case When S.QtyOnHand <> 0
                                                                                                             Then ((S.BMITotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                                             Else 0
                                                                                                             End)
                                                                                                             , @BMIDecPl)
							      ELSE Round(((L.QtyOnHand * S.BMIPDirStdCst) - Case When S.QtyOnHand <> 0
                                                                                                             Then ((S.BMITotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                                             Else 0
                                                                                                             End)
                                                                                                             , @BMIDecPl)
                                                     END
                                                ELSE 0
                                           END
                                      ELSE CASE When @MatlOvhCalc = 'R'
						    Then Round(((L.QtyOnHand * S.BMIStdCost) - Case When S.QtyOnHand <> 0
                                                                                                    Then ((S.BMITotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                                    Else 0
                                                                                                    End)
                                                                                                    , @BMIDecPl)
						    ELSE Round(((L.QtyOnHand * S.BMIDirStdCst) - Case When S.QtyOnHand <> 0
                                                                                                    Then ((S.BMITotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                                    Else 0
                                                                                                    End)
                                                                                                    , @BMIDecPl)
                                           END
                                 End
                            Else 0
                       END,
                       S.SiteId,
                       Case When LTRIM(S.InvtSub) = '' Or LTRIM(S.InvtSub) is Null
                                 THEN Case When LTRIM(I.InvtSub) = '' Or LTRIM(I.InvtSub) is Null
                                                THEN @DfltInvtSub
                                                ELSE I.InvtSub
                                      END
                                 ELSE S.InvtSub
                       END,
                       'AC',
                       S.PStdCst, I.StkUnit,L.WhseLoc
		From	ItemSite S (NoLock) Join Inventory I (NoLock)
			On S.InvtId = I.InvtID
			Left Outer Join Location L (NoLock)
			On S.InvtId = L.InvtID
			And S.SiteId = L.SiteID
		Where	S.InvtId = I.InvtId
			And S.CpnyID = @CpnyID
			And I.ValMthd = 'T'
			And (CASE WHEN @SelectionOption = 'I'
                              Then CASE When S.PStdCst <> 0
                                        Then CASE When @MatlOvhCalc = 'R'
                                                  Then Round(((L.QtyOnHand * S.PStdCst) - Case When S.QtyOnHand <> 0
                                                                                               Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                               Else 0
                                                                                               End)
                                                                                               , @BaseDecPl)
                                                  ELSE Round(((L.QtyOnHand * S.PDirStdCst) - Case When S.QtyOnHand <> 0
                                                                                               Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                               Else 0
                                                                                               End)
                                                                                               , @BaseDecPl)
                                                  END
                                        ELSE 0
                                        END
                              ELSE CASE When @MatlOvhCalc = 'R'
                                     Then Round(((L.QtyOnHand * S.StdCost) - Case When S.QtyOnHand <> 0
                                                                                  Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                  Else 0
                                                                                  End)
                                                                                  , @BaseDecPl)
                                     ELSE Round(((L.QtyOnHand * S.DirStdCst) - Case When S.QtyOnHand <> 0
                                                                                  Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                  Else 0
                                                                                  End)
                                                                                  , @BaseDecPl)
                                     END
                              END) <> 0
             IF @@ERROR <> 0 GOTO ABORT
        END
    ELSE       -- Selected Items
        BEGIN
            INSERT #Wrk10530B (Acct, DrCr, InvtId, InvtAcct, InvtSub, RevalAmt, BMIRevalAmt,
                            SiteId, Sub, TranType, UnitCost, UnitDesc, WhseLoc)
                Select Case When LTRIM(S.InvtAcct) = '' Or LTRIM(S.InvtAcct) is Null
                                 THEN Case When LTRIM(I.InvtAcct) = '' Or LTRIM(I.InvtAcct) is Null
                                                THEN @DfltInvtAcct
                                                ELSE I.InvtAcct
                                      END
                                 ELSE S.InvtAcct
                       END,
                       'D', S.InvtId, @StdCstRevalAcct, @StdCstRevalSub,
                       CASE WHEN @SelectionOption = 'I'
                            Then CASE When S.PStdCst <> 0
                                      Then CASE When @MatlOvhCalc = 'R'
                                             Then Round(((L.QtyOnHand * S.PStdCst) - Case When S.QtyOnHand <> 0
                                                                                             Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                 Else 0
                                                                                             End)
                                                                                             , @BaseDecPl)
                                                ELSE Round(((L.QtyOnHand * S.PDirStdCst) - Case When S.QtyOnHand <> 0
                                                                                             Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                             Else 0
                                                                                             End)
                                                                                             , @BaseDecPl)
                                                END
                                      ELSE 0
                                      END
                            ELSE CASE When @MatlOvhCalc = 'R'
                                     Then Round(((L.QtyOnHand * S.StdCost) - Case When S.QtyOnHand <> 0
                                                                                  Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                  Else 0
                                                                                  End)
                                                                                  , @BaseDecPl)
                                     ELSE Round(((L.QtyOnHand * S.DirStdCst) - Case When S.QtyOnHand <> 0
                                                                                  Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
                                                                                  Else 0
                                                                                  End)
                                                                                  , @BaseDecPl)
                                     END
                            END,
                       Case When @BMIEnabled = 1
                            Then CASE WHEN @SelectionOption = 'I'
                                      Then CASE When S.BMIPStdCst <> 0
                                                Then CASE When @MatlOvhCalc = 'R'
                                                          Then Round(((L.QtyOnHand * S.BMIPStdCst)- Case When S.QtyOnHand <> 0
                                                                                     			 Then ((S.BMITotCost/S.QtyOnHand) * L.QtyOnHand)
	                                                                                     		 Else 0
                                                                                     			 End)
                                                                                     			 , @BMIDecPl)
                                                          ELSE Round(((L.QtyOnHand * S.BMIPDirStdCst) - Case When S.QtyOnHand <> 0
                                                                                     			 Then ((S.BMITotCost/S.QtyOnHand) * L.QtyOnHand)
	                                                                                     		 Else 0
                                                                                     			 End)
                                                                                     			 , @BMIDecPl)
                                                     END
                                                ELSE 0
                                           END
                                      ELSE CASE When @MatlOvhCalc = 'R'
                                                Then Round(((L.QtyOnHand * S.BMIStdCost) - Case When S.QtyOnHand <> 0
   			 Then ((S.BMITotCost/S.QtyOnHand) * L.QtyOnHand)
	                                                                                     		 Else 0
                                                                                     			 End)
                                                                                     			 , @BMIDecPl)
                                                ELSE Round(((L.QtyOnHand * S.BMIDirStdCst) - Case When S.QtyOnHand <> 0
                                                                                     			 Then ((S.BMITotCost/S.QtyOnHand) * L.QtyOnHand)
	                                                                                     		 Else 0
                                                                                     			 End)
                                                                                     			 , @BMIDecPl)
                                           END
                                 End
                            Else 0
                       END,
                       S.SiteId,
                       Case When LTRIM(S.InvtSub) = '' Or LTRIM(S.InvtSub) is Null
                                 THEN Case When LTRIM(I.InvtSub) = '' Or LTRIM(I.InvtSub) is Null
                                                THEN @DfltInvtSub
                                                ELSE I.InvtSub
                                      END
                                 ELSE S.InvtSub
                       	END,
                       	'AC', S.PStdCst, I.StkUnit, L.WhseLoc
		From	IN10530_Wrk W Inner Join ItemSite S (NoLock)
			On S.InvtID = W.InvtID
			Inner Join Inventory I (NoLock)
			On S.InvtId = I.InvtID
			Left Outer Join Location L (NoLock)
			On S.InvtId = L.InvtID
			And S.SiteId = L.SiteID
		Where	S.InvtId = I.InvtId
			And S.CpnyID = @CpnyID
			And I.ValMthd = 'T'
			And (CASE WHEN @SelectionOption = 'I'
                              Then CASE When S.PStdCst <> 0
                                        Then CASE When @MatlOvhCalc = 'R'
                                                  Then Round(((L.QtyOnHand * S.PStdCst)- Case When S.QtyOnHand <> 0
                                                                                     		Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
	                                                                                     	Else 0
                                                                                     		End)
                                                                                     		, @BaseDecPl)
                                                  ELSE Round(((L.QtyOnHand * S.PDirStdCst)- Case When S.QtyOnHand <> 0
                                                                                     		Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
	                                                                                     	Else 0
                                                                                     		End)
                                                                                     		, @BaseDecPl)
                                                  END
                                        ELSE 0
                                        END
                              ELSE CASE When @MatlOvhCalc = 'R'
                                     Then Round(((L.QtyOnHand * S.StdCost) - Case When S.QtyOnHand <> 0
                                                                                  Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
	                                                                          Else 0
                                                                                  End)
                                                                                  , @BaseDecPl)
                                     ELSE Round(((L.QtyOnHand * S.DirStdCst) - Case When S.QtyOnHand <> 0
                                                                                  Then ((S.TotCost/S.QtyOnHand) * L.QtyOnHand)
	                                                                          Else 0
                                                                                  End)
                                                                                  , @BaseDecPl)
                                     END
                              END) <> 0
                         And @UserAddress = W.ComputerName

            IF @@ERROR <> 0 GOTO ABORT

        END

    IF @RevalINTran <> '0'    -- Effective Date Processing
        BEGIN
--          *** Insert Any Missing Records
            INSERT #Wrk10530B
                   Select Case When LTRIM(S.InvtAcct) = '' Or LTRIM(S.InvtAcct) is Null
                                    THEN Case When LTRIM(I.InvtAcct) = '' Or LTRIM(I.InvtAcct) is Null
                                                   THEN @DfltInvtAcct
                                                   ELSE I.InvtAcct
                                         END
                                    ELSE S.InvtAcct
                          END,
                          'D', T.InvtId, @StdCstRevalAcct, @StdCstRevalSub, 0,0, T.SiteId,
                          Case When LTRIM(S.InvtSub) = '' Or LTRIM(S.InvtSub) is Null
                                    THEN Case When LTRIM(I.InvtSub) = '' Or LTRIM(I.InvtSub) is Null
                                                   THEN @DfltInvtSub
                                                   ELSE I.InvtSub
                                         END
                                    ELSE S.InvtSub
	                  END,
                          'AC', S.PStdCst, I.StkUnit,L.WhseLoc
			From	#Wrk10530A_Sum T Inner Join Inventory I (NoLock)
				On T.InvtId = I.InvtId
				Left Outer Join ItemSite S (NoLock)
				On T.InvtID = S.InvtID
				And T.SiteID = S.SiteID
				Left Outer Join Location L (NoLock)
				On S.InvtId = L.InvtId
				Left Outer Join #Wrk10530B W
				On T.InvtId = W.InvtId
				And T.SiteId = W.SiteId
			Where	W.InvtId Is Null

            IF @@ERROR < > 0 GOTO ABORT

--      *** Back Up #Wrk10530B Balances to Effective Date
            UPDATE B
                   Set B.RevalAmt = A.TranAmt - RevalAmt,
                       B.BMIRevalAmt = A.BMITranAmt - BMIRevalAmt
                   From #Wrk10530B B, #Wrk10530A_Sum A
                   Where B.InvtId = A.InvtId
                     And B.SiteId = A.SiteId
            IF @@ERROR < > 0 GOTO ABORT

        END

--  *** Insert Intrans for Revaluation
    IF @@Identity > 0
        BEGIN
            Select @CtrlTot = 0
            Select @CrTot = 0
            Select @DrTot = 0

            Select @CtrlTot = (@CtrlTot + Abs(RevalAmt)),
                   @CrTot = CASE DrCr When 'C' Then @CrTot + Abs(RevalAmt) Else @CrTot End,
                   @DrTot = CASE DrCr When 'D' Then @DrTot + Abs(RevalAmt) Else @DrTot End
                From #Wrk10530B
            IF @@ERROR <> 0 GOTO ABORT

            IF @RevalINTran <> '0'              -- Revalue Inventory Transactions
                BEGIN
                    Select @CtrlTot = (@CtrlTot + Abs(TranAmt)),
                           @CrTot = CASE DrCr When 'C' Then @CrTot + Abs(TranAmt) Else @CrTot End,
                           @DrTot = CASE DrCr When 'D' Then @DrTot + Abs(TranAmt) Else @DrTot End
                        From #Wrk10530A
                    IF @@ERROR <> 0 GOTO ABORT
                END

            IF @BatNbr = ''
                BEGIN
--              *** Get Next Batch Number
                    Select @BatNbr     = (Select LastBatNbr From INSetup)
                    IF @@ERROR <> 0 GOTO ABORT

                    EXEC CREATE_NEW_BATCH @BatNbr, @Module, @BatNbr Output

                UPDATE INSetup Set LASTBATNBR = @BatNbr
                    IF @@ERROR <> 0 GOTO ABORT

--              *** Create Batch Record
                    UPDATE Batch  Set BatType = 'N',
                                      CpnyId = @CpnyId,
                                      Crtd_DateTime = GetDate(), Crtd_Prog = @ProgName, Crtd_User = @UserName,
                                      CrTot = @CrTot,
                                      CtrlTot = @CtrlTot,
                                      Descr = 'Inventory ReEvaluation',
                                      DrTot = @DrTot,
                                      EditScrnNbr = '10530',
                                      JrnlType = @Module,
                                      LUpd_DateTime = GetDate(), LUpd_Prog = @ProgName, LUpd_User = @UserName,
                                      PerEnt = @PerNbr,
                                      PerPost = @PerNbr,
                                      Status = 'S'
                           From Batch
                           Where BatNbr = @BatNbr
			     and Module = @Module
                    IF @@ERROR <> 0 GOTO ABORT
                    Select @Batch_Created = '1'
            END

--      *** Create INTran Record - For Inventory Revaluation
-- 	*** Default for Insert Can be Removed in 4.1
		Insert	Into INTran
				(Acct, BatNbr, BMITranAmt, CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, FiscYr,
                                InvtAcct, InvtId, InvtSub, JrnlType, LayerType, LineID, LineNbr,
				LineRef, LUpd_DateTime, LUpd_Prog, LUpd_User, PerEnt, PerPost, RefNbr,
				SiteId, Sub, TranAmt, TranDate,
				TranDesc, TranType, UnitDesc, CnvFact, InvtMult, S4Future04, UnitMultDiv, WhseLoc)
			Select	W.Acct, @BatNbr, BMIRevalAmt, S.CpnyID, GetDate(), @ProgName, @UserName, DrCr, @FiscYr,
				InvtAcct, InvtId, InvtSub, 'IN', 'S', RecordCount, (-32768 + RecordCount),
				Right('00000' + Cast (RecordCount as varchar(5)),5), GetDate(), @ProgName, @UserName, @PerNbr, @PerNbr, '10530UPD',
				W.SiteId, Sub, RevalAmt, TranDate = Case When @RevalINTran <> '0' Then @RevalEffDate Else GetDate() End,
                          	InvtID, W.TranType, W.UnitDesc, 1, 1, W.UnitCost, 'M', W.WhseLoc
                      From #Wrk10530B W, Site S
                      Where W.SiteId = S.SiteId
               IF @@ERROR <> 0 GOTO ABORT

--      *** Create INTran Record - For Inventory Transaction Revaluation
               IF @RevalINTran <> '0'              -- Revalue Inventory Transactions
                    BEGIN
                        Select @RecordCount = Max(RecordCount)
                               From #Wrk10530B
                        INSERT INTRAN (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate,
                                           BMIExtCost, BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice,
                                           CmmnPct, KitID, CnvFact, COGSAcct, COGSsub, CostType, CpnyID,
                                           Crtd_DateTime, Crtd_Prog, Crtd_User,
                                           DrCr, Excpt, ExtCost, ExtRefNbr, FiscYr,
                                           Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub, JrnlType, LayerType, LineId,
                                           LineNbr, LineRef, LotserCntr, LUpd_DateTime, LUpd_Prog, LUpd_User,
                                           NoteID, OvrhdAmt, OvrhdFlag,
                                           PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty,
                                           QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr, Rlsed,
                                           S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
                                           S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
                                           S4Future11, S4Future12, ShortQty, SiteId, SlsperId, SpecificCostID,
                                           Sub, TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc,
                                           TranType, UnitDesc, UnitMultDiv, UnitPrice, User1, User2, User3,
                                           User4, User5, User6, User7, User8, WhseLoc)
                              Select T.Acct, T.AcctDist, T.ARLineId, T.ARLineRef, @BatNbr, T.BMICuryID, T.BMIEffDate,
                                     T.BMIExtCost, T.BMIMultDiv, T.BMIRate, T.BMIRtTp, T.BMITranAmt, T.BMIUnitPrice,
                                     T.CmmnPct, T.CmpnentId, T.CnvFact, Space(1), Space(1), T.CostType, T.CpnyID, GetDate(), @ProgName, @UserName,
                                     T.DrCr, T.Excpt, T.ExtCost, T.ExtRefNbr, T.FiscYr, T.Id, T.InsuffQty, T.InvtAcct,
                                     T.InvtId, T.InvtMult, T.InvtSub, T.JrnlType, T.LayerType, T.LineId, (-32768 + @RecordCount + RecordId),
                                     Right('00000' + Cast ((@RecordCount + RecordId) as varchar(5)),5), 0, GetDate(), @ProgName, @UserName, T.NoteID, 0, 0, T.PC_Flag, T.PC_ID, T.PC_Status,
                                     T.PerEnt, T.PerPost,T.ProjectID, Qty, QtyUnCosted, T.RcptDate, T.RcptNbr, T.ReasonCd,
                                     T.RefNbr, Rlsed, T.S4Future01, T.S4Future02, T.S4Future03, T.S4Future04, T.S4Future05,
                                     T.S4Future06, T.S4Future07, T.S4Future08, 1, 1, T.S4Future11,
                                     T.S4Future12, ShortQty, T.SiteId, T.SlsperId, T.SpecificCostID, T.Sub, T.TaskID,
                                     T.ToSiteID, T.ToWhseLoc, T.TranAmt, T.TranDate, T.TranDesc, T.TranType, T.UnitDesc,
                                     T.UnitMultDiv, T.UnitPrice, T.User1, T.User2, T.User3, T.User4, T.User5, T.User6,
                                     T.User7, T.User8, T.WhseLoc
                                  From #WRK10530A T
				  Where T.TranType Not In ('CT','CG')
                    END
        END

--  IF @SelectionOption = 'I'    -- Update Pending Costs
        Begin
        IF @AllItems = '1' -- All Items
            Begin
--          Update the Inventory Record
                Update Inventory
                     Set LastStdCost = StdCost,
                         PStdCostDate = Space (1),
                         StdCostDate = GetDate(),
                         DirStdCost = PDirStdCost,
                         FOvhStdCost = PFOvhStdCost,
                         StdCost = PStdCost,
                         VOvhStdCost = PVOvhStdCost,
                         PDirStdCost = 0,
                         PFOvhStdCost = 0,
                         PStdCost = 0,
                         PVOvhStdCost = 0,
                         BMIDirStdCost = Case When BMIPStdCost <> 0 Then BMIPDirStdCost Else BMIDirStdCost End,
                         BMIFOvhStdCost = Case When BMIPStdCost <> 0 Then BMIPFOvhStdCost Else BMIFOvhStdCost End,
                         BMIVOvhStdCost = Case When BMIPStdCost <> 0 Then BMIPVOvhStdCost Else BMIVOvhStdCost End,
                         BMIStdCost = Case When BMIPStdCost <> 0 Then BMIPStdCost Else BMIStdCost End,
                         BMIPDirStdCost = 0,
                         BMIPFOvhStdCost = 0,
                         BMIPStdCost = 0,
                         BMIPVOvhStdCost = 0,
                         LUpd_DateTime = GetDate(), LUpd_Prog = @ProgName, LUpd_User = @UserName
                    From Inventory
                   Where PStdCost <> 0
                     And ValMthd = 'T'
		     And PstdCostDate <= GetDate()
                IF @@ROWCOUNT <> 0 Select @Process_Flag = '1'
                IF @@ERROR <> 0 GOTO ABORT

--          Update the ItemSite Record
                Update ItemSite
                     Set LastStdCost = S.StdCost,
                         PStdCostDate = Space (1),
                         StdCostDate = GetDate(),
                         DirStdCst = S.PDirStdCst,
                         FOvhStdCst = S.PFOvhStdCst,
                         StdCost = S.PStdCst,
                         VOvhStdCst = S.PVOvhStdCst,
                         PDirStdCst = 0,
                         PFOvhStdCst = 0,
                         PStdCst = 0,
                         PVOvhStdCst = 0,
                         BMIDirStdCst = Case When BMIPStdCst <> 0 Then BMIPDirStdCst Else BMIDirStdCst End,
                         BMIFOvhStdCst = Case When BMIPStdCst <> 0 Then BMIPFOvhStdCst Else BMIFOvhStdCst End,
                         BMIVOvhStdCst = Case When BMIPStdCst <> 0 Then BMIPVOvhStdCst Else BMIVOvhStdCst End,
                         BMIStdCost = Case When BMIPStdCst <> 0 Then BMIPStdCst Else BMIStdCost End,
                         BMIPDirStdCst = 0,
                         BMIPFOvhStdCst = 0,
                         BMIPStdCst = 0,
                         BMIPVOvhStdCst = 0,
                         LUpd_DateTime = GetDate(), LUpd_Prog = @ProgName, LUpd_User = @UserName
                    From ItemSite S
                   Where S.PStdCst <> 0
                     And S.CpnyId = @CpnyId
		     And S.PstdCostDate <= GetDate()
                IF @@ROWCOUNT <> 0 Select @Process_Flag = '1'
                IF @@ERROR <> 0 GOTO ABORT
            END
        ELSE     -- Selected Items
            Begin
--          Update the Inventory Record
                Update Inventory
                     Set LastStdCost = StdCost,
                         PStdCostDate = Space (1),
                         StdCostDate = GetDate(),
                         DirStdCost = PDirStdCost,
                         FOvhStdCost = PFOvhStdCost,
                         StdCost = PStdCost,
                         VOvhStdCost = PVOvhStdCost,
                         PDirStdCost = 0,
                         PFOvhStdCost = 0,
                         PStdCost = 0,
                         PVOvhStdCost = 0,
                         BMIDirStdCost = Case When BMIPStdCost <> 0 Then BMIPDirStdCost Else BMIDirStdCost End,
                         BMIFOvhStdCost = Case When BMIPStdCost <> 0 Then BMIPFOvhStdCost Else BMIFOvhStdCost End,
                         BMIVOvhStdCost = Case When BMIPStdCost <> 0 Then BMIPVOvhStdCost Else BMIVOvhStdCost End,
                         BMIStdCost = Case When BMIPStdCost <> 0 Then BMIPStdCost Else BMIStdCost End,
                         BMIPDirStdCost = 0,
                         BMIPFOvhStdCost = 0,
                         BMIPStdCost = 0,
                         BMIPVOvhStdCost = 0,
                         LUpd_DateTime = GetDate(), LUpd_Prog = @ProgName, LUpd_User = @UserName
                    From Inventory, IN10530_Wrk
                   Where PStdCost <> 0
                     And ValMthd = 'T'
                     And @UserAddress = IN10530_Wrk.ComputerName
                     And Inventory.InvtId = IN10530_Wrk.InvtId
		     And Inventory.PstdCostDate <= GetDate()
                IF @@ROWCOUNT <> 0 Select @Process_Flag = '1'
                IF @@ERROR <> 0 GOTO ABORT

--          Update the ItemSite Record
                Update ItemSite
                     Set LastStdCost = S.StdCost,
                         PStdCostDate = Space (1),
                         StdCostDate = GetDate(),
                         DirStdCst = S.PDirStdCst,
                         FOvhStdCst = S.PFOvhStdCst,
                         StdCost = S.PStdCst,
                         VOvhStdCst = S.PVOvhStdCst,
                         PDirStdCst = 0,
                         PFOvhStdCst = 0,
                         PStdCst = 0,
                         PVOvhStdCst = 0,
                         BMIDirStdCst = Case When BMIPStdCst <> 0 Then BMIPDirStdCst Else BMIDirStdCst End,
                         BMIFOvhStdCst = Case When BMIPStdCst <> 0 Then BMIPFOvhStdCst Else BMIFOvhStdCst End,
                         BMIVOvhStdCst = Case When BMIPStdCst <> 0 Then BMIPVOvhStdCst Else BMIVOvhStdCst End,
                         BMIStdCost = Case When BMIPStdCst <> 0 Then BMIPStdCst Else BMIStdCost End,
                         BMIPDirStdCst = 0,
                         BMIPFOvhStdCst = 0,
                         BMIPStdCst = 0,
                         BMIPVOvhStdCst = 0,
                         LUpd_DateTime = GetDate(), LUpd_Prog = @ProgName, LUpd_User = @UserName
                    From ItemSite S, IN10530_Wrk W
                   Where S.PStdCst <> 0
                     And S.CpnyId = @CpnyId
                     And @UserAddress = W.ComputerName
                     And S.InvtId = W.InvtId
		     And S.PstdCostDate <= GetDate()
                IF @@ROWCOUNT <> 0 Select @Process_Flag = '1'
                IF @@ERROR <> 0 GOTO ABORT
            END
        END

    PRINT 'Inventory Reval Complete'

    COMMIT TRANSACTION
    Goto Finish

ABORT:
    ROLLBACK TRANSACTION

Finish:
-- Purge Work Records
    DELETE FROM IN10530_Wrk
          WHERE ComputerName = @UserAddress
                Or DateAdd(Day,1,Crtd_DateTime) < getdate()

/*	Since the IN10530_Return table does not have a CpnyID field, we will use
	ErrorInvtID for now.  This field is not populated by any of the 10530 routines
*/
    INSERT INTO IN10530_Return (BatNbr, Batch_Created, ComputerName, Crtd_DateTime, ErrorFlag, ErrorInvtId, ErrorMessage, Process_Flag)
           VALUES(@BatNbr, @Batch_Created, @UserAddress, GetDate(), '', @CpnyID, '', @Process_Flag)


