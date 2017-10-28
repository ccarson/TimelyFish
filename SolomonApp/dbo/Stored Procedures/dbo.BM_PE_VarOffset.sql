 --APPTABLE
--USETHISSYNTAX

CREATE PROC BM_PE_VarOffset
		@OffAcct VARCHAR (10),          -- Offset Account
		@BatNbr VARCHAR (10),           -- Batch Number
                @OffSub VARCHAR (24),           -- Offset Subaccount
		@UserId VARCHAR (10),		-- User Id
		@OffAmt FLOAT,			-- Offset Amount
		@BMICuryId VARCHAR (4),		-- BMI Currency Id
		@BMIDfltRtTp VARCHAR (6),	-- BMI Default Rate Type
		@PerPost VARCHAR (6),		-- Period Posted
		@INV_UNIT_PRICE smallint,	--
		@Description VARCHAR (30),	-- Transaction Description
		@CpnyId VARCHAR (10),		-- Company Id
		@P_Error VARCHAR(1) OUTPUT AS   -- Error Flag

   DECLARE	@InvtAcct	CHAR (10),	-- Inventory Account
		@InvtId		CHAR (30),	-- Kit Id
		@InvtSub	CHAR (24),	-- Inventory Subaccount
		@RcptNbr	CHAR (10),	-- Receipt Number
		@RefNbr		CHAR (15),	-- Ref Number
		@SiteId		CHAR (10),	-- Site Id
		@SpecCostId	CHAR (25),	-- Specific Cost Id
		@UnitDesc	CHAR (8),	-- Unit Description
		@MinRecordId	Int		-- Minimum RecordID for this batch

   SET IDENTITY_INSERT INTRAN ON

   SELECT @InvtId = KitId,
	  @RefNbr = RefNbr,
	  @SiteId = Siteid,
	  @SpecCostId = SpecificCostId
	From BOMDoc where BatNbr = @BatNbr
		      and CpnyId = @CpnyId

   SELECT @RcptNbr = RcptNbr,
	  @UnitDesc = UnitDesc
	From INTran where BatNbr = @BatNbr
		      and CpnyId = @CpnyId

   SELECT @MinRecordId = Min(RecordID)
	FROM INTRAN WHERE BatNbr = @BatNbr

   SELECT @InvtAcct = InvtAcct,
	  @InvtSub = InvtSub
	From Inventory with (NOLOCK)
		where InvtId = @InvtId

  /******************************** CREATE INTRAN FOR Offset********************************/
       INSERT INTRAN (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate,
			BMIExtCost, BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice,
			CmmnPct, CnvFact, COGSAcct, COGSSub, CostType, CpnyID, Crtd_DateTime,
			Crtd_Prog, Crtd_User, DrCr, Excpt, ExtCost, ExtRefNbr, FiscYr,
                       	Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub, JrnlType, KitID,
			LineId, LineNbr, LineRef, LotSerCntr, LUpd_DateTime, LUpd_Prog,
			LUpd_User, NoteID, OvrhdAmt, OvrhdFlag, PC_Flag, PC_ID, PC_Status,
			PerEnt, PerPost, ProjectID, Qty, QtyUnCosted, RcptDate, RcptNbr,
			ReasonCd, RecordID, RefNbr, Rlsed, S4Future01, S4Future02, S4Future03,
			S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09,
			S4Future10, S4Future11, S4Future12, ShortQty, SiteId, SlsperId, SpecificCostID, Sub,
                       	TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc, TranType,
			UnitDesc, UnitMultDiv, UnitPrice, User1, User2, User3, User4, User5,
			User6, User7, User8, WhseLoc)

		SELECT @OffAcct, 0, 0, I.ARLineRef, @BatNbr, @BMICuryId, I.BMIEffDate,
			0, '', 0, @BMIDfltRtTp, 0, 0,
			0, I.CnvFact, I.COGSAcct, I.COGSSub, I.CostType, @CpnyId, GETDATE(),
			'11010off', @UserId, Case When @OffAmt < 0
                         				THEN 'D'
                                			ELSE 'C' End, 0, ABS(@OffAmt), I.ExtRefNbr, SUBSTRING(@PerPost, 1, 4),
			I.Id, 0, @InvtAcct, @InvtId, 1, @InvtSub, 'BM', '',
			(1 + (SELECT Max(LineID) FROM INTRAN WHERE BatNbr = @BatNbr)),
			(3 + (SELECT Max(LineNbr) FROM INTRAN WHERE BatNbr = @BatNbr)),
			(1 + (SELECT Max(LineRef) FROM INTRAN WHERE BatNbr = @BatNbr)), 0, GetDate(), '11010off',
			@UserId, 0, 0, 0, I.PC_Flag, I.PC_ID, I.PC_Status,
			@PerPost, @PerPost, I.ProjectID, 1, 0, GETDATE(), @RcptNbr,
			I.ReasonCd, (1 + (SELECT Max(RecordID) FROM INTRAN WHERE BatNbr = @BatNbr)), @RefNbr, 0, I.S4Future01, I.S4Future02, 0,
			0, 0, 0, I.S4Future07, I.S4Future08, 0,
			0, I.S4Future11, I.S4Future12, 0, I.SiteId, I.SlsperId, @SpecCostID, @OffSub,
			I.TaskId, I.ToSiteId, I.ToWhseLoc, Case When @OffAmt > 0
						THEN @OffAmt
                                		ELSE ABS(@OffAmt) End, GETDATE(), @Description, 'AS',
			@UnitDesc, 'M', 0, I.User1, I.User2, 0, 0, I.User5,
			I.User6, I.User7, I.User8, I.WhseLoc
		FROM INTran I where
			I.BatNbr = @BatNbr
			and I.CpnyId = @CpnyId
			and I.Crtd_Prog = '11010'
			and I.RecordId = @MinRecordId

        IF @@ERROR <> 0 GOTO ABORT

GOTO Finish

ABORT:

    SELECT @P_Error = 'Y'

Finish:


