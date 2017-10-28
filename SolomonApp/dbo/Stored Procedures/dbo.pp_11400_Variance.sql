 --APPTABLE
--USETHISSYNTAX

/****** Object:  Stored Procedure dbo.pp_11400_Variance    Script Date: 7/22/98 2:32:40 PM ******/
CREATE PROC pp_11400_Variance
		@Parm1 VARCHAR (21),            -- Computer Name
		@Parm2 VARCHAR (10),            -- VarAcct
		@Parm3 VARCHAR (10),            -- Batch Number
                @Parm5 VARCHAR (24),            -- VarSub
		@UserId VARCHAR (10),		-- User Id
		@VarAmt FLOAT,
		@BMICuryId VARCHAR (4),
		@BMIDfltRtTp VARCHAR (6),
		@PerPost VARCHAR (6),
		@INV_UNIT_PRICE smallint,
		@P_Error VARCHAR(1) OUTPUT AS   -- Error Flag

DECLARE        	@Variance_Acct		      	CHAR(10),
        	@Variance_Sub               	CHAR(24),
		@MinRecordId			Int

SELECT @Variance_Acct = DfltVarAcct,
       @Variance_Sub = DfltVarSub
    FROM INSetup

SELECT @MinRecordId = Min(RecordID)
    FROM INTRAN WHERE BatNbr = @Parm3

SET IDENTITY_INSERT INTRAN ON

  /******************************** CREATE INTRAN FOR KIT STD COST Variance********************************/

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
               SELECT CASE WHEN I.ValMthd = 'T'
			   THEN CASE WHEN LTRIM(@Parm2) IS NULL
                               	     THEN @Variance_Acct
                                     ELSE @Parm2 END
			   ELSE I.InvtAcct END, W.AcctDist, W.ARLineId, W.ARLineRef, @Parm3, @BMICuryID, W.BMIEffDate,
		      (V.BMIExtCost - W.BMIExtCost), '', 0, @BMIDfltRtTp, (V.BMITranAmt - W.BMITranAmt), 0,
		      W.CmmnPct, W.CnvFact, W.CogsAcct, W.COGSSub, W.CostType, W.CpnyId, GETDATE(),
		      CASE When I.ValMthd = 'T'
			   Then '11010Var'
			   Else '11010' END, @UserId,
		      CASE When @VarAmt > 0
                                THEN 'D'
                                ELSE 'C' End,
                      W.Excpt, ABS(@VarAmt), W.ExtRefNbr, SUBSTRING(@PerPost, 1, 4),
		      W.Id, W.InsuffQty, W.InvtAcct, K.KitId, W.InvtMult, W.InvtSub, W.JrnlType, '',
		      (1 + (SELECT Max(LineID) FROM INTRAN WHERE BatNbr = @Parm3)),
                      (3 + (SELECT MAX(LineNbr) FROM INTran WHERE BatNbr = @Parm3)),
		      (1 + (SELECT MAX(LineRef) FROM INTran WHERE BatNbr = @Parm3)), W.LotSerCntr, GetDate(),
		      CASE When I.ValMthd = 'T'
			   Then '11010Var'
			   Else '11010' END,
		      @UserId, 0, 0, 0, W.PC_Flag, W.PC_ID, W.PC_Status,
		      W.PerEnt, @PerPost, W.ProjectID, 1, W.QtyUnCosted, W.RcptDate, W.RcptNbr,
		      W.ReasonCd, (1 + (SELECT Max(RecordID) FROM INTRAN WHERE BatNbr = @Parm3)), W.RefNbr, 0, '', '', 0,
		      0, 0, 0, '', '', 0,
		      0, '', '', 0, W.SiteId, W.SlsperId, W.SpecificCostID,
		      CASE WHEN LTRIM(@Parm5) IS NULL
                               THEN @Variance_Sub
                               ELSE @Parm5
                           END, W.TaskID, '', '',
		      Case When @VarAmt > 0
                                THEN @VarAmt
                                ELSE ABS(@VarAmt) End,
  W.TranDate, CASE When I.ValMthd = 'T'
				       Then 'Std Cost Variance'
				       Else 'Assemble Kit: ' + RTRIM(K.KitId) END, W.TranType, W.UnitDesc, W.UnitMultDiv, 0,
                      W.User1, W.User2, W.User3, W.User4, W.User5, W.User6, W.User7, W.User8, W.WhseLoc
    	          FROM vp_11400_Variance V, INTRAN W, Inventory I, Kit K
                  WHERE
                    	W.BatNbr = @Parm3
			AND V.BatNbr = W.BatNbr
			AND W.RecordId = @MinRecordId
                    	AND W.TranType = 'AS'
			AND W.InvtId = V.InvtId
			AND W.KitId = V.KitId
--                    	AND W.TranAmt <> V.TranAmt
                    	AND W.InvtId = I.InvtId
--bb 2/7/01                    	AND I.ValMthd = 'T'
		    	AND K.KitId = W.KitId
		    	AND K.SiteId = W.SiteId


        IF @@ERROR <> 0 GOTO ABORT

GOTO Finish

ABORT:

    SELECT @P_Error = 'Y'

Finish:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_11400_Variance] TO [MSDSL]
    AS [dbo];

