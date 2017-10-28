CREATE PROC APCheck_Apply_MultiCheck_DM @accessnbr smallint,  @batnbr char(10),  @Preview smallint, @APResult Int OUTPUT
AS
	set nocount on
	DECLARE	@APDoc_DiscTkn float, @APDoc_PmtAmt float, @APDoc_CuryDiscTkn float,
		@APDoc_CuryMultDiv char(1), @APDoc_CuryRate float,
		@APDoc_CuryPmtAmt float, @APDoc_Selected smallint, @APDoc_VendId char(15),
		@WrkCheckSel_ApplyRefnbr char(10), @WrkCheckSel_DiscTkn float, @WrkCheckSel_PmtAmt float,
		@WrkCheckSel_CuryDiscTkn float, @WrkCheckSel_CuryPmtAmt float,
		@WrkCheckSel_DocType char(2), @WrkCheckSel_RefNbr char(10),
		@APCheck_OrigDocAmt float, @APCheck_CuryOrigDocAmt float, @APCheck_DiscBal float,
		@APCheck_CuryDiscBal float, @APCheck_Selected smallint, @APCheck_Vendid char(15),
		@APCheck_LineCntr smallint, @WrkCheckSel_Multichk smallint, @WrkCheckSel_CheckRefNbr char(10),
		@APCheck_CheckRefNbr char(15), @APCheck_CuryDiscTkn float,
		@APCheck_DiscTkn float,
		@WrkCheckSel_DocDesc char(30), @WrkCheckSel_User1 char(30), @WrkCheckSel_User2 char(30),
		@WrkCheckSel_User3 float, @WrkCheckSel_User4 float, @WrkCheckSel_User5 char(10), @WrkCheckSel_User6 char(10),
		@WrkCheckSel_User7 smalldatetime, @WrkCheckSel_User8 smalldatetime, @WrkCheckSel_CpnyID char(10), @WrkCheckSel_CuryId char(6),
		@WrkCheckSel_PayDate smalldatetime

	DECLARE	@Amount_Applied float, @Cury_Amount_Applied float,
		@This_Amount float, @Cury_This_Amount float,
		@DiscTkn float, @Cury_DiscTkn float, @This_Disc float, @Cury_This_Disc float
		
	DECLARE	@ErrorValue integer, @CheckDets_Deleted integer

	DECLARE	@msg char(255)

	/*
	**  Declare a cursor to join the selected checks table to the work tables,
	**  and perform updates
	*/
	DECLARE csr_update_docs CURSOR FOR
	SELECT	APDoc.DiscTkn, APDoc.PmtAmt, APDoc.CuryDiscTkn,
		 APDoc.CuryMultDiv, APDoc.CuryRate, APDoc.CuryPmtAmt,APDoc.Selected, APDoc.VendId,
		WrkCheckSel.ApplyRefNbr, WrkCheckSel.DiscTkn, WrkCheckSel.PmtAmt, WrkCheckSel.DocType, WrkCheckSel.RefNbr,
		WrkCheckSel.CuryDiscTkn, WrkCheckSel.CuryPmtAmt, WrkCheckSel.MultiChk, WrkCheckSel.CheckRefNbr,
		WrkCheckSel.DocDesc, WrkCheckSel.User1, WrkCheckSel.User2, WrkCheckSel.User3, WrkCheckSel.User4,
		WrkCheckSel.User5, WrkCheckSel.User6, WrkCheckSel.User7, WrkCheckSel.User8, WrkCheckSel.CpnyID,
		WrkCheckSel.CuryId, WrkCheckSel.PayDate
	FROM	APDoc, WrkCheckSel
	WHERE	WrkCheckSel.Accessnbr = @Accessnbr
	AND	APDoc.Acct = WrkCheckSel.Acct
	AND	APDoc.Sub = WrkCheckSel.Sub
	AND	APDoc.DocType = WrkCheckSel.DocType
	AND	APDoc.RefNbr = WrkCheckSel.RefNbr
	AND	WrkCheckSel.AdjFlag = 1
	AND	WrkCheckSel.MultiChk = 1
	ORDER BY WrkCheckSel.accessnbr, WrkCheckSel.vendid, WrkCheckSel.adjflag,
		 WrkCheckSel.doctype, WrkCheckSel.refnbr
	FOR UPDATE OF APDoc.DiscTkn, APDoc.PmtAmt, APDoc.CuryDiscTkn, APDoc.CuryPmtAmt, APDoc.Selected

	OPEN	csr_update_docs

	/*
	**  Set voucher and adjustment records to 'selected',
	**  and set the discount and payment amounts
	*/
	FETCH NEXT FROM csr_update_docs INTO @APDoc_DiscTkn, @APDoc_PmtAmt, @APDoc_CuryDiscTkn,
		@APDoc_CuryMultDiv, @APDoc_Curyrate, @APDoc_CuryPmtAmt, @APDoc_Selected, @APDoc_VendId,
		@WrkCheckSel_ApplyRefnbr, @WrkCheckSel_DiscTkn, @WrkCheckSel_PmtAmt, @WrkCheckSel_DocType, @WrkCheckSel_RefNbr,
		@WrkCheckSel_CuryDiscTkn, @WrkCheckSel_CuryPmtAmt, @WrkCheckSel_MultiChk, @WrkCheckSel_CheckRefNbr,
		@WrkCheckSel_DocDesc, @WrkCheckSel_User1, @WrkCheckSel_User2, @WrkCheckSel_User3,
		@WrkCheckSel_User4, @WrkCheckSel_User5, @WrkCheckSel_User6, @WrkCheckSel_User7,
		@WrkCheckSel_User8, @WrkCheckSel_CpnyId, @WrkCheckSel_CuryId, @WrkCheckSel_PayDate

	WHILE @@fetch_status = 0
	BEGIN
		SELECT	@APDoc_Selected = 0, @Amount_Applied = 0, @Cury_Amount_Applied = 0
		SELECT	@DiscTkn = 0, @Cury_DiscTkn = 0

		/*
		**  Delete the temporary APTran record for the adjustment,
		**  new adjustment records will be created below
		*/
		DELETE FROM APCheckDet
		WHERE	APCheckDet.DocType = @WrkCheckSel_DocType
		AND	APCheckDet.RefNbr = @WrkCheckSel_RefNbr

		SELECT @ErrorValue = @@error, @CheckDets_Deleted = @@rowcount
		
		IF @ErrorValue < > 0 GOTO ABORT
		
		UPDATE APCheck
			SET APCheck.CheckLines = APCheck.CheckLines - @CheckDets_Deleted
		WHERE
		APCheck.BatNbr = @batnbr
		AND	APCheck.VendId = @APDoc_VendId
		AND	APCheck.CheckRefNbr = @WrkCheckSel_CheckRefNbr
		
		IF @@ERROR < > 0 GOTO ABORT

		/*
		** If the applyrefnbr field is set on an 'AD' doc, apply this debit adjustment to
		** a specific voucher.  See if this voucher is included on a check in this run by looking
		** through the APCheckDet records for the voucher's refnbr.  If it exists, retreive the
		** APCheck that goes with this APCheckDet record, otherwise skip his 'AD' doc and fetch the
		** next record.
		*/
			IF @WrkCheckSel_ApplyRefNbr <> ''
		BEGIN
			SELECT @WrkCheckSel_CheckRefNbr = 'XXXXXX' --set so if the following doesn't find the check to apply to, the AD won't be applied

			SELECT
				@WrkCheckSel_CheckRefNbr = APCheckDet.CheckRefNbr
			FROM	APCheckDet
			WHERE
			APCheckDet.BatNbr = @batnbr
			AND	APCheckDet.RefNbr = @WrkCheckSel_ApplyRefNbr
		END
		ELSE
		BEGIN
			SELECT @WrkCheckSel_CheckRefNbr = ''
		END

		/*
		**  Open a cursor for checks for this vendor
		*/
		IF @WrkCheckSel_CheckRefNbr = ''
		BEGIN
			DECLARE csr_update_checks CURSOR FOR
			SELECT	APCheck.DiscAmt,
				APCheck.CheckAmt,
				APCheck.CuryDiscAmt,
				APCheck.CuryCheckAmt,
				APCheck.CheckLines,
				APCheck.VendId,
				APCheck.CheckRefNbr
			FROM	APCheck
			WHERE	---APDoc.Acct = ''
			---AND	APDoc.Sub = ''
			---AND	APDoc.doctype = 'CK'
			---AND	APDoc.RefNbr = ''
			---AND
			APCheck.BatNbr = @batnbr
			---AND	APDoc.Status = 'T'
			AND	APCheck.VendId = @APDoc_VendId

			FOR UPDATE OF APCheck.CheckAmt, APCheck.DiscAmt, APCheck.CuryDiscAmt, APCheck.CuryCheckAmt, APCheck.CheckLines
		END
		ELSE
		/** The doc to apply this AD to is not in this check batch, so delete
		**  the check for the AD
		**/
		IF @WrkCheckSel_CheckRefNbr = 'XXXXXX'
		BEGIN
			DELETE FROM APCheck
			WHERE
					APCheck.BatNbr = @batnbr
					AND	APCheck.VendId = @APDoc_VendId
					AND	APCheck.CheckRefNbr = @WrkCheckSel_RefNbr

			UPDATE APDoc
				SET APDoc.Selected = 0
			WHERE CURRENT OF csr_update_docs

			GOTO NEXTDOC
		END

		ELSE
		BEGIN
			DECLARE csr_update_checks CURSOR FOR
			SELECT	APCheck.DiscAmt,
				APCheck.CheckAmt,
				APCheck.CuryDiscAmt,
				APCheck.CuryCheckAmt,
				APCheck.CheckLines,
				APCheck.VendId,
				APCheck.CheckRefNbr
			FROM	APCheck
			WHERE	---APDoc.Acct = ''
			---AND	APDoc.Sub = ''
			---AND	APDoc.doctype = 'CK'
			---AND	APDoc.RefNbr = ''
			---AND
			APCheck.BatNbr = @batnbr
			---AND	APDoc.Status = 'T'
			AND	APCheck.VendId = @APDoc_VendId
			AND APCheck.CheckRefNbr = @WrkCheckSel_CheckRefNbr
			FOR UPDATE OF APCheck.CheckAmt, APCheck.DiscAmt, APCheck.CuryDiscAmt, APCheck.CuryCheckAmt, APCheck.CheckLines
		END

		OPEN	csr_update_checks

		FETCH NEXT FROM csr_update_checks
		INTO	@APCheck_DiscBal, @APCheck_OrigDocAmt, @APCheck_CuryDiscBal,
			@APCheck_CuryOrigDocAmt, @APCheck_LineCntr, @APCheck_VendId,
			@APCheck_CheckRefNbr

		WHILE	@@fetch_status = 0 AND @Cury_Amount_Applied < @WrkCheckSel_CuryPmtAmt
		BEGIN
			/*
			**  If the check has an amount left, apply the debit memo to it
			*/
			IF @APCheck_CuryOrigDocAmt > 0
			BEGIN
				SELECT	@APDoc_Selected = 1

				/*
				**  Take the lesser of the check amount, or the amount left to apply
				*/
				IF (@WrkCheckSel_CuryPmtAmt - @Cury_Amount_Applied) >= @APCheck_CuryOrigDocAmt
				BEGIN
					SELECT	@Cury_This_Amount = @APCheck_CuryOrigDocAmt,
						@This_Amount = @APCheck_OrigDocAmt

					SELECT	@APCheck_OrigDocAmt = 0,
						@APCheck_CuryOrigDocAmt = 0
				END
				ELSE
				BEGIN
					SELECT	@Cury_This_Amount = (convert(dec(28,3),@WrkCheckSel_CuryPmtAmt) - convert(dec(28,3),@Cury_Amount_Applied)),
						@This_Amount = (convert(dec(28,3),@WrkCheckSel_PmtAmt) - convert(dec(28,3),@Amount_Applied))

					SELECT	@APCheck_OrigDocAmt = convert(dec(28,3),@APCheck_OrigDocAmt) - convert(dec(28,3),@This_Amount),
						@APCheck_CuryOrigDocAmt = convert(dec(28,3),@APCheck_CuryOrigDocAmt) - convert(dec(28,3),@Cury_This_Amount)
				END

				SELECT	@Cury_Amount_Applied = convert(dec(28,3),@Cury_Amount_Applied) + convert(dec(28,3),@Cury_This_Amount),
				 	@Amount_Applied = convert(dec(28,3),@Amount_Applied) + convert(dec(28,3),@This_Amount)

				/*
				**  Calculate the debit memo discount
				*/
				IF (@WrkCheckSel_CuryDiscTkn - @Cury_DiscTkn) >= @APCheck_CuryDiscBal
				BEGIN
					SELECT	@Cury_This_Disc = @APCheck_CuryDiscBal,
						@This_Disc = @APCheck_DiscBal

					SELECT	@APCheck_DiscBal = 0,
						@APCheck_CuryDiscBal = 0
				END
				ELSE
				BEGIN
					SELECT	@Cury_This_Disc = (@WrkCheckSel_CuryDiscTkn - @Cury_DiscTkn),
						@This_Disc = (@WrkCheckSel_DiscTkn - @DiscTkn)

					SELECT	@APCheck_DiscBal = @APCheck_DiscBal - @This_Disc,
						@APCheck_CuryDiscBal = @APCheck_CuryDiscBal - @Cury_This_Disc
				END

				SELECT	@Cury_DiscTkn = @Cury_DiscTkn + @Cury_This_Disc,
				 	@DiscTkn = @DiscTkn + @This_Disc

				UPDATE	APCheck
				SET	CheckAmt = @APCheck_OrigDocAmt,
					CuryCheckAmt = @APCheck_CuryOrigDocAmt,
					CuryDiscAmt = @APCheck_CuryDiscBal,
					DiscAmt = @APCheck_DiscBal,
					CheckLines =  CheckLines+1 ---@APCheck_LineCntr + 1
				WHERE CURRENT OF csr_update_checks
				IF @@ERROR < > 0 GOTO ABORT
				/*
				**  Switch sign of the debit amounts for the tran records
				*/
				SELECT	@This_Amount = -1 * @This_Amount,
					@Cury_This_Amount = -1 * @Cury_This_Amount,
					@This_Disc = -1 * @This_Disc,
					@Cury_This_Disc = -1 * @Cury_This_Disc

				/*
				**  Create a tran record for the application
				*/
				INSERT	APCheckDet ( BatNbr, BWAmt, CheckRefNbr, CpnyID, Crtd_DateTime, Crtd_Prog,
    					Crtd_User, CuryBWAmt, CuryDiscAmt, CuryGrossAmt, CuryID, CuryMultDiv,
					CuryPmtAmt, CuryRate, DiscAmt, DocType, GrossAmt,
    					LUpd_DateTime, LUpd_Prog, LUpd_User, PmtAmt,
    					RefNbr, S4Future01, S4Future02, S4Future03, S4Future04,
    					S4Future05, S4Future06, S4Future07, S4Future08, S4Future09,
    					S4Future10, S4Future11, S4Future12, Stubline, User1, User2,
    					User3, User4, User5, User6, User7, User8, tstamp)

	 			SELECT @BatNbr,0, @APCheck_CheckRefNbr, @WrkCheckSel_cpnyid, '1/1/1900', '',
					'', 0, @Cury_This_Disc, 0, @WrkCheckSel_CuryId, @APDoc_CuryMultDiv,
					@Cury_This_Amount, @APDoc_CuryRate, @This_Disc, 'AD', 0,
					'1/1/1900', '', '', @This_Amount,
					@WrkCheckSel_RefNbr, '', '', 0, 0,
					0, 0, '1/1/1900', '1/1/1900', 0,
					0, '', '', 0, @WrkCheckSel_User1, @WrkCheckSel_User2,
					@WrkCheckSel_User3, @WrkCheckSel_User4, @WrkCheckSel_User5, @WrkCheckSel_User6, @WrkCheckSel_User7, @WrkCheckSel_User8, NULL

				IF @@ERROR < > 0 GOTO ABORT

			END


			FETCH NEXT FROM csr_update_checks
			INTO	@APCheck_DiscBal, @APCheck_OrigDocAmt, @APCheck_CuryDiscBal,
				@APCheck_CuryOrigDocAmt, @APCheck_LineCntr, @APCheck_VendId,
				@APCheck_CheckRefNbr
		END

		CLOSE csr_update_checks
		DEALLOCATE csr_update_checks

		if @Preview = 0
			BEGIN
			/*
			**  Update the debit adjustment record with the amount applied
			*/
			IF @APDoc_Selected = 1
			BEGIN
				UPDATE APDoc
					SET APDoc.DiscTkn = @DiscTkn,
					    APDoc.PmtAmt = @Amount_Applied,
					    APDoc.CuryDiscTkn = @Cury_DiscTkn,
					    APDoc.CuryPmtAmt = @Cury_Amount_Applied,
					    APDoc.Selected = 1
				WHERE CURRENT OF csr_update_docs
			END
			ELSE
			BEGIN
				UPDATE APDoc
					SET APDoc.Selected = 0
				WHERE CURRENT OF csr_update_docs
			END
			IF @@ERROR < > 0 GOTO ABORT
		END
		/*
		**  Next debit adjustment
		*/
NEXTDOC:
		FETCH NEXT FROM csr_update_docs INTO @APDoc_DiscTkn, @APDoc_PmtAmt, @APDoc_CuryDiscTkn,
			@APDoc_CuryMultDiv, @APDoc_CuryRate, @APDoc_CuryPmtAmt, @APDoc_Selected, @APDoc_VendId,
			@WrkCheckSel_ApplyRefnbr, @WrkCheckSel_DiscTkn, @WrkCheckSel_PmtAmt, @WrkCheckSel_DocType, @WrkCheckSel_RefNbr,
			@WrkCheckSel_CuryDiscTkn, @WrkCheckSel_CuryPmtAmt, @WrkCheckSel_MultiChk, @WrkCheckSel_CheckRefNbr,
			@WrkCheckSel_DocDesc, @WrkCheckSel_User1, @WrkCheckSel_User2, @WrkCheckSel_User3,
			@WrkCheckSel_User4, @WrkCheckSel_User5, @WrkCheckSel_User6, @WrkCheckSel_User7,
			@WrkCheckSel_User8, @WrkCheckSel_CpnyId, @WrkCheckSel_CuryId, @WrkCheckSel_PayDate
	END

	CLOSE csr_update_docs
	DEALLOCATE csr_update_docs

SELECT @APResult = 1
GOTO FINISH

ABORT:
SELECT @APResult = 0

FINISH:

