CREATE PROC APCheck_Create_Trans 
				 @accessnbr smallint, @paydate smalldatetime,
				 @CuryInfoId char(4), @CuryInfoRateType char(6),
				 @CuryInfoEffDate smalldatetime, @CuryInfoRate float,
				 @CuryInfoMultDiv char(1), @BatNbr char(10), @CpnyID char(10),  @Preview smallint, @APResult Int OUTPUT
AS
	set nocount on
		DECLARE	@basecury	smallint,
		@linenbr	smallint,
		@vocpnyid	char(10),
		@prev_vocpnyid	char(10),
		@prevvendid	char(15),
		@vmdoc_cpnyid	char(30),
		@prev_vmdoc_cpnyid	char(10),
		@vendid		char(15),
		@refnbr		char(10),
		@oldcheckrefnbr char(10),
		@checkrefnbr	char(10),
		@curline	smallint,
		@checkref	char(10),
		@user1		char(30),
		@user2		char(30),
		@currpernbr	char(6),
		@numrows	smallint,
		@multichk	smallint,
		@msg		char(255),
		@adjflag    smallint,
		@masterdocnbr char(10),
		@masterdoctype char(10),
	 	@BaseCuryID CHAR(10),
		@InsertedFirstAD smallint,
        @centralizedcash smallint,
        @vendname CHAR(60)


	SELECT @BaseCuryId = g.BaseCuryId, @centralizedcash = g.Central_Cash_Cntl
  		from Glsetup g (nolock)
	/*
	**  Read APSetup information
	*/
	SELECT	@currpernbr = currpernbr
	FROM	APSetup (nolock)
	
	
	/*
	**  Create a cursor for scanning the documents
	**  to be paid
	*/
	DECLARE csr_wrkcheck CURSOR STATIC 
	FOR
	SELECT vendid, cpnyid, linenbr, checkrefnbr, refnbr, user1, user2, multichk, adjflag, s4future01, s4future11, s4future12
	FROM	wrkchecksel
	WHERE	accessnbr = @accessnbr
	ORDER BY accessnbr, vendid, cpnyid, adjflag, doctype, refnbr


	SELECT  @prev_vocpnyid = '', 	@prevvendid = '', @prev_vmdoc_cpnyid = '', @checkref = '',	@linenbr = 0, @InsertedFirstAD = 0

	OPEN	csr_wrkcheck

	FETCH NEXT FROM csr_wrkcheck INTO @vendid, @vocpnyid, @curline, @checkrefnbr, @refnbr, @user1, @user2, @multichk, @adjflag, @vmdoc_cpnyid, @masterdoctype, @masterdocnbr

	SELECT @numrows = 0
		WHILE @@fetch_status = 0
	BEGIN
		/*
		**  On change of vendor id, get or create
		**  a temporary check record
		*/
		Select @oldcheckrefnbr = @checkrefnbr
		IF @prevvendid <> @vendid OR @multichk = 1 OR (@masterdoctype = 'VM' AND rtrim(@vmdoc_cpnyid) <> rtrim(@prev_vmdoc_cpnyid) )
		BEGIN
			SELECT 	@checkref = '',	@linenbr = 0

			/*
			**  For vendors without the multi-check option,
			**  (or with it if this is a debit adjustment)
			** find the old temporary check
			** === Debit Adjustments ???
			*/
			IF @masterdoctype <> 'VM' AND (@multichk = 0 or (@multichk = 1 and @adjflag = 1) )
			BEGIN
				SELECT @checkref = checkrefnbr
				FROM	APCheck
				WHERE	vendid = @vendid and
					APCheck.CpnyID = @Cpnyid and
					APCheck.BatNbr = @BatNbr
			END
			ELSE
				IF @masterdoctype = 'VM'  AND (@multichk = 0 or (@multichk = 1 and @adjflag = 1) )
				BEGIN
					SELECT @checkref = checkrefnbr
					FROM	APCheck
					WHERE	vendid = @vendid and
						APCheck.CpnyID = @Cpnyid and
						APCheck.BatNbr = @BatNbr and
						APCheck.S4Future01 =  @vmdoc_cpnyid
				END
			IF @checkref = ''
			BEGIN
				  Select @vendname = remitname from vendor where vendor.vendid = @vendid


				INSERT APCheck (Acct, BatNbr, BWAmt, CheckAmt, CheckLines, CheckNbr,
    					CheckOffset, CheckRefNbr, CheckType, CpnyID, Crtd_DateTime,
					Crtd_Prog, Crtd_User, CuryBWAmt, CuryCheckAmt, CuryDate, CuryDiscAmt,
    					CuryID, CuryMultDiv, CuryRate, DateEnt, DiscAmt, LUpd_DateTime,
    					LUpd_Prog, LUpd_User, NoteID, PmtMethod, S4Future01,
    					S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
    					S4Future07, S4Future08, S4Future09, S4Future10, S4Future11,
    					S4Future12, Status, Sub, User1, User2, User3, User4, User5,
    					User6, User7, User8, VendID, VendName)
				VALUES ( @user1, @BatNbr, 0, 0, case when @adjflag = 0 then 1 else 0 end, '',
					   0, @refnbr, 'CK', @CpnyID, '1/1/1900',
					   '', '', 0, 0, @CuryInfoEffDate, 0,
					   @CuryInfoId, @CuryInfoMultDiv, @CuryInfoRate, @paydate , 0, '1/1/1900',
					   '', '', 0, 'C', '',
					   '', 0, 0, 0, 0,
					   '1/1/1900', '1/1/1900', 0, 0, '',
					    '', CASE WHEN @PreView = 0 THEN 'T' ELSE 'X' END, @user2, '', '', 0, 0, '',
					    '', '1/1/1900', '1/1/1900', @VendID, @vendname)

				SELECT @checkref = @refnbr, @InsertedFirstAD = CASE WHEN @adjflag = 0 THEN 0 ELSE 1 END ---? @linenbr = -32767,

				IF @@ERROR < > 0 GOTO ABORT
				
				
				if @masterdoctype = 'VM'
				BEGIN
					UPDATE APCheck set APCheck.s4future01 = APDoc.Cpnyid,
							   APCheck.S4Future02 = @masterdoctype,
							   APCheck.S4Future11 = substring(@vmdoc_cpnyid,1,10)
						from apcheck, apdoc
						where apcheck.checkrefnbr = @refnbr
						and apdoc.doctype = @masterdoctype
						and apdoc.refnbr = @masterdocnbr
				END
				ELSE
				BEGIN
					UPDATE APCheck set APCheck.s4future01 = @vocpnyid,
							   APCheck.S4Future11 = substring(@vocpnyid,1,10)
						from apcheck
						where apcheck.checkrefnbr = @refnbr
						---and apdoc.doctype = @masterdoctype
						---and apdoc.refnbr = @masterdocnbr
					SELECT @prev_vmdoc_cpnyid = @vocpnyid
				END
			END
			ELSE IF @multichk = 0 or (@multichk = 1 and @adjflag = 0)

			BEGIN
				SELECT	@linenbr = @linenbr + 1  ---?
                                /*  Increment the line number */
			END
			END
		ELSE

		BEGIN
			SELECT	@linenbr = @linenbr + 1  ---?
                        /*  Increment the line number */
		END

		SELECT 	@prevvendid = @vendid

		IF @masterdoctype = 'VM'
		BEGIN
			SELECT @prev_vmdoc_cpnyid = @vmdoc_cpnyid, @prev_vocpnyid = @vmdoc_cpnyid
		END
		ELSE
		BEGIN
			SELECT @prev_vmdoc_cpnyid = @vocpnyid, @prev_vocpnyid = @vocpnyid
		END

		IF @checkrefnbr = '' SELECT @checkrefnbr = @checkref

		UPDATE	WrkCheckSel
		SET	checkrefnbr = @checkref
		WHERE checkrefnbr = @oldcheckrefnbr
			and accessnbr = @accessnbr

		FETCH NEXT FROM csr_wrkcheck 
		INTO @vendid, @vocpnyid, @curline, @checkrefnbr, @refnbr, @user1, @user2, @multichk, @adjflag, @vmdoc_cpnyid, @masterdoctype, @masterdocnbr
		
		IF @InsertedFirstAD = 1
			IF @prevvendid = @vendid AND @multichk = 0 BEGIN
				IF @adjflag = 0 BEGIN
					SELECT @linenbr = @linenbr + 1
					SELECT @InsertedFirstAD = 0
				END
			END
			ELSE
				SELECT @InsertedFirstAD = 0

		IF @@ERROR < > 0 GOTO ABORT
		SELECT @numrows = @numrows + 1
	END

	CLOSE csr_wrkcheck
	DEALLOCATE csr_wrkcheck
		/*
	**  Load the rounding factor for the
	**  base currency of the current cash account
	*/
	SELECT @basecury = Currncy.DecPl
	FROM	Currncy
	WHERE	CuryId = @BaseCuryid ---@CuryInfoId

	/*
	**  Update the paid vouchers with the payment amount
	*/

        UPDATE  WrkCheckSel
        SET     ---DiscTkn = round( Convert(decimal(28,3),CuryDiscTkn) * Convert(decimal(16,9),CuryRate), @basecury ),
             	DiscTkn = Convert(decimal(28,3),CuryDiscBal) * Convert(decimal(16,9),CuryRate),
             	BWAmt = Convert(decimal(28,3),CuryBWAmt) * Convert(decimal(16,9),CuryRate),
                PMTAmt = Convert(decimal(28,3),curydocbal) * Convert(decimal(16,9),curyrate) - Convert(decimal(28,3),CuryDiscBal) * Convert(decimal(16,9),CuryRate) - Convert(decimal(28,3),curyBWAmt) * Convert(decimal(16,9),curyrate)
 		---PMTAmt = Convert(decimal(28,3),CuryPmtAmt) * Convert(decimal(16,9),@CuryInfoRate)
        WHERE   accessnbr = @accessnbr
        AND     CuryMultDiv = 'M' and @BaseCuryid <> @CuryInfoId
	IF @@ERROR < > 0 GOTO ABORT

        UPDATE  WrkCheckSel
        SET     ---DiscTkn = round( Convert(decimal(28,3),CuryDiscTkn) * Convert(decimal(16,9),CuryRate), @basecury ),
             	DiscTkn = Convert(decimal(28,3),CuryDiscBal) * Convert(decimal(16,9),CuryRate),
             	BWAmt = Convert(decimal(28,3),CuryBWAmt) * Convert(decimal(16,9),CuryRate),
                PMTAmt = Convert(decimal(28,3),curydocbal) * Convert(decimal(16,9),curyrate)- Convert(decimal(28,3),CuryDiscBal) * Convert(decimal(16,9),CuryRate) - Convert(decimal(28,3),curyBWAmt) * Convert(decimal(16,9),curyrate)
 		---PMTAmt = Convert(decimal(28,3),CuryPmtAmt) * Convert(decimal(16,9),@CuryInfoRate)- Convert(decimal(28,3),CuryDiscBal) * Convert(decimal(16,9),CuryRate)
        WHERE   accessnbr = @accessnbr
        AND     CuryMultDiv = 'M' and @BaseCuryid = @CuryInfoId
	IF @@ERROR < > 0 GOTO ABORT

       UPDATE  WrkCheckSel
        SET     DiscTkn = Convert(decimal(28,3),CuryDiscBal) / Convert(decimal(16,9),CuryRate),
				BWAmt = Convert(decimal(28,3),CuryBWAmt) / Convert(decimal(16,9),CuryRate),
                PMTAmt = Convert(decimal(28,3),curydocbal) / Convert(decimal(16,9),curyrate)- Convert(decimal(28,3),CuryDiscBal) / Convert(decimal(16,9),CuryRate) - Convert(decimal(28,3),curyBWAmt) / Convert(decimal(16,9),curyrate)
        WHERE   accessnbr = @accessnbr
        AND     CuryMultDiv = 'D' and @BaseCuryid <> @CuryInfoId
	IF @@ERROR < > 0 GOTO ABORT

        UPDATE  WrkCheckSel
        SET     ---DiscTkn = round( Convert(decimal(28,3),CuryDiscTkn) / Convert(decimal(16,9),CuryRate), @basecury ),
                ---PMTAmt = Convert(decimal(28,3),CuryPmtAmt) / Convert(decimal(16,9),@CuryInfoRate)- Convert(decimal(28,3),CuryDiscBal) / Convert(decimal(16,9),CuryRate),
             	DiscTkn = Convert(decimal(28,3),CuryDiscBal) / Convert(decimal(16,9),CuryRate),
                PMTAmt = Convert(decimal(28,3),curydocbal) / Convert(decimal(16,9),curyrate)- Convert(decimal(28,3),CuryDiscBal) / Convert(decimal(16,9),CuryRate) - Convert(decimal(28,3),curyBWAmt) / Convert(decimal(16,9),curyrate)---round(Convert(decimal(28,3),CuryPmtAmt) * Convert(decimal(16,9),@CuryInfoRate), @basecury )
        WHERE   accessnbr = @accessnbr
        AND     CuryMultDiv = 'D' and @BaseCuryid = @CuryInfoId
	IF @@ERROR < > 0 GOTO ABORT

	/*
	**  Create the temporary tran records for the selected vouchers
	*/
	INSERT	APCheckDet ( BatNbr, BWAmt, CheckRefNbr, CpnyID, Crtd_DateTime, Crtd_Prog,
    					Crtd_User, CuryBWAmt, CuryDiscAmt, CuryGrossAmt, CuryID, CuryMultDiv,
					CuryPmtAmt, CuryRate, DiscAmt, DocType, GrossAmt,
    					LUpd_DateTime, LUpd_Prog, LUpd_User, PmtAmt,
    					RefNbr, S4Future01, S4Future02, S4Future03, S4Future04,
    					S4Future05, S4Future06, S4Future07, S4Future08, S4Future09,
    					S4Future10, S4Future11, S4Future12, StubLine, User1, User2,
    					User3, User4, User5, User6, User7, User8, tstamp)

	 SELECT @BatNbr, WrkCheckSel.BWAmt, WrkCheckSel.CheckRefNbr, WrkCheckSel.cpnyid, '1/1/1900', '',
			'', WrkCheckSel.CuryBWAmt ,WrkCheckSel.CuryDiscTkn, 0, WrkCheckSel.CuryId, WrkCheckSel.CuryMultDiv,
			WrkCheckSel.CuryPmtAmt, WrkCheckSel.CuryRate, WrkCheckSel.DiscTkn, WrkCheckSel.DocType, 0,
			'1/1/1900', '', '', WrkCheckSel.PmtAmt,
			WrkCheckSel.RefNbr, '', '', 0, 0,
			0, 0, '1/1/1900', '1/1/1900', 0,
			0, '', '', 0, WrkCheckSel.User1, WrkCheckSel.User2,
			WrkCheckSel.User3, WrkCheckSel.User4, WrkCheckSel.User5, WrkCheckSel.User6, WrkCheckSel.User7, WrkCheckSel.User8, NULL

	FROM	WrkCheckSel
	WHERE	AccessNbr = @accessnbr
	AND	AdjFlag = 0 --- Not an 'AD'
	IF @@ERROR < > 0 GOTO ABORT

	INSERT	APCheckDet ( BatNbr, BWAmt, CheckRefNbr, CpnyID, Crtd_DateTime, Crtd_Prog,
    					Crtd_User, CuryBWAmt, CuryDiscAmt, CuryGrossAmt, CuryID, CuryMultDiv,
					CuryPmtAmt, CuryRate, DiscAmt, DocType, GrossAmt,
    					LUpd_DateTime, LUpd_Prog, LUpd_User, PmtAmt,
    					RefNbr, S4Future01, S4Future02, S4Future03, S4Future04,
    					S4Future05, S4Future06, S4Future07, S4Future08, S4Future09,
    					S4Future10, S4Future11, S4Future12, StubLine, User1, User2,
    					User3, User4, User5, User6, User7, User8, tstamp)

	 SELECT @BatNbr, -1*WrkCheckSel.BWAmt, WrkCheckSel.CheckRefNbr, WrkCheckSel.cpnyid, '1/1/1900', '',
			'', -1*WrkCheckSel.CuryBWAmt, -1*WrkCheckSel.CuryDiscTkn, 0, WrkCheckSel.CuryId, WrkCheckSel.CuryMultDiv,
			-1*WrkCheckSel.CuryPmtAmt, WrkCheckSel.CuryRate, -1*WrkCheckSel.DiscTkn, WrkCheckSel.DocType, 0,
			'1/1/1900', '', '', -1*WrkCheckSel.PmtAmt,
			WrkCheckSel.RefNbr, '', '', 0, 0,
			0, 0, '1/1/1900', '1/1/1900', 0,
			0, '', '', 0, WrkCheckSel.User1, WrkCheckSel.User2,
			WrkCheckSel.User3, WrkCheckSel.User4, WrkCheckSel.User5, WrkCheckSel.User6, WrkCheckSel.User7, WrkCheckSel.User8, NULL

	FROM	WrkCheckSel
	WHERE	AccessNbr = @accessnbr
	AND	AdjFlag = 1  --- an 'AD' doc
	IF @@ERROR < > 0 GOTO ABORT

SELECT @APResult = 1
GOTO FINISH

ABORT:
SELECT @APResult = 0

FINISH:

-- Bug 14715 Update APCheck.Checklines after all processing is done
-- Bug 19131 Make sure group by is by batnbr as well.

update apcheck
	set apcheck.checklines = checklinecount
	from apcheck join (select checklinecount = count(*), checkrefnbr, batnbr
						from apcheckdet
						group by checkrefnbr, batnbr) apchkcnt
    on apcheck.checkrefnbr =  apchkcnt.checkrefnbr
   and apcheck.batnbr      =  apchkcnt.batnbr

