 Create	Procedure SCM_10400_BOM_Routing_CreateGLTran
				@BatNbr			VarChar(10),
				@CpnyID			VarChar(10),
				@JrnlType		VarChar(3),
				@RefNbr			VarChar(10),
				@ProcessName		Varchar(8),
				@UserName		Varchar(10),
				@UserAddress		Varchar(21),
				@NegQty			Bit,
				@BalanceType		Char(1),
				@BaseCuryID		Char(4),
				@GLPostOpt		Char(1),
				@LedgerID		Char(10),
				@Valid_AcctSub		SmallInt,
				@BaseDecPl		SmallInt,
				@BMIDecPl		SmallInt,
				@DecPlPrcCst		SmallInt,
				@DecPlQty		SmallInt,
				@MatlOvhCalc    	Char(1)

 AS
	SET NOCOUNT ON
	
    DECLARE @SQLErrNbr				SmallInt
    DECLARE @RecordCount			INT
    DECLARE @BOMKitID				CHAR(24)
    DECLARE @BOMDirLbrAmt 			FLOAT
    DECLARE @BOMDirOthAmt 			FLOAT
    DECLARE @BOMEffLbrOvhVarAmt			FLOAT
    DECLARE @BOMEffLbrVarAmt 			FLOAT
    DECLARE @BOMEffMachOvhVarAmt		FLOAT
    DECLARE @BOMEffOthVarAmt 	  		FLOAT
    DECLARE @BOMOvhLbrAmt 	  		FLOAT
    DECLARE @BOMOvhMachAmt 	  		FLOAT
    DECLARE @BOMTotTranAmt 	  		FLOAT
    DECLARE @BOMTotVarAmt 	  		FLOAT
    DECLARE @OthDirOffAcct     			CHAR(10)
    DECLARE @OthDirOffSub      			CHAR(24)
    DECLARE @SiteID				VARCHAR(10)
    DECLARE @ExtCost				FLOAT
    DECLARE @Qty				FLOAT
    DECLARE @LayerType				VarChar(1)
    DECLARE @SpecificCost			VarChar(25)
    DECLARE @RcptDate				SmallDateTime
    DECLARE @ValMthd				Char(1)
    DECLARE @TmpTotalCost			FLOAT
    DECLARE @LastCost				FLOAT
    DECLARE @TotalCost				FLOAT
    DECLARE @UpdateGL                           SmallInt
	DECLARE @RcptNbr				VARCHAR(15)
	DECLARE @LineRef				VARCHAR(5)
	
    SELECT @SQLErrNbr         = ' '

    CREATE TABLE #Wrk11400_GLTran (
					Acct				CHAR(10),
				   	AvgCostTot			FLOAT,
				   	BOMDirLbrAmt 			FLOAT,
				   	BOMDirOthAmt 			FLOAT,
				   	BOMEffLbrOvhVarAmt   		FLOAT,
				   	BOMEffLbrVarAmt 		FLOAT,
				   	BOMEffMachOvhVarAmt		FLOAT,
				   	BOMEffOthVarAmt 		FLOAT,
				   	BOMOvhLbrAmt 			FLOAT,
				   	BOMOvhMachAmt 			FLOAT,
				   	BOMTotTranAmt 			FLOAT,
				   	BOMTotVarAmt 			FLOAT,
                   			CrAmt                		FLOAT,
                   			DrAmt                		FLOAT,
                   			InvtId               		CHAR(24),
					RtgLineNbr			SMALLINT,
                   			RefNbr               		CHAR(15),
                   			Sub                  		CHAR(24),
                   			TranDate             		SMALLDATETIME,
                   			TranDesc             		CHAR(30),
                   			TranType             		CHAR(2),
                   			tstamp               		TIMESTAMP)
    IF @@ERROR <> 0 GOTO ABORT

    SELECT @OthDirOffAcct = OthDirOffAcct,
           @OthDirOffSub = OthDirOffSub
    FROM BMSetup (NOLOCK)

    SELECT @UpdateGL = UpdateGL
    FROM INSetup (NOLOCK)

   -- Post in Detail, create detailed GLTran records.

    -- Print 'Begin Outside Credit'
    -- Credit for 'OUTSIDE' operations
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt,BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt, DrAmt, InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT @OthDirOffAcct, R.DirOthAmt,
		 0, R.DirOthAmt, 0, 0, 0,
		 0, 0, 0, ROUND(R.DirOthAmt, @BaseDecPl), 0,
		 ROUND(R.DirOthAmt, @BaseDecPl), 0, I.InvtID, R.RtgLineNbr, R.RefNbr, @OthDirOffSub, B.TranDate, rtrim(R.KitID) + ' - Outside', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join Operation O
				on O.OperationID = R.OperationID
             WHERE R.RefNbr = @RefNbr and O.OperType = 'O' and B.BatNbr = @BatNbr
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Outside Debit'
    -- Debit for 'OUTSIDE' operations
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt, DrAmt, InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT I.InvtAcct, 0,
		 0, 0, 0, 0, 0,
		 0, 0, 0, 0, 0,
		 0, ROUND(R.DirOthAmt, @BaseDecPl), I.InvtID, R.RtgLineNbr, R.RefNbr, I.InvtSub, B.TranDate, rtrim(R.KitID) + ' - Outside', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join Operation O
				on O.OperationID = R.OperationID
             WHERE R.RefNbr = @RefNbr and O.OperType = 'O'
		and B.BatNbr = @BatNbr and I.Valmthd <> 'T'
    IF @@ERROR <> 0 GOTO ABORT
	-- Print 'Begin Direct Labor Credit'

	--Credit for Direct Labor
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt, DrAmt, InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT W.LbrDirOffAcct, R.DirLbrAmt,
		 R.DirLbrAmt, 0, 0, 0, 0,
		 0, 0, 0, ROUND(R.DirLbrAmt, @BaseDecPl), 0,
		 ROUND(R.DirLbrAmt, @BaseDecPl), 0, I.InvtID, R.RtgLineNbr, R.RefNbr, W.LbrDirOffSub, B.TranDate, rtrim(R.KitID) + ' - Dir Labor', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.DirLbrAmt <> 0
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Direct Labor Debit'
    -- Debit for Direct Labor
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt, DrAmt, InvtId,RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT I.InvtAcct,0,
		 0, 0, 0, 0, 0,
		 0, 0, 0, 0, 0,
		 0, ROUND(R.DirLbrAmt, @BaseDecPl), I.InvtID, R.RtgLineNbr, R.RefNbr, I.InvtSub, B.TranDate, rtrim(R.KitID) + ' - Dir Labor', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.DirLbrAmt <> 0 and I.Valmthd <> 'T'
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Other Direct Credit'
    -- Credit for Other Direct
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt, DrAmt, InvtId,RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT W.OthDirOffAcct, R.DirOthAmt,
		 0, R.DirOthAmt, 0, 0, 0,
		 0, 0, 0, ROUND(R.DirOthAmt, @BaseDecPl), 0,
		 ROUND(R.DirOthAmt, @BaseDecPl), 0, I.InvtID, R.RtgLineNbr, R.RefNbr, W.OthDirOffSub, B.TranDate, rtrim(R.KitID) + ' - Other Dir', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.DirOthAmt <> 0
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Other Direct Debit'
    -- Debit for Other Direct
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt, DrAmt, InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)

          SELECT I.InvtAcct, 0,
		 0, 0, 0, 0, 0,
		 0, 0, 0, 0, 0,
		 0, ROUND(R.DirOthAmt, @BaseDecPl), I.InvtID,R.RtgLineNbr, R.RefNbr, I.InvtSub, B.TranDate, rtrim(R.KitID) + ' - Other Dir', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.DirOthAmt <> 0 and I.Valmthd <> 'T'
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Labor Overhead Credit'
    -- Credit for Labor Overhead
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt, DrAmt, InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT W.LbrOvhOffAcct, R.OvhLbrAmt,
		 0, 0, 0, 0, 0,
		 0, R.OvhLbrAmt, 0, ROUND(R.OvhLbrAmt, @BaseDecPl),0,
		 ROUND(R.OvhLbrAmt, @BaseDecPl), 0, I.InvtID, R.RtgLineNbr, R.RefNbr, W.LbrOvhOffSub, B.TranDate, rtrim(R.KitID) + ' - Labor Ovh', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.OvhLbrAmt <> 0
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Labor Overhead Debit'
    -- Debit for Labor Overhead
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt, DrAmt, InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT I.InvtAcct, 0,
		 0, 0, 0, 0, 0,
		 0, 0, 0, 0, 0,
		 0, ROUND(R.OvhLbrAmt, @BaseDecPl), I.InvtID, R.RtgLineNbr, R.RefNbr, I.InvtSub, B.TranDate, rtrim(R.KitID) + ' - Labor Ovh', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
            WHERE R.RefNbr = @RefNbr and R.OvhLbrAmt <> 0 and I.Valmthd <> 'T'
   IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Machine Overhead Credit'
    -- Credit for Machine Overhead
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			    CrAmt, DrAmt, InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT W.MachOvhOffAcct, R.OvhMachAmt,
		 0, 0, 0, 0, 0,
		 0, 0, R.OvhMachAmt, ROUND(R.OvhMachAmt, @BaseDecPl), 0,
		 ROUND(R.OvhMachAmt, @BaseDecPl), 0, I.InvtID, R.RtgLineNbr, R.RefNbr, W.MachOvhOffSub, B.TranDate, rtrim(R.KitID) + ' - Machine Ovh', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.OvhMachAmt <> 0
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Machine Overhead Debit'
    -- Debit for Machine Overhead
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt, DrAmt, InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT I.InvtAcct, 0,
		 0, 0, 0, 0, 0,
		 0, 0, 0, 0, 0,
		 0, ROUND(R.OvhMachAmt, @BaseDecPl), I.InvtID, R.RtgLineNbr, R.RefNbr, I.InvtSub, B.TranDate, rtrim(R.KitID) + ' - Machine Ovh', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.OvhMachAmt <> 0 and I.Valmthd <> 'T'
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Direct Labor Variance'
    -- Direct Labor Variance
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt,
			     DrAmt,
			     InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT W.LbrDirVarAcct, 0,
		 0, 0, 0, R.DirLbrEffVarAmt, 0,
		 0, 0, 0, 0, R.DirLbrEffVarAmt,
		 CASE When R.DirLbrEffVarAmt < 0 Then (ROUND(R.DirLbrEffVarAmt, @BaseDecPl) * -1) Else 0 END,
		 CASE When R.DirLbrEffVarAmt > 0 Then ROUND(R.DirLbrEffVarAmt, @BaseDecPl) Else 0 END,
		 I.InvtID, R.RtgLineNbr, R.RefNbr, W.LbrDirVarSub, B.TranDate, rtrim(R.KitID) + ' - Labor Var', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.DirLbrEffVarAmt <> 0
		and I.ValMthd = 'T'
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Other Direct Variance'
    -- Other Direct Variance
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt,
			     DrAmt,
			     InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT W.OthDirVarAcct, 0,
		 0, 0, 0, 0, 0,
		 R.DirOthEffVarAmt, 0, 0, 0, R.DirOthEffVarAmt,
		 CASE When R.DirOthEffVarAmt < 0 Then (ROUND(R.DirOthEffVarAmt, @BaseDecPl) * -1) Else 0 END,
		 CASE When R.DirOthEffVarAmt > 0 Then ROUND(R.DirOthEffVarAmt, @BaseDecPl) Else 0 END,
		 I.InvtID, R.RtgLineNbr, R.RefNbr, W.OthDirVarSub, B.TranDate, rtrim(R.KitID) + ' - Direct Var', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.DirOthEffVarAmt <> 0
		and I.ValMthd = 'T'
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Labor Overhead Variance'
    -- Labor Overhead Variance
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt,
			     DrAmt,
			     InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT W.LbrOvhVarAcct, 0,
		 0, 0, R.OvhLbrEffVarAmt, 0, 0,
		 0, 0, 0, 0, R.OvhLbrEffVarAmt,
		 CASE When R.OvhLbrEffVarAmt < 0 Then (ROUND(R.OvhLbrEffVarAmt, @BaseDecPl) * -1) Else 0 END,
		 CASE When R.OvhLbrEffVarAmt > 0 Then ROUND(R.OvhLbrEffVarAmt, @BaseDecPl) Else 0 END,
		 I.InvtID, R.RtgLineNbr, R.RefNbr, W.LbrOvhVarSub, B.TranDate, rtrim(R.KitID) + ' - Labor Ovh Var', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.OvhLbrEffVarAmt <> 0
		and I.ValMthd = 'T'
    IF @@ERROR <> 0 GOTO ABORT

    -- Print 'Begin Machine Overhead Variance'
    -- Machine Overhead Variance
    INSERT #Wrk11400_GLTran (Acct, AvgCostTot,
			     BOMDirLbrAmt, BOMDirOthAmt, BOMEffLbrOvhVarAmt, BOMEffLbrVarAmt, BOMEffMachOvhVarAmt,
			     BOMEffOthVarAmt, BOMOvhLbrAmt, BOMOvhMachAmt, BOMTotTranAmt, BOMTotVarAmt,
			     CrAmt,
			     DrAmt,
			     InvtId, RtgLineNbr, RefNbr, Sub, TranDate, TranDesc, TranType)
          SELECT W.MachOvhVarAcct, 0,
		 0, 0, 0, 0, R.OvhMachEffVarAmt,
		 0, 0, 0, 0, R.OvhMachEffVarAmt,
		 CASE When R.OvhMachEffVarAmt < 0 Then (ROUND(R.OvhMachEffVarAmt, @BaseDecPl) * -1) Else 0 END,
		 CASE When R.OvhMachEffVarAmt > 0 Then ROUND(R.OvhMachEffVarAmt, @BaseDecPl) Else 0 END,
		 I.InvtID, R.RtgLineNbr, R.RefNbr, W.MachOvhVarSub, B.TranDate, rtrim(R.KitID) + ' - Machine Ovh Var', 'AS'
             FROM RtgTran R Join BOMDoc B
				on B.RefNbr = R.RefNbr
			    Join Inventory I
				on I.InvtID = R.KitID
			    Join WorkCenter W
				on W.WorkCenterID = R.WorkCenterID
             WHERE R.RefNbr = @RefNbr and R.OvhMachEffVarAmt <> 0
		and I.ValMthd = 'T'
    IF @@ERROR <> 0 GOTO ABORT



    SELECT @RecordCount     	= 0
    SELECT @TmpTotalCost        = 0
    SELECT @BOMDirLbrAmt        = 0
    SELECT @BOMDirOthAmt        = 0
    SELECT @BOMEffLbrOvhVarAmt  = 0
    SELECT @BOMEffLbrVarAmt 	= 0
    SELECT @BOMEffMachOvhVarAmt = 0
    SELECT @BOMEffOthVarAmt 	= 0
    SELECT @BOMOvhLbrAmt 	= 0
    SELECT @BOMOvhMachAmt 	= 0
    SELECT @BOMTotTranAmt 	= 0
    SELECT @BOMTotVarAmt 	= 0

    --Get Total Routing Costs and record count
    SELECT @TmpTotalCost = COALESCE(SUM(AvgCostTot),0),
	   @RecordCount = Count(*)
    FROM #Wrk11400_GLTran W

    IF @@ERROR <> 0 GOTO ABORT

    IF (@RecordCount > 0)          -- G/L Transactions need to be Created
		BEGIN

			--Insert a GL Record for each record in #Wrk11400_GLTran
			DECLARE
				@W_Acct		VarChar(10),
				@W_CrAmt	Float,
				@W_DrAmt	Float,
				@W_DrCr		Char(1),
				@W_InvtID	VarChar(30),
				@W_RefNbr	VarChar(10),
				@W_Sub		VarChar(24),
				@W_TranDate	SmallDateTime,
				@W_TranDesc	VarChar(30),
				@W_TranType	Char(2)

                        IF @UpdateGL = 1
                           BEGIN
			     DECLARE GLTemp_Cursor CURSOR LOCAL FOR
				SELECT W.Acct, W.CrAmt, W.DrAmt,CASE When W.CrAmt <> 0 Then 'C' Else 'D' END,W.InvtId, W.RefNbr, W.Sub, W.TranDate, W.TranDesc, W.Trantype
				FROM #Wrk11400_GLTran W

			     OPEN GLTemp_cursor

			     FETCH NEXT FROM GLTemp_cursor
			     INTO @W_Acct,@W_CrAmt,@W_DrAmt,@W_DrCr,@W_InvtID,@W_RefNbr,@W_Sub,@W_TranDate,@W_TranDesc,@W_TranType
			     WHILE @@FETCH_STATUS = 0
			       BEGIN

				     exec SCM_Insert_GLTran  @W_Acct, @BatNbr, @CpnyID, @W_CRAmt,
							@W_DrAmt,@W_DrCr , @W_InvtID, @JrnlType,
							'IN', '',0, @W_RefNbr, @W_Sub, '', @W_TranDate,
							@W_TranDesc,@W_TranType, @ProcessName, @UserName,
							@UserAddress, @NegQty, @BalanceType, @BaseCuryID,
							@GLPostOpt, @LedgerID, @Valid_AcctSub,@BaseDecPl,
							@BMIDecPl, @DecPlPrcCst, @DecPlQty
				     IF @@ERROR <> 0 GOTO ABORT
				     FETCH NEXT FROM GLTemp_cursor
				     INTO @W_Acct,@W_CrAmt,@W_DrAmt,@W_DrCr,@W_InvtID,@W_RefNbr,@W_Sub,@W_TranDate,@W_TranDesc,@W_TranType
			       END
			     CLOSE GLTemp_cursor
			     DEALLOCATE GLTemp_cursor
		          END	-- Update GL From Inventory


			-- Print 'Begin Set BOM vars'
		        SELECT @BOMDirLbrAmt = COALESCE(SUM(ROUND(BOMDirLbrAmt,@BaseDecPl)),0),
			       @BOMDirOthAmt = COALESCE(SUM(ROUND(BOMDirOthAmt,@BaseDecPl)),0),
			       @BOMEffLbrOvhVarAmt = COALESCE(SUM(ROUND(BOMEffLbrOvhVarAmt,@BaseDecPl)),0),
			       @BOMEffLbrVarAmt = COALESCE(SUM(ROUND(BOMEffLbrVarAmt,@BaseDecPl)),0),
			       @BOMEffMachOvhVarAmt = COALESCE(SUM(ROUND(BOMEffMachOvhVarAmt,@BaseDecPl)),0),
			       @BOMEffOthVarAmt = COALESCE(SUM(ROUND(BOMEffOthVarAmt,@BaseDecPl)),0),
			       @BOMOvhLbrAmt = COALESCE(SUM(ROUND(BOMOvhLbrAmt,@BaseDecPl)),0),
			       @BOMOvhMachAmt = COALESCE(SUM(ROUND(BOMOvhMachAmt,@BaseDecPl)),0),
			       @BOMTotTranAmt = COALESCE(SUM(ROUND(BOMTotTranAmt,@BaseDecPl)),0),
			       @BOMTotVarAmt = COALESCE(SUM(ROUND(BOMTotVarAmt,@BaseDecPl)),0)
			   FROM #Wrk11400_GLTran W
		        IF @@ERROR <> 0 GOTO ABORT

		        -- Print 'Begin Update BOMDoc'
			UPDATE B
		                   SET 	B.DirLbrAmt = ROUND(B.DirLbrAmt + @BOMDirLbrAmt, @DecPlPrcCst),
					B.DirOthAmt = ROUND(B.DirOthAmt + @BOMDirOthAmt, @DecPlPrcCst),
					B.EffLbrOvhVarAmt = ROUND(B.EffLbrOvhVarAmt + @BOMEffLbrOvhVarAmt, @DecPlPrcCst),
					B.EffLbrVarAmt = ROUND(B.EffLbrVarAmt + @BOMEffLbrVarAmt, @DecPlPrcCst),
					B.EffMachOvhVarAmt = ROUND(B.EffMachOvhVarAmt + @BOMEffMachOvhVarAmt, @DecPlPrcCst),
					B.EffOthVarAmt = ROUND(B.EffOthVarAmt + @BOMEffOthVarAmt, @DecPlPrcCst),
					B.LUpd_DateTime = GetDate(),
					B.LUpd_Prog = '11400SQL',
					B.LUpd_User = @UserName,
					B.OvhLbrAmt = ROUND(B.OvhLbrAmt + @BOMOvhLbrAmt, @DecPlPrcCst),
					B.OvhMachAmt = ROUND(B.OvhMachAmt + @BOMOvhMachAmt, @DecPlPrcCst),
					B.TotTranAmt = ROUND(B.TotTranAmt + @BOMTotTranAmt, @DecPlPrcCst),
					B.TotVarAmt = ROUND(B.TotVarAmt + @BOMTotVarAmt, @DecPlPrcCst)
		                     FROM BOMDoc B
		                     WHERE B.RefNbr = @RefNbr
			IF @@ERROR <> 0 GOTO ABORT


			-- Print 'Begin Update ItemSite, ItemCost, Inventory'
			--Get the Parent BOM's Kit ID
			SELECT @BOMKitID = KitID
			FROM BOMDoc
		        WHERE RefNbr = @RefNbr

			--GET SiteID,ExtCost, Qty, LayerType, RcptDate and ValMethod
			SELECT @SiteID = N.SiteID, @ExtCost = N.ExtCost, @Qty = N.Qty,
				@LayerType = LayerType, @RcptDate = N.RcptDate, @SpecificCost = N.SpecificCostID,
				@ValMthd =  V.ValMthd, @RcptNbr = N.RcptNbr, @LineRef = N.LineRef
			FROM INTran N JOIN Inventory V ON V.InvtID = N.InvtID
			Where N.BatNbr = @BatNbr AND N.RefNbr = @RefNbr AND N.InvtID = @BOMKitID AND N.TranType = 'AS'

			SELECT @LastCost =CASE WHEN @Qty > 0 THEN Round((@TmpTotalCost + @ExtCost)/@Qty, @DecPlPrcCst) ELSE 0 END
			SELECT @TotalCost = Round(@TmpTotalCost, @DecPlPrcCst)


			--Update ItemSite Costs for all Valuation Methods except Standard
			IF @ValMthd <> 'T'
			EXEC DMG_10400_UPD_ItemSite @Batnbr, @ProcessName,@UserName, @UserAddress, @BaseDecPl,
						@BMIDecPl,@DecPlQty, @DecPlPrcCst, @NegQty, @ValMthd, @MatlovhCalc,
						@BOMKitID, @SiteID, @CpnyID, 0, @LastCost,	0,0,0,0,0,0,0,0,0,
						0, @TotalCost, @RcptNbr, @LineRef, @RefNbr

			IF @@ERROR <> 0 GOTO ABORT

			--Update ItemCost Costs for FIFO, LIFO, and Specific
			-- RcptNbr = @RefNbr
			IF @ValMthd = 'S' Begin
				Set @RefNbr = ''
				Set @RcptDate = CONVERT(smalldatetime, '01/01/1900')
			End

			IF @ValMthd = 'F' OR @ValMthd = 'L' OR @ValMthd = 'S'
			EXEC DMG_10400_UPD_ItemCost @Batnbr, @ProcessName, @UserName, @UserAddress, @BaseDecPl,
						@BMIDecPl, @DecPlQty, @DecPlPrcCst, @NegQty, @ValMthd, @BOMKitID,
						@SiteID, @LayerType, @SpecificCost, @RefNbr, @RcptDate, 0,
						0, 0, @TotalCost

			IF @@ERROR <> 0 GOTO ABORT

			--Update Inventory Costs for all Valuation Methods except Standard
			IF @ValMthd <> 'T'
			EXEC DMG_10400_UPD_Inventory @Batnbr, @ProcessName, @UserName, @UserAddress,
						@DecPlQty, @DecPlPrcCst, @NegQty, @BOMKitID,
						0,@LastCost
			IF @@ERROR <> 0 GOTO ABORT

		END


    GOTO FINISH

ABORT:
    SELECT @SQLErrNbr = @@ERROR
	Begin
		Insert 	Into IN10400_RETURN
			(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
		VALUES
			(@BatNbr, @UserAddress, 'SCM_10400_BOM_Routine_CreateGLTran', @SQLErrNbr)
	End

FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_BOM_Routing_CreateGLTran] TO [MSDSL]
    AS [dbo];

