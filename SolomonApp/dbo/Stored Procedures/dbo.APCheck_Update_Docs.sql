CREATE PROC APCheck_Update_Docs 
@accessnbr smallint, @batnbr char(10),  @Preview smallint, @APResult Int OUTPUT
AS
	set nocount on
	DECLARE	@APDoc_DiscTkn float, @APDoc_PmtAmt float, @APDoc_CuryDiscTkn float,
		@APDoc_CuryPmtAmt float, @APDoc_Selected smallint, @APDoc_VendId char(15),
		@WrkCheckSel_ApplyRefnbr char(10), @WrkCheckSel_DiscTkn float, @WrkCheckSel_PmtAmt float,
		@WrkCheckSel_CuryDiscTkn float, @WrkCheckSel_CuryPmtAmt float,
		@WrkCheckSel_DocType char(2), @WrkCheckSel_RefNbr char(10),
		@APCheck_OrigDocAmt float, @APCheck_CuryOrigDocAmt float, @APCheck_DiscBal float,
		@APCheck_CuryDiscBal float, @APCheck_Selected smallint, @APCheck_Vendid char(15),
		@APCheck_LineCntr int, @WrkCheckSel_Multichk smallint, @WrkCheckSel_CheckRefNbr char(10),
		@APCheck_CheckRefNbr char(15), @Apply_Multichk_DM smallint , @APCheck_BWAmt float , @APCheck_CuryBWAmt float,
		@WrkCheckSel_BWAmt Float, @WrkCheckSel_CuryBWAmt float

	DECLARE	@msg char(255)

	SELECT	@Apply_Multichk_DM = 0



	/*
	**  Declare a cursor to join the selected checks (???docs?) table to the work tables,
	**  and perform updates
	*/
	DECLARE csr_update_docs CURSOR STATIC
	FOR
	SELECT	APDoc.DiscTkn, APDoc.PmtAmt, APDoc.CuryDiscTkn,
		APDoc.CuryPmtAmt, APDoc.Selected, APDoc.VendId, WrkCheckSel.ApplyRefnbr,
		WrkCheckSel.DiscTkn, WrkCheckSel.PmtAmt, WrkCheckSel.DocType, WrkCheckSel.RefNbr,
		WrkCheckSel.CuryDiscTkn, WrkCheckSel.CuryPmtAmt, WrkCheckSel.MultiChk, WrkCheckSel.CheckRefNbr, WrkCheckSel.BWAmt, WrkCheckSel.CuryBWAmt
	FROM	APDoc, WrkCheckSel
	WHERE	WrkCheckSel.Accessnbr = @Accessnbr
	AND	APDoc.Acct = WrkCheckSel.Acct
	AND	APDoc.Sub = WrkCheckSel.Sub
	AND	APDoc.DocType = WrkCheckSel.DocType
	AND	APDoc.RefNbr = WrkCheckSel.RefNbr
	ORDER BY WrkCheckSel.accessnbr, WrkCheckSel.vendid, WrkCheckSel.adjflag,
		 WrkCheckSel.doctype, WrkCheckSel.refnbr

	OPEN	csr_update_docs

	/*
	**  Set voucher and adjustment records discount and payment amounts
	*/
	FETCH NEXT FROM csr_update_docs INTO @APDoc_DiscTkn, @APDoc_PmtAmt, @APDoc_CuryDiscTkn,
		@APDoc_CuryPmtAmt, @APDoc_Selected, @APDoc_VendId, @WrkCheckSel_ApplyRefNbr,
		@WrkCheckSel_DiscTkn, @WrkCheckSel_PmtAmt, @WrkCheckSel_DocType, @WrkCheckSel_RefNbr,
		@WrkCheckSel_CuryDiscTkn, @WrkCheckSel_CuryPmtAmt, @WrkCheckSel_MultiChk, @WrkCheckSel_CheckRefNbr, @WrkCheckSel_BWAmt , @WrkCheckSel_CuryBWAmt

	SELECT	@APCheck_DiscBal = APCheck.DiscAmt,
		@APCheck_OrigDocAmt = APCheck.CheckAmt,
		@APCheck_CuryDiscBal = APCheck.CuryDiscAmt,
		@APCheck_CuryOrigDocAmt = APCheck.CuryCheckAmt,
		@APCheck_VendId = APCheck.VendId,
		@APCheck_LineCntr = APCheck.CheckLines,
		@APCheck_CheckRefNbr = APCheck.CheckRefNbr,
		@APCheck_BWAmt = APCheck.BWAmt,
		@APCheck_CuryBWAmt = APCheck.CuryBWAmt
	FROM	APCheck
	WHERE
		APCheck.BatNbr = @batnbr
	AND	APCheck.VendId = @APDoc_VendId
	AND	APCheck.CheckRefNbr = @WrkCheckSel_CheckRefNbr

	

	/*
	**  Clear the multicheck flag on the first pass to prevent a premature update
	*/
	---SELECT @WrkCheckSel_Multichk = 0

	WHILE @@fetch_status = 0
	BEGIN
		/*
		**  Skip debit adjustments on multi-check vendors,
		**  they are handled separately
		*/
		IF @WrkCheckSel_MultiChk = 0 OR @WrkCheckSel_DocType <> 'AD'
		BEGIN
			/*
			**  If the vendor changed, or the multicheck flag is true,
			**  update the temporary check record
			*/
			IF @APDoc_VendId <> @APCheck_VendId OR @WrkCheckSel_Multichk = 1 OR @APCheck_CheckRefNbr <> @WrkCheckSel_CheckRefNbr
			BEGIN
				/*
				**  Delete check records with no voucher records
				*/
				IF @APCheck_LineCntr = 0
				BEGIN
					DELETE FROM APCheck
					WHERE
							APCheck.BatNbr = @batnbr
							AND	APCheck.VendId = @APCheck_VendId
						AND	APCheck.CheckRefNbr = @APCheck_CheckRefNbr

				END
                                /* Empty check records */
				ELSE
				BEGIN

					UPDATE APCheck
						SET APCheck.DiscAmt = @APCheck_DiscBal,
						    APCheck.CheckAmt = @APCheck_OrigDocAmt,
						    APCheck.CuryDiscAmt = @APCheck_CuryDiscBal,
						    APCheck.CuryCheckAmt = @APCheck_CuryOrigDocAmt,
						    APCheck.CheckLines = @APCheck_LineCntr,
						    APCheck.BWAmt = @APCheck_BWAmt,
						    APCheck.CuryBWAmt = @APCheck_CuryBWAmt
					WHERE
					APCheck.BatNbr = @batnbr
					AND	APCheck.VendId = @APCheck_VendId
					AND	APCheck.CheckRefNbr = @APCheck_CheckRefNbr
				END
				IF @@ERROR < > 0 GOTO ABORT
				
				
                                   /* Not an empty check record */
				/*
				**  Get the new check record
				*/
				SELECT	@APCheck_DiscBal = APCheck.DiscAmt,
					@APCheck_OrigDocAmt = APCheck.CheckAmt,
					@APCheck_CuryDiscBal = APCheck.CuryDiscAmt,
					@APCheck_CuryOrigDocAmt = APCheck.CuryCheckAmt,
					@APCheck_VendId = APCheck.VendId,
					@APCheck_LineCntr = APCheck.CheckLines,
					@APCheck_CheckRefNbr = APCheck.CheckRefNbr,
					@APCheck_BWAmt = APCheck.BWAmt,
					@APCheck_CuryBWAmt = APCheck.CuryBWAmt
				FROM	APCheck
				WHERE
				APCheck.BatNbr = @batnbr
				AND	APCheck.VendId = @APDoc_VendId
				AND	APCheck.CheckRefNbr = @WrkCheckSel_CheckRefNbr

				/*
				**  If the vendor id does not match now, there is a problem.  The
				**  two tables are out of synchronization
				*/
				IF @APDoc_VendId <> @APCheck_VendId
				BEGIN
					RAISERROR ('Temporary check records and selected vouchers worktable out of synch.',16,-1)
						CLOSE csr_update_docs
					DEALLOCATE csr_update_docs
					CLOSE csr_update_checks
					DEALLOCATE csr_update_checks
						RETURN
				END
			END
				SELECT @APDoc_Selected = 1
				/*
			**  If the document is a AD type, subtract the values,
			**  otherwise, add the values
			*/
			IF @WrkCheckSel_DocType <> 'AD'
			BEGIN
				/*
				**  Update the temp check record with the payment amount
				*/
				SELECT	@APCheck_DiscBal = @APCheck_DiscBal + @WrkCheckSel_DiscTkn,
					@APCheck_BWAmt = @WrkCheckSel_BWAmt,
					@APCheck_OrigDocAmt = convert(dec(28,3),@APCheck_OrigDocAmt) + convert(dec(28,3),@WrkCheckSel_PmtAmt),
					@APCheck_CuryDiscBal = @APCheck_CuryDiscBal + @WrkCheckSel_CuryDiscTkn,
					@APCheck_CuryBWAmt =  @WrkCheckSel_CuryBWAmt,
					@APCheck_CuryOrigDocAmt = convert(dec(28,3),@APCheck_CuryOrigDocAmt) + convert(dec(28,3),@WrkCheckSel_CuryPmtAmt)
					
					
			END
			ELSE
			BEGIN
				/*
				**  If this is a debit adjustment, and the check is already zero balance,
				**  don't take the adjustment.
				*/

				/*
				** If the applyrefnbr field is set on an 'AD' doc, apply this debit adjustment to
				** a specific voucher.  See if this voucher is included on a check in this run by looking
				** through the APCheckDet records for the voucher's refnbr.  If it exists, retreive the
				** APCheck that goes with this APCheckDet record, otherwise skip his 'AD' doc and fetch the
				** next record.
				*/
					IF @WrkCheckSel_DocType = 'AD' AND @WrkCheckSel_ApplyRefNbr <> ''
				BEGIN
					SELECT @WrkCheckSel_CheckRefNbr = ''

					SELECT
						@WrkCheckSel_CheckRefNbr = APCheckDet.CheckRefNbr
					FROM	APCheckDet
					WHERE
					APCheckDet.BatNbr = @batnbr
					AND	APCheckDet.RefNbr = @WrkCheckSel_ApplyRefNbr

				END

				IF @APCheck_CuryOrigDocAmt = 0 OR @WrkCheckSel_CheckRefNbr = ''
				BEGIN
					/*
					**  Delete the temporary APTran record for the adjustment
					*/
					DELETE FROM	APCheckDet
					WHERE	APCheckDet.DocType = @WrkCheckSel_DocType
					AND	APCheckDet.RefNbr = @WrkCheckSel_RefNbr

					/*
					**  Set the select flag off, this removes the adjustment
					**  from the batch
					*/
					SELECT	@APDoc_Selected = 0,
						@WrkCheckSel_DiscTkn = 0,
						@WrkCheckSel_PmtAmt = 0,
						@WrkCheckSel_CuryDiscTkn = 0,
						@WrkCheckSel_CuryPmtAmt = 0,
						@WrkCheckSel_BWAmt = 0,
						@WrkCheckSel_CuryBWAmt = 0
						

					/*
					**  Decrement the line counter on the check
					*/
					IF @APCheck_LineCntr > 0
					BEGIN
						SELECT @APCheck_LineCntr = @APCheck_LineCntr - 1
					END
				END
				ELSE
				BEGIN
					/*
					**  If the adjustment amount is greater than the
					**  current payment amount, take only as much
					**  adjustment as the payment
					*/
					IF @WrkCheckSel_CuryPmtAmt > @APCheck_CuryOrigDocAmt
					BEGIN
						SELECT @WrkCheckSel_CuryPmtAmt = @APCheck_CuryOrigDocAmt,
						       @WrkCheckSel_PmtAmt = @APCheck_OrigDocAmt
						/*
						**  Update the temporary APTran record with the new balance
						*/
						UPDATE	APCheckDet
						SET	CuryPmtAmt = -1*@WrkCheckSel_CuryPmtAmt,
							PmtAmt = -1*@WrkCheckSel_PmtAmt
						WHERE	APCheckDet.DocType = @WrkCheckSel_DocType
						AND	APCheckDet.RefNbr = @WrkCheckSel_RefNbr
					END
			IF @@ERROR < > 0 GOTO ABORT

					/*
					**  Adjust the discount amount on the debit memo
					*/
					IF @WrkCheckSel_CuryDiscTkn > @APCheck_CuryDiscBal
					BEGIN
						SELECT @WrkCheckSel_CuryDiscTkn = @APCheck_CuryDiscBal,
						       @WrkCheckSel_DiscTkn = @APCheck_DiscBal,
						       @WrkCheckSel_BWAmt = @APCheck_BWAmt,
						       @WrkCheckSel_CuryBWAmt = @APCheck_CuryBWAmt
						/*
						**  Update the temporary APTran record with the new balance
						*/
						UPDATE	APCheckDet
						SET	CuryDiscAmt = -1*@WrkCheckSel_CuryDiscTkn,
							DiscAmt = -1*@WrkCheckSel_DiscTkn,
							BWAmt = -1*@WrkCheckSel_BWAmt,
							CuryBWAmt = -1*@WrkCheckSel_CuryBWAmt
						WHERE	APCheckDet.DocType = @WrkCheckSel_DocType
						AND	APCheckDet.RefNbr  = @WrkCheckSel_RefNbr
					END
			IF @@ERROR < > 0 GOTO ABORT

					/*
					**  Update the check record with debit amount, including the
					**  discount taken
					*/
					SELECT	@APCheck_DiscBal = @APCheck_DiscBal - @WrkCheckSel_DiscTkn,
						@APCheck_BWAmt = @WrkCheckSel_BWAmt,
						@APCheck_OrigDocAmt = convert(dec(28,3),@APCheck_OrigDocAmt) - convert(dec(28,3),@WrkCheckSel_PmtAmt),
						@APCheck_CuryDiscBal = @APCheck_CuryDiscBal - @WrkCheckSel_CuryDiscTkn,
						@APCheck_CuryBWAmt = @APCheck_CuryBWAmt + @WrkCheckSel_BWAmt,
						@APCheck_CuryOrigDocAmt = @APCheck_CuryOrigDocAmt - @WrkCheckSel_CuryPmtAmt
				END
			END
                        /*  Is an adjustment */

			if @PreView = 0
			BEGIN
				/*
				**  Update the APDoc record with the payment information
				*/
				UPDATE APDoc
					SET APDoc.DiscTkn = @WrkCheckSel_DiscTkn,
					    APDoc.PmtAmt = @WrkCheckSel_PmtAmt,
					    APDoc.CuryDiscTkn = @WrkCheckSel_CuryDiscTkn,
					    APDoc.CuryPmtAmt = @WrkCheckSel_CuryPmtAmt,
					    APDoc.BWAmt = @WrkCheckSel_BWAmt,
					    APDoc.CuryBWAmt = @WrkCheckSel_CuryBWAmt,
					    APDoc.Selected = @APDoc_Selected
				WHERE APDoc.DocType = @WrkCheckSel_DocType
					and APDoc.Refnbr = @WrkCheckSel_RefNbr
					and APDoc.Vendid = @APDoc_VendId
			END
		END
			IF @@ERROR < > 0 GOTO ABORT
                /*  Not multicheck or not an adjustment */
		ELSE
		BEGIN
			SELECT @Apply_Multichk_DM = 1
		END

		/*
		**  Move to the next voucher/adjustment record
		*/
		FETCH NEXT FROM csr_update_docs INTO @APDoc_DiscTkn, @APDoc_PmtAmt, @APDoc_CuryDiscTkn,
			@APDoc_CuryPmtAmt, @APDoc_Selected, @APDoc_VendId, @WrkCheckSel_ApplyRefNbr,
			@WrkCheckSel_DiscTkn, @WrkCheckSel_PmtAmt, @WrkCheckSel_DocType, @WrkCheckSel_RefNbr,
			@WrkCheckSel_CuryDiscTkn, @WrkCheckSel_CuryPmtAmt, @WrkCheckSel_MultiChk, @WrkCheckSel_CheckRefNbr, @WrkCheckSel_BWAmt, @WrkCheckSel_CuryBWAmt
	END

	CLOSE csr_update_docs
	DEALLOCATE csr_update_docs

	IF @APCheck_LineCntr = 0
	BEGIN

		DELETE FROM APCheck
		WHERE	---APDoc.Acct = ''
			---AND	APDoc.Sub = ''
			---AND	APDoc.doctype = 'CK'
			---AND	APDoc.RefNbr = ''
			---AND
			APCheck.BatNbr = @batnbr
			---AND	APDoc.Status = 'T'
			AND	APCheck.VendId = @APCheck_VendId
			AND	APCheck.CheckRefNbr = @APCheck_CheckRefNbr
	END
	ELSE
	BEGIN

			UPDATE APCheck
			SET APCheck.DiscAmt = @APCheck_DiscBal,
			    APCheck.CheckAmt = @APCheck_OrigDocAmt,
			    APCheck.CuryDiscAmt = @APCheck_CuryDiscBal,
			    APCheck.CuryCheckAmt = @APCheck_CuryOrigDocAmt,
			    APCheck.BWAmt = @APCheck_BWAmt,
			    APCheck.CuryBWAmt = @APCheck_CuryBWAmt,
			    APCheck.CheckLines = @APCheck_LineCntr
		WHERE
		APCheck.BatNbr = @batnbr
		AND	APCheck.VendId = @APCheck_VendId
		AND	APCheck.CheckRefNbr = @APCheck_CheckRefNbr
	END
	IF @@ERROR < > 0 GOTO ABORT

	/*
	**  Apply multicheck debit memos
	*/
	IF @Apply_Multichk_DM = 1
	BEGIN
		EXEC APCheck_Apply_MultiCheck_DM @accessnbr,  @batnbr, @Preview, @APResult OUTPUT
	END


	/*
	**  Delete check records with no voucher records
	*/
	DELETE FROM APCheck
		WHERE
		APCheck.BatNbr = @batnbr
		AND	APCheck.Checklines <= 0

SELECT @APResult = 1
GOTO FINISH

ABORT:
SELECT @APResult = 0

FINISH:


