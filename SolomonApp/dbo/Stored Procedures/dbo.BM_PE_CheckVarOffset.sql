 CREATE PROC BM_PE_CheckVarOffset
	@BatNbr       	VARCHAR(10),            -- Batch Number
	@UserId 	VARCHAR (10),           -- User_Name
	@CpnyId		VARCHAR (10),		-- Company Id
	@P_Error 	VARCHAR(1) AS		-- Error

	DECLARE	@EffLbrOvhVarAmt	FLOAT,
		@EffLbrVarAmt		FLOAT,
		@EffMachOvhVarAmt	FLOAT,
		@EffMatlOvhVarAmt	FLOAT,
		@EffMatlVarAmt		FLOAT,
		@EffOthVarAmt		FLOAT,
        	@PerPost                CHAR(6),
        	@BMICuryId              Char(4),
        	@BMIDfltRtTp            CHAR(6),
		@INV_UNIT_PRICE 	INT,
    		@SQLErrNbr		SmallInt,
		@LbrDirOffAcct		CHAR(10),
		@LbrDirOffSub		CHAR(24),
		@OthDirOffAcct		CHAR(10),
		@OthDirOffSub		CHAR(24),
		@MatlOvhOffAcct		CHAR(10),
		@MatlOvhOffSub		CHAR(24),
		@LbrOvhOffAcct		CHAR(10),
		@LbrOvhOffSub		CHAR(24),
		@MachOvhOffAcct		CHAR(10),
		@MachOvhOffSub		CHAR(24)


SELECT	@LbrDirOffAcct = LbrDirOffAcct,
	@LbrDirOffSub = LbrDirOffSub,
	@OthDirOffAcct = OthDirOffAcct,
	@OthDirOffSub = OthDirOffSub,
	@MatlOvhOffAcct = MatlOvhOffAcct,
	@MatlOvhOffSub = MatlOvhOffSub,
	@LbrOvhOffAcct = LbrOvhOffAcct,
	@LbrOvhOffSub = LbrOvhOffSub,
	@MachOvhOffAcct = MachOvhOffAcct,
	@MachOvhOffSub = MachOvhOffSub
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
	   @INV_UNIT_PRICE = DecPlPrcCst
    From INSetup with (NOLOCK)

	IF @EffLbrOvhVarAmt <> 0
	   Begin
		EXEC BM_PE_VarOffset @LbrOvhOffAcct , @BatNbr, @LbrOvhOffSub, @UserId, @EffLbrOvhVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, 'Labor Overhead', @CpnyId, @P_Error Output
		IF @P_Error = 'Y' Goto Abort
	   End

	IF @EffLbrVarAmt <> 0
	   Begin
		EXEC BM_PE_VarOffset @LbrDirOffAcct , @BatNbr, @LbrDirOffSub, @UserId, @EffLbrVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, 'Direct Labor', @CpnyId, @P_Error Output
		IF @P_Error = 'Y' Goto Abort
	   End

	IF @EffMachOvhVarAmt <> 0
	   Begin
		EXEC BM_PE_VarOffset @MachOvhOffAcct , @BatNbr, @MachOvhOffSub, @UserId, @EffMachOvhVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, 'Machine Overhead', @CpnyId, @P_Error Output
		IF @P_Error = 'Y' Goto Abort
	   End

	IF @EffOthVarAmt <> 0
	   Begin
		EXEC BM_PE_VarOffset @OthDirOffAcct , @BatNbr, @OthDirOffSub, @UserId, @EffOthVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, 'Other Direct', @CpnyId, @P_Error Output
		IF @P_Error = 'Y' Goto Abort
	   End

	IF @EffMatlOvhVarAmt <> 0
	   Begin
		EXEC BM_PE_VarOffset @MatlOvhOffAcct , @BatNbr, @MatlOvhOffSub, @UserId, @EffMatlOvhVarAmt, @BMICuryId, @BMIDfltRtTp, @PerPost, @INV_UNIT_PRICE, 'Material Overhead', @CpnyId, @P_Error Output
		IF @P_Error = 'Y' Goto Abort
	   End

	GOTO Finish

Abort:
	Select @SQLErrNbr = @@Error

	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr)
	VALUES
		(@BatNbr, @UserId, 'BM_PE_CheckVarOffset', @SQLErrNbr)

Finish:


