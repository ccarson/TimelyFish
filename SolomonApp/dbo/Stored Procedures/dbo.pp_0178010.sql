 Create Procedure pp_0178010 @RI_ID SMALLINT

As

SET NOCOUNT ON

--DECLARE @SubAcctMask varchar(24)
DECLARE @BudgetSeg00 varchar (1), @BudgetSeg01 varchar (1), @BudgetSeg02 varchar (1), @BudgetSeg03 varchar (1)
DECLARE @BudgetSeg04 varchar (1), @BudgetSeg05 varchar (1), @BudgetSeg06 varchar (1), @BudgetSeg07 varchar (1)

--DECLARE @SubSegMask00 varchar (24), @SubSegMask01 varchar (24), @SubSegMask02 varchar (24), @SubSegMask03 varchar (24)
--DECLARE @SubSegMask04 varchar (24), @SubSegMask05 varchar (24), @SubSegMask06 varchar (24), @SubSegMask07 varchar (24)

DECLARE @SegLength00 smallint, @SegLength01 smallint, @SegLength02 smallint, @SegLength03 smallint
DECLARE @SegLength04 smallint, @SegLength05 smallint, @SegLength06 smallint, @SegLength07 smallint
DECLARE @NumSegs smallint

DECLARE @BudgetYear varchar(4), @BudgetLedger varchar(10), @CpnyID varchar (10)

DECLARE @BasisBudgetCpnyID varchar (10), @BasisBudgetYear varchar (4), @BasisBudgetLedger varchar (10)
DECLARE @BasisActualCpnyID varchar (10), @BasisActualYear varchar (4), @BasisActualLedger varchar (10)

DECLARE @Acct varchar(10), @AcctDescr varchar (30), @AcctType varchar (2), @BasisBudgetYTDEstimated float, @BudgetYTDEstimated float,
	@Sub varchar (24), @BasisBudgetAnnBdgt float, @BudgetAnnBdgt float, @BdgtSegmentGroup varchar (24)
	DECLARE @BasisActualPTDBal00 float, @BasisActualPTDBal01 float, @BasisActualPTDBal02 float, @BasisActualPTDBal03 float,
        @BasisActualPTDBal04 float, @BasisActualPTDBal05 float, @BasisActualPTDBal06 float, @BasisActualPTDBal07 float,
        @BasisActualPTDBal08 float, @BasisActualPTDBal09 float, @BasisActualPTDBal10 float, @BasisActualPTDBal11 float,
	@BasisActualPTDBal12 float

DECLARE @BasisActualYTDBal00 float, @BasisActualYTDBal01 float, @BasisActualYTDBal02 float, @BasisActualYTDBal03 float,
        @BasisActualYTDBal04 float, @BasisActualYTDBal05 float, @BasisActualYTDBal06 float, @BasisActualYTDBal07 float,
        @BasisActualYTDBal08 float, @BasisActualYTDBal09 float, @BasisActualYTDBal10 float, @BasisActualYTDBal11 float,
	@BasisActualYTDBal12 float

DECLARE @BasisBudgetPTDBal00 float, @BasisBudgetPTDBal01 float, @BasisBudgetPTDBal02 float, @BasisBudgetPTDBal03 float,
        @BasisBudgetPTDBal04 float, @BasisBudgetPTDBal05 float, @BasisBudgetPTDBal06 float, @BasisBudgetPTDBal07 float,
        @BasisBudgetPTDBal08 float, @BasisBudgetPTDBal09 float, @BasisBudgetPTDBal10 float, @BasisBudgetPTDBal11 float,
	@BasisBudgetPTDBal12 float
	DECLARE @BasisBudgetYTDBal00 float, @BasisBudgetYTDBal01 float, @BasisBudgetYTDBal02 float, @BasisBudgetYTDBal03 float,
        @BasisBudgetYTDBal04 float, @BasisBudgetYTDBal05 float, @BasisBudgetYTDBal06 float, @BasisBudgetYTDBal07 float,
        @BasisBudgetYTDBal08 float, @BasisBudgetYTDBal09 float, @BasisBudgetYTDBal10 float, @BasisBudgetYTDBal11 float,
	@BasisBudgetYTDBal12 float

DECLARE @BudgetPTDBal00 float, @BudgetPTDBal01 float, @BudgetPTDBal02 float, @BudgetPTDBal03 float,
        @BudgetPTDBal04 float, @BudgetPTDBal05 float, @BudgetPTDBal06 float, @BudgetPTDBal07 float,
        @BudgetPTDBal08 float, @BudgetPTDBal09 float, @BudgetPTDBal10 float, @BudgetPTDBal11 float,
	@BudgetPTDBal12 float

DECLARE @BudgetYTDBal00 float, @BudgetYTDBal01 float, @BudgetYTDBal02 float, @BudgetYTDBal03 float,
        @BudgetYTDBal04 float, @BudgetYTDBal05 float, @BudgetYTDBal06 float, @BudgetYTDBal07 float,
        @BudgetYTDBal08 float, @BudgetYTDBal09 float, @BudgetYTDBal10 float, @BudgetYTDBal11 float,
	@BudgetYTDBal12 float

DECLARE @i smallint, @RetEarnAcct varchar(10), @YtdNetIncAcct varchar (10)
DECLARE @TranStatus smallint, @FetchStatus smallint

--SELECT @BudgetYear = RTRIM(LTRIM(LongAnswer00)), @BudgetLedger = RTRIM(LTRIM(LongAnswer01)),
--       @CpnyID = CpnyID From RptRuntime Where RI_ID = @RI_ID

--Upate RI_WHERE with RI_ID restriction (to prevent duplicate records at a multi-company site:
DECLARE @RI_Where varchar(1024), @Search varchar(1024), @Pos SMALLINT

SELECT @RI_Where = LTRIM(RTRIM(RI_Where)), @BudgetYear = RTRIM(LTRIM(LongAnswer00)),
	@BudgetLedger = RTRIM(LTRIM(LongAnswer01)), @CpnyID = CpnyID
FROM RptRunTime
WHERE RI_ID = @RI_ID

SELECT @Search = "({WrkBudgetDetail.RI_ID} = " + RTRIM(CONVERT(VARCHAR(6), @RI_ID)) + ")"

SELECT @Pos = PATINDEX("%" + @Search + "%", @RI_Where)

UPDATE RptRunTime SET RI_Where = CASE
	WHEN @RI_Where IS NULL OR DATALENGTH(@RI_Where) <= 0
		THEN @Search
	WHEN @Pos = 0
		THEN @Search + " AND (" + @RI_WHERE + ")"
	ELSE
             @Search
	END
WHERE RI_ID = @RI_ID

If (RTRIM(LTRIM(ISNULL(@BudgetYear, ''))) = '')
	SELECT @BudgetYear = BudgetYear From GLSetup

If (RTRIM(LTRIM(ISNULL(@BudgetLedger, ''))) = '')
	SELECT @BudgetLedger = BudgetLedgerID From GLSetup

SELECT @RetEarnAcct = RetEarnAcct,
	@YTDNetIncAcct = YTDNetIncAcct From GLSetup

SELECT @BasisActualCpnyID = RTRIM(LTRIM(IsNull(SrcCpnyID, ''))), @BasisActualYear = RTRIM(LTRIM(IsNull(S4Future12, ''))), @BasisActualLedger = RTRIM(LTRIM(IsNull(Source,''))),
       @BasisBudgetCpnyId = RTRIM(LTRIM(IsNull(S4Future02, ''))), @BasisBudgetYear = RTRIM(LTRIM(IsNull(S4Future01, ''))), @BasisBudgetLedger = RTRIM(LTRIM(IsNull(S4Future11,'')))
       From Budget_Version Where BudgetLedgerID = @BudgetLedger AND BudgetYear = @BudgetYear AND
       CpnyID = @CpnyID

SELECT @BasisActualCpnyID = IsNull(@BasisActualCpnyID, ''), @BasisActualYear = IsNull(@BasisActualYear, ''), @BasisActualLedger = IsNull(@BasisActualLedger, ''),
    @BasisBudgetCpnyID = IsNull(@BasisBudgetCpnyID, ''), @BasisBudgetYear = IsNull(@BasisBudgetYear, ''), @BasisBudgetLedger = IsNull(@BasisBudgetLedger, '')

PRINT 'Basis Actual: ' + @BasisActualCpnyID + ' ' + @BasisActualYear + '  ' + @BasisActualLedger
PRINT 'Basis Budget: ' + @BasisBudgetCpnyID + ' ' + @BasisBudgetYear + '  ' + @BasisBudgetLedger
PRINT 'Prop Budget:  ' + @CpnyID + ' ' + @BudgetYear + '  ' + @BudgetLedger

--IF @@FETCHSTATUS

--Fetch Segment use indicators
SELECT @BudgetSeg00 = BudgetSubSeg00, @BudgetSeg01 = BudgetSubSeg01, @BudgetSeg02 = BudgetSubSeg02, @BudgetSeg03 = BudgetSubSeg03,
       @BudgetSeg04 = BudgetSubSeg04, @BudgetSeg05 = BudgetSubSeg05, @BudgetSeg06 = BudgetSubSeg06, @BudgetSeg07 = BudgetSubSeg07
       From GLSetup

--Fetch Unused subacct segment mask fields
/*SELECT @SubSegMask00 = LTRIM(RTRIM(SubSegMask00)), @SubSegMask01 = LTRIM(RTRIM(SubSegMask01)), @SubSegMask02 = LTRIM(RTRIM(SubSegMask02)), @SubSegMask03 = LTRIM(RTRIM(SubSegMask03)),
       @SubSegMask04 = LTRIM(RTRIM(SubSegMask04)), @SubSegMask05 = LTRIM(RTRIM(SubSegMask05)), @SubSegMask06 = LTRIM(RTRIM(SubSegMask06)), @SubSegMask07 = LTRIM(RTRIM(SubSegMask07))
       From BUSetup Where CpnyID = (SELECT CpnyID From RptCompany WHERE RI_ID = @RI_ID) */

--Fetch FlexDef info for subacct
SELECT @SegLength00 = SegLength00, @SegLength01 = SegLength01, @SegLength02 = SegLength02, @SegLength03 = SegLength03,
       @SegLength04 = SegLength04, @SegLength05 = SegLength05, @SegLength06 = SegLength06, @SegLength07 = SegLength07,
       @NumSegs = NumberSegments From FlexDef Where FieldClassName = 'SUBACCOUNT'

PRINT 'Ret Earn/Net Inc. Accts: ' + @RetEarnAcct + '  ' + @YTDNetIncAcct

DECLARE CSR_AcctSub CURSOR FORWARD_ONLY STATIC READ_ONLY FOR		/*Cursor for navigating AcctHist*/
	SELECT DISTINCT Acct, Sub
        From AcctHist
        Where ((LedgerID = @BasisActualLedger AND FiscYr = @BasisActualYear AND CpnyID = @BasisActualCpnyID)
	OR (LedgerID = @BasisBudgetLedger AND FiscYr = @BasisBudgetYear AND CpnyID = @BasisBudgetCpnyID)
	OR (LedgerID = @BudgetLedger AND FiscYr = @BudgetYear AND CpnyID = @CpnyID))
	AND (Acct <> @RetEarnAcct AND Acct <> @YTDNetIncAcct)
	Order By Acct, Sub

Open CSR_AcctSub

SELECT @TranStatus = @@Error

--GET first untranslated GLTran record
IF (@TranStatus = 0)
   FETCH NEXT FROM CSR_AcctSub INTO @Acct, @Sub

    	SELECT @TranStatus = @@Error
		BEGIN TRANSACTION
		DELETE FROM WrkBudgetDetail
        WHERE  RI_ID not in
	(SELECT RI_ID FROM rptruntime (NOLOCK) WHERE reportnbr = '01780')

	DELETE FROM WrkBudgetDetail where RI_ID = @RI_ID

	--AS LONG AS more distinct combinations are left to process...
	WHILE (@@FETCH_STATUS = 0 AND @TranStatus = 0)
	   BEGIN
		--Get Account Description
		SELECT @AcctDescr = Descr, @AcctType = AcctType From Account WHERE Acct = @Acct

		--Zero out columns:
		SELECT @BasisActualPTDBal00 = 0, @BasisActualPTDBal01 =  0, @BasisActualPTDBal02 =  0, @BasisActualPTDBal03 =  0,
        	@BasisActualPTDBal04 =  0, @BasisActualPTDBal05 =  0, @BasisActualPTDBal06 =  0, @BasisActualPTDBal07 =  0,
        	@BasisActualPTDBal08 =  0, @BasisActualPTDBal09 =  0, @BasisActualPTDBal10 =  0, @BasisActualPTDBal11 =  0,
		@BasisActualPTDBal12 =  0,
 		@BasisActualYTDBal00 =  0, @BasisActualYTDBal01 =  0, @BasisActualYTDBal02 =  0, @BasisActualYTDBal03 =  0,
        	@BasisActualYTDBal04 =  0, @BasisActualYTDBal05 =  0, @BasisActualYTDBal06 =  0, @BasisActualYTDBal07 =  0,
        	@BasisActualYTDBal08 =  0, @BasisActualYTDBal09 =  0, @BasisActualYTDBal10 =  0, @BasisActualYTDBal11 =  0,
		@BasisActualYTDBal12 =  0

		SELECT @BasisBudgetPTDBal00 = 0, @BasisBudgetPTDBal01 =  0, @BasisBudgetPTDBal02 =  0, @BasisBudgetPTDBal03 =  0,
        	@BasisBudgetPTDBal04 =  0, @BasisBudgetPTDBal05 =  0, @BasisBudgetPTDBal06 =  0, @BasisBudgetPTDBal07 =  0,
        	@BasisBudgetPTDBal08 =  0, @BasisBudgetPTDBal09 =  0, @BasisBudgetPTDBal10 =  0, @BasisBudgetPTDBal11 =  0,
		@BasisBudgetPTDBal12 =  0,
 		@BasisBudgetYTDBal00 =  0, @BasisBudgetYTDBal01 =  0, @BasisBudgetYTDBal02 =  0, @BasisBudgetYTDBal03 =  0,
        	@BasisBudgetYTDBal04 =  0, @BasisBudgetYTDBal05 =  0, @BasisBudgetYTDBal06 =  0, @BasisBudgetYTDBal07 =  0,
        	@BasisBudgetYTDBal08 =  0, @BasisBudgetYTDBal09 =  0, @BasisBudgetYTDBal10 =  0, @BasisBudgetYTDBal11 =  0,
		@BasisBudgetYTDBal12 =  0

		SELECT @BudgetPTDBal00 = 0, @BudgetPTDBal01 =  0, @BudgetPTDBal02 =  0, @BudgetPTDBal03 =  0,
        	@BudgetPTDBal04 =  0, @BudgetPTDBal05 =  0, @BudgetPTDBal06 =  0, @BudgetPTDBal07 =  0,
        	@BudgetPTDBal08 =  0, @BudgetPTDBal09 =  0, @BudgetPTDBal10 =  0, @BudgetPTDBal11 =  0,
		@BudgetPTDBal12 =  0,
 		@BudgetYTDBal00 =  0, @BudgetYTDBal01 =  0, @BudgetYTDBal02 =  0, @BudgetYTDBal03 =  0,
        	@BudgetYTDBal04 =  0, @BudgetYTDBal05 =  0, @BudgetYTDBal06 =  0, @BudgetYTDBal07 =  0,
        	@BudgetYTDBal08 =  0, @BudgetYTDBal09 =  0, @BudgetYTDBal10 =  0, @BudgetYTDBal11 =  0,
		@BudgetYTDBal12 =  0

		SELECT @BasisBudgetYTDEstimated = 0, @BudgetYTDEstimated = 0,
	 	@BasisBudgetAnnBdgt = 0, @BudgetAnnBdgt = 0, @BdgtSegmentGroup = ''

		--Populate Variables with data from appropriate ledgers:
		--First Fetch Basis Actual Ledger/Cpny/Year:
	     	SELECT @BasisActualPTDBal00 = PTDBal00, @BasisActualPTDBal01 =  PTDBal01, @BasisActualPTDBal02 =  PTDBal02, @BasisActualPTDBal03 =  PTDBal03,
        	@BasisActualPTDBal04 =  PTDBal04, @BasisActualPTDBal05 =  PTDBal05, @BasisActualPTDBal06 =  PTDBal06, @BasisActualPTDBal07 =  PTDBal07,
        	@BasisActualPTDBal08 =  PTDBal08, @BasisActualPTDBal09 =  PTDBal09, @BasisActualPTDBal10 =  PTDBal10, @BasisActualPTDBal11 =  PTDBal11,
		@BasisActualPTDBal12 =  PTDBal12,
 		@BasisActualYTDBal00 =  YTDBal00, @BasisActualYTDBal01 =  YTDBal01, @BasisActualYTDBal02 =  YTDBal02, @BasisActualYTDBal03 =  YTDBal03,
        	@BasisActualYTDBal04 =  YTDBal04, @BasisActualYTDBal05 =  YTDBal05, @BasisActualYTDBal06 =  YTDBal06, @BasisActualYTDBal07 =  YTDBal07,
        	@BasisActualYTDBal08 =  YTDBal08, @BasisActualYTDBal09 =  YTDBal09, @BasisActualYTDBal10 =  YTDBal10, @BasisActualYTDBal11 =  YTDBal11,
		@BasisActualYTDBal12 =  YTDBal12
		FROM AcctHist WHERE CpnyID = @BasisActualCpnyID And Acct = @Acct And Sub = @Sub
		AND LedgerID = @BasisActualLedger AND FiscYr = @BasisActualYear

		--Next Fetch Basis Budget Ledger/Cpny/Year:
	     	SELECT @BasisBudgetPTDBal00 = PTDBal00, @BasisBudgetPTDBal01 =  PTDBal01, @BasisBudgetPTDBal02 =  PTDBal02, @BasisBudgetPTDBal03 =  PTDBal03,
        	@BasisBudgetPTDBal04 =  PTDBal04, @BasisBudgetPTDBal05 =  PTDBal05, @BasisBudgetPTDBal06 =  PTDBal06, @BasisBudgetPTDBal07 =  PTDBal07,
        	@BasisBudgetPTDBal08 =  PTDBal08, @BasisBudgetPTDBal09 =  PTDBal09, @BasisBudgetPTDBal10 =  PTDBal10, @BasisBudgetPTDBal11 =  PTDBal11,
		@BasisBudgetPTDBal12 =  PTDBal12,
 		@BasisBudgetYTDBal00 =  YTDBal00, @BasisBudgetYTDBal01 =  YTDBal01, @BasisBudgetYTDBal02 =  YTDBal02, @BasisBudgetYTDBal03 =  YTDBal03,
        	@BasisBudgetYTDBal04 =  YTDBal04, @BasisBudgetYTDBal05 =  YTDBal05, @BasisBudgetYTDBal06 =  YTDBal06, @BasisBudgetYTDBal07 =  YTDBal07,
        	@BasisBudgetYTDBal08 =  YTDBal08, @BasisBudgetYTDBal09 =  YTDBal09, @BasisBudgetYTDBal10 =  YTDBal10, @BasisBudgetYTDBal11 =  YTDBal11,
		@BasisBudgetYTDBal12 =  YTDBal12,
		@BasisBudgetAnnBdgt = AnnBdgt, @BasisBudgetYTDEstimated = YTDEstimated
		FROM AcctHist WHERE CpnyID = @BasisBudgetCpnyID And Acct = @Acct And Sub = @Sub
		AND LedgerID = @BasisBudgetLedger AND FiscYr = @BasisBudgetYear

		--Next Fetch Proposed (current) Budget Ledger/Cpny/Year:
	     	SELECT @BudgetPTDBal00 = PTDBal00, @BudgetPTDBal01 =  PTDBal01, @BudgetPTDBal02 =  PTDBal02, @BudgetPTDBal03 =  PTDBal03,
        	@BudgetPTDBal04 =  PTDBal04, @BudgetPTDBal05 =  PTDBal05, @BudgetPTDBal06 =  PTDBal06, @BudgetPTDBal07 =  PTDBal07,
        	@BudgetPTDBal08 =  PTDBal08, @BudgetPTDBal09 =  PTDBal09, @BudgetPTDBal10 =  PTDBal10, @BudgetPTDBal11 =  PTDBal11,
		@BudgetPTDBal12 =  PTDBal12,
 		@BudgetYTDBal00 =  YTDBal00, @BudgetYTDBal01 =  YTDBal01, @BudgetYTDBal02 =  YTDBal02, @BudgetYTDBal03 =  YTDBal03,
        	@BudgetYTDBal04 =  YTDBal04, @BudgetYTDBal05 =  YTDBal05, @BudgetYTDBal06 =  YTDBal06, @BudgetYTDBal07 =  YTDBal07,
        	@BudgetYTDBal08 =  YTDBal08, @BudgetYTDBal09 =  YTDBal09, @BudgetYTDBal10 =  YTDBal10, @BudgetYTDBal11 =  YTDBal11,
		@BudgetYTDBal12 =  YTDBal12,
		@BudgetAnnBdgt = AnnBdgt, @BudgetYTDEstimated = YTDEstimated
		FROM AcctHist WHERE CpnyID = @CpnyID And Acct = @Acct And Sub = @Sub
		AND LedgerID = @BudgetLedger AND FiscYr = @BudgetYear

		--Populate the BdgtSegmentGroup field with values with the segments of subaccount
		--USED by budgeting, skip unused segments:
		SET @BdgtSegmentGroup =
		   CASE @NumSegs
	   	   WHEN 8 THEN
	    		CASE @BudgetSeg00 WHEN '1' THEN RTRIM(LEFT(@Sub, @SegLength00)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg01 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + 1, @SegLength01)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg02 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + 1, @SegLength02)) + '-' ELSE '' END
    	 	   	+
	    		CASE @BudgetSeg03 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg04 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + 1, @SegLength04)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg05 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + 1, @SegLength05)) + '-' ELSE '' END
	    		+
   	    		CASE @BudgetSeg06 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + @SegLength05 + 1, @SegLength06)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg07 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + @SegLength05 + @SegLength06 + 1, @SegLength07)) + '-' ELSE '' END
		   WHEN 7 THEN
	    		CASE @BudgetSeg00 WHEN '1' THEN RTRIM(LEFT(@Sub, @SegLength00)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg01 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + 1, @SegLength01)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg02 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + 1, @SegLength02)) + '-' ELSE '' END
    	 	   	+
	    		CASE @BudgetSeg03 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg04 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + 1, @SegLength04)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg05 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + 1, @SegLength05)) + '-' ELSE '' END
	    		+
   	    		CASE @BudgetSeg06 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + @SegLength05 + 1, @SegLength06)) + '-' ELSE '' END
	   	   WHEN 6 THEN
	   		CASE @BudgetSeg00 WHEN '1' THEN RTRIM(LEFT(@Sub, @SegLength00)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg01 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + 1, @SegLength01)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg02 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + 1, @SegLength02)) + '-' ELSE '' END
    	 	   	+
	    		CASE @BudgetSeg03 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg04 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + 1, @SegLength04)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg05 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + @SegLength04 + 1, @SegLength05)) + '-' ELSE '' END
	   	   WHEN 5 THEN
	   		CASE @BudgetSeg00 WHEN '1' THEN RTRIM(LEFT(@Sub, @SegLength00)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg01 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + 1, @SegLength01)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg02 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + 1, @SegLength02)) + '-' ELSE '' END
    	 	   	+
	    		CASE @BudgetSeg03 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg04 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + @SegLength03 + 1, @SegLength04)) + '-' ELSE '' END
	   	   WHEN 4 THEN
	   		CASE @BudgetSeg00 WHEN '1' THEN RTRIM(LEFT(@Sub, @SegLength00)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg01 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + 1, @SegLength01)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg02 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + 1, @SegLength02)) + '-' ELSE '' END
    	 	   	+
	    		CASE @BudgetSeg03 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + @SegLength02 + 1, @SegLength03)) + '-' ELSE '' END
	   	   WHEN 3 THEN
	    		CASE @BudgetSeg00 WHEN '1' THEN RTRIM(LEFT(@Sub, @SegLength00)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg01 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + 1, @SegLength01)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg02 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + @SegLength01 + 1, @SegLength02)) + '-' ELSE '' END
	   	   WHEN 2 THEN
	    		CASE @BudgetSeg00 WHEN '1' THEN RTRIM(LEFT(@Sub, @SegLength00)) + '-' ELSE '' END
	    		+
	    		CASE @BudgetSeg01 WHEN '1' THEN RTRIM(SUBSTRING(@Sub, @SegLength00 + 1, @SegLength01)) + '-' ELSE '' END
	   	   ELSE --One segment, no unused segments possible
    	    		RTRIM(LEFT(@Sub, @SegLength00)) + '-'
		END  -- CASE @NumSegs

		--Remove last '-' from BdgtSegmenGroup:
		SET @BdgtSegmentGroup = LEFT(@BdgtSegmentGroup, LEN(@BdgtSegmentGroup) - 1)

		--Insert data into WrkBudgetDetail Table
		INSERT INTO WrkBudgetDetail VALUES (@Acct, @AcctDescr, @AcctType, @BasisActualCpnyID, @BasisActualLedger,
			@BasisActualPTDBal00, @BasisActualPTDBal01, @BasisActualPTDBal02, @BasisActualPTDBal03,
        		@BasisActualPTDBal04, @BasisActualPTDBal05, @BasisActualPTDBal06, @BasisActualPTDBal07,
        		@BasisActualPTDBal08, @BasisActualPTDBal09, @BasisActualPTDBal10, @BasisActualPTDBal11,
			@BasisActualPTDBal12, @BasisActualYear,
 			@BasisActualYTDBal00, @BasisActualYTDBal01, @BasisActualYTDBal02, @BasisActualYTDBal03,
        		@BasisActualYTDBal04, @BasisActualYTDBal05, @BasisActualYTDBal06, @BasisActualYTDBal07,
        		@BasisActualYTDBal08, @BasisActualYTDBal09, @BasisActualYTDBal10, @BasisActualYTDBal11,
			@BasisActualYTDBal12,
			@BasisBudgetAnnBdgt, @BasisBudgetCpnyID, @BasisBudgetLedger,
			@BasisBudgetPTDBal00, @BasisBudgetPTDBal01, @BasisBudgetPTDBal02, @BasisBudgetPTDBal03,
        		@BasisBudgetPTDBal04, @BasisBudgetPTDBal05, @BasisBudgetPTDBal06, @BasisBudgetPTDBal07,
        		@BasisBudgetPTDBal08, @BasisBudgetPTDBal09, @BasisBudgetPTDBal10, @BasisBudgetPTDBal11,
			@BasisBudgetPTDBal12, @BasisBudgetYear,
 			@BasisBudgetYTDBal00, @BasisBudgetYTDBal01, @BasisBudgetYTDBal02, @BasisBudgetYTDBal03,
        		@BasisBudgetYTDBal04, @BasisBudgetYTDBal05, @BasisBudgetYTDBal06, @BasisBudgetYTDBal07,
        		@BasisBudgetYTDBal08, @BasisBudgetYTDBal09, @BasisBudgetYTDBal10, @BasisBudgetYTDBal11,
			@BasisBudgetYTDBal12, @BasisBudgetYTDEstimated, @BdgtSegmentGroup,
			@BudgetAnnBdgt, @BudgetLedger,
			@BudgetPTDBal00, @BudgetPTDBal01, @BudgetPTDBal02, @BudgetPTDBal03,
        		@BudgetPTDBal04, @BudgetPTDBal05, @BudgetPTDBal06, @BudgetPTDBal07,
        		@BudgetPTDBal08, @BudgetPTDBal09, @BudgetPTDBal10, @BudgetPTDBal11,
			@BudgetPTDBal12, @BudgetYear,
 			@BudgetYTDBal00, @BudgetYTDBal01, @BudgetYTDBal02, @BudgetYTDBal03,
        		@BudgetYTDBal04, @BudgetYTDBal05, @BudgetYTDBal06, @BudgetYTDBal07,
        		@BudgetYTDBal08, @BudgetYTDBal09, @BudgetYTDBal10, @BudgetYTDBal11,
			@BudgetYTDBal12, @BudgetYTDEstimated, @CpnyID, @RI_ID, @Sub, NULL)

			SELECT @TranStatus = @@Error

			IF (@TranStatus = 0)
				--GET next Account/Sub combination
				FETCH NEXT FROM CSR_AcctSub INTO @Acct, @Sub
			ELSE
				ROLLBACK TRANSACTION
	   END

	   IF (@TranStatus = 0) COMMIT TRANSACTION
		DEALLOCATE CSR_AcctSub

	RETURN


