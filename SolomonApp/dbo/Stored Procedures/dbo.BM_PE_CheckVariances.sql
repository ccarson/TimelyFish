 CREATE PROC BM_PE_CheckVariances
	@BatNbr       	VARCHAR(10),            -- Batch Number
	@ComputerName	VARCHAR(21),		-- Computer Name
	@UserId 	VARCHAR (10),           -- User_Name
	@CpnyId		VARCHAR (10),		-- Company Id
	@P_Error 	VARCHAR(1) AS		-- Error

	DECLARE	@EffLbrOvhVarAmt	FLOAT,
		@EffLbrVarAmt		FLOAT,
		@EffMachOvhVarAmt	FLOAT,
		@EffMatlOvhVarAmt	FLOAT,
		@EffMatlVarAmt		FLOAT,
		@EffOthVarAmt		FLOAT,
		@LbrOvhVarAcct          CHAR(10),
		@LbrDirVarAcct          CHAR(10),
		@LbrDirVarSub           CHAR(24),
		@LbrOvhVarSub           CHAR(24),
		@MachOvhVarAcct         CHAR(10),
		@MachOvhVarSub          CHAR(24),
		@MatlDirVarAcct         CHAR(10),
		@MatlDirVarSub          CHAR(24),
		@MatlOvhVarAcct         CHAR(10),
		@MatlOvhVarSub          CHAR(24),
		@OthDirVarAcct          CHAR(10),
		@OthDirVarSub           CHAR(24),
        	@PerPost                CHAR(6),
        	@BMICuryId              Char(4),
        	@BMIDfltRtTp            CHAR(6),
		@INV_UNIT_PRICE 	INT,
		@MachOvhScrapVarAcct    CHAR(10),
		@MachOvhScrapVarSub	CHAR(24),
    		@SQLErrNbr		SmallInt,
		@DecPlQty	    	Int


SELECT 	@LbrDirVarAcct = LbrDirVarAcct,
	@LbrDirVarSub =  LbrDirVarSub,
	@LbrOvhVarAcct = LbrOvhVarAcct,
	@LbrOvhVarSub =  LbrOvhVarSub,
	@MachOvhVarAcct =MachOvhVarAcct,
	@MachOvhVarSub = MachOvhVarSub,
	@MatlDirVarAcct = MatlDirVarAcct,
	@MatlDirVarSub =   MatlDirVarSub,
	@MatlOvhVarAcct = MatlOvhVarAcct,
	@MatlOvhVarSub = MatlOvhVarSub,
	@OthDirVarAcct = OthDirVarAcct,
	@OthDirVarSub = OthDirVarSub,
	@MachOvhScrapVarAcct = MachOvhScrapVarAcct,
	@MachOvhScrapVarSub = MachOvhScrapVarSub
    FROM BMSetup

SELECT @EffLbrOvhVarAmt = EffLbrOvhVarAmt,
	@EffLbrVarAmt = EffLbrVarAmt,
	@EffMachOvhVarAmt = EffMachOvhVarAmt,
	@EffMatlOvhVarAmt = EffMatlOvhVarAmt,
	@EffMatlVarAmt = EffMatlVarAmt,
	@EffOthVarAmt = EffOthVarAmt,
	@PerPost = PerPost
    FROM BomDoc
	Where BatNbr = @BatNbr

    SELECT @BMICuryId = BMICuryId,
           @BMIDfltRtTp = BMIDfltRtTp,
	   @INV_UNIT_PRICE = DecPlPrcCst,
           @DecPlQty = DecPlQty
    From INSetup with (NOLOCK)

	IF @EffLbrOvhVarAmt <> 0
	   Begin
	   	EXEC pp_11400_Variance @ComputerName, @LbrOvhVarAcct , @BatNbr, @LbrOvhVarSub, @UserId, @EffLbrOvhVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, @P_Error Output
	   	IF @P_Error = 'Y' Goto Abort
	   End

	IF @EffLbrVarAmt <> 0
	   Begin
	   	EXEC pp_11400_Variance @ComputerName, @LbrDirVarAcct , @BatNbr, @LbrDirVarSub, @UserId, @EffLbrVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, @P_Error Output
    	   	IF @P_Error = 'Y' Goto Abort
	   End

	IF @EffMachOvhVarAmt <> 0
	   Begin
	   	EXEC pp_11400_Variance @ComputerName, @MachOvhVarAcct , @BatNbr, @MachOvhVarSub, @UserId, @EffMachOvhVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, @P_Error Output
    	   	IF @P_Error = 'Y' Goto Abort
	   End

	IF @EffMatlVarAmt <> 0
	   Begin
	   	EXEC pp_11400_Variance @ComputerName, @MatlDirVarAcct , @BatNbr, @MatlDirVarSub, @UserId, @EffMatlVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, @P_Error Output
    	   	IF @P_Error = 'Y' Goto Abort
	   End

	IF @EffOthVarAmt <> 0
	   Begin
	   	EXEC pp_11400_Variance @ComputerName, @OthDirVarAcct , @BatNbr, @OthDirVarSub, @UserId, @EffOthVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, @P_Error Output
    	   	IF @P_Error = 'Y' Goto Abort
	   End

	IF @EffMatlOvhVarAmt <> 0
	   Begin
	   	EXEC pp_11400_Variance @ComputerName, @MatlOvhVarAcct , @BatNbr, @MatlOvhVarSub, @UserId, @EffMatlOvhVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, @P_Error Output
    	   	IF @P_Error = 'Y' Goto Abort
	   End

       INSERT INTRAN (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate,
			BMIExtCost, BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice,
			CmmnPct, KitId, CnvFact, COGSAcct, COGSSub, CostType, CpnyId,
			Crtd_DateTime, Crtd_Prog, Crtd_User, DrCr, Excpt, ExtCost, ExtRefNbr,
			FiscYr, Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub, JrnlType,
			LineId, LineNbr, LineRef, LotSerCntr, LUpd_DateTime, LUpd_Prog,
                   	LUpd_User, NoteID, OvrhdAmt, OvrhdFlag, PC_Flag, PC_ID, PC_Status,
			PerEnt, PerPost, ProjectID, Qty, QtyUnCosted, RcptDate, RcptNbr,
			ReasonCd, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03,
			S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09,
			S4Future10, S4Future11, S4Future12, ShortQty, SiteId, SlsperId,
			SpecificCostID, Sub, TaskID, ToSiteId, ToWhseLoc, TranAmt, TranDate,
			TranDesc, TranType, UnitDesc, UnitMultDiv, UnitPrice, User1, User2,
			User3, User4, User5, User6, User7, User8, WhseLoc)
               SELECT @MachOvhScrapVarAcct, W.AcctDist, W.ARLineId, W.ARLineRef, @BatNbr, @BMICuryID, W.BMIEffDate,
			(V.BMIExtCost - W.BMIExtCost), 'M',
                      	Case When (V.BMITranAmt - W.BMITranAmt) = 0 or (V.TranAmt - W.TranAmt) = 0
                                THEN 1
                                ELSE Round((V.BMITranAmt - W.BMITranAmt)/(V.TranAmt - W.TranAmt), @INV_UNIT_PRICE) End,
                      	@BMIDfltRtTp, (V.BMITranAmt - W.BMITranAmt), 0,
			W.CmmnPct, W.KitId, W.CnvFact, W.COGSAcct, W.COGSSub, W.CostType, W.CpnyId,
			GetDate(), '11400SQL', @UserId,
		      	Case When (V.TranAmt - W.TranAmt) > 0
                                THEN 'D'
                                ELSE 'C' End,
                     	W.Excpt, (V.ExtCost - W.ExtCost), W.ExtRefNbr,
			SUBSTRING(@PerPost, 1, 4), W.Id, W.InsuffQty, W.InvtAcct, W.InvtId, W.InvtMult, W.InvtSub, W.JrnlType,
			(1 + (SELECT Max(LineID) FROM INTRAN WHERE BatNbr = @BatNbr)),
                      	0, 0, 0, GetDate(), '11400SQL', @UserId, 0, W.OvrhdAmt, W.OvrhdFlag, W.PC_Flag, W.PC_ID, W.PC_Status, W.PerEnt, @PerPost, W.ProjectID, 0,
                  	Case When W.UnitMultDiv = 'D' And W.CnvFact <> 0
	                    Then (Round(Convert(Decimal(25, 9),W.Qty) / Convert(Decimal(25, 9),W.CnvFact) * W.InvtMult,@DecPlQty)*-1)
	                    Else (Round(Convert(Decimal(25, 9),W.Qty) * Convert(Decimal(25, 9),W.CnvFact) * W.InvtMult,@DecPlQty)*-1)
                  End,
			W.RcptDate,

                      W.RcptNbr, W.ReasonCd, W.RefNbr, 1, '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
                      0, W.SiteId, W.SlsperId, W.SpecificCostId, @MachOvhScrapVarSub, W.TaskID, '', '',
		      Case When (V.TranAmt - W.TranAmt) > 0
                                THEN (V.TranAmt - W.TranAmt)
                                ELSE ABS(V.TranAmt - W.TranAmt) End,
                      W.TranDate, rtrim(W.InvtID) + ' - Std Cost Variance 2', W.TranType, W.UnitDesc, W.UnitMultDiv, W.UnitPrice,
                      W.User1, W.User2, W.User3, W.User4, W.User5, W.User6, W.User7, W.User8, W.WhseLoc
    	          FROM vp_11400_Variance V, INTRAN W, Inventory I, Kit K
                  WHERE V.KitId = W.InvtId
                    AND @BatNbr = W.BatNbr
                    AND V.TranAmt <> W.TranAmt
                    AND W.InvtId = I.InvtId
                    AND I.ValMthd = 'T'
                    AND W.InvtId = K.KitId
                    AND LTRIM(W.KitId) IS NULL
                    AND W.TranType = 'AS'
		    AND K.SiteId = W.SiteId
		    AND K.BOMType = 'B'

        IF @@ERROR < > 0 GOTO ABORT

	GOTO Finish

Abort:
	Select @SQLErrNbr = @@Error

	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
	VALUES
		(@BatNbr, @UserId, 'BM_PE_CheckVariances', @SQLErrNbr)

Finish:


