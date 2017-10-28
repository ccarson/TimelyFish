 CREATE PROCEDURE [dbo].[pp_03025NegativeChk] @BatNbr CHAR(10) AS
-- ======================================================================
-- SP pp_03025NegativeChk
-- Created to make sure the negative check is done with the proper
-- criteria.  The criteria includes: RefNbr, CpnyID, S4Future01, and
-- S4Future02. The check is based on batches with several different
-- Reference numbers(RefNbr). Each RefNbr can have several different
-- companies(CpnyID). Every company can have several different
-- accounts(S4Future01) and every account can have several different
-- subaccounts(S4Future02).
-- Parameters:  batch number(BatNbr)
-- Developed for 03.025.00(Voucher Entry - Distributed Liability Screen)
-- ======================================================================

DECLARE @NegRef CHAR(10),
		@RefNbr CHAR(10),
		@CpnyID CHAR(10),
		@S4Future01 CHAR(30),
		@S4Future02 CHAR(30)

DECLARE ref_cursor CURSOR FOR
	SELECT RefNbr
	FROM aptran
	WHERE BatNbr = @BatNbr
	GROUP BY RefNbr

OPEN ref_cursor
FETCH NEXT FROM ref_cursor INTO @RefNbr

WHILE @@Fetch_Status = 0
BEGIN
		IF @NegRef is NULL
	BEGIN
		DECLARE company_cursor CURSOR FOR
			SELECT cpnyID
			FROM aptran
			WHERE BatNbr = @BatNbr
				AND	RefNbr = @RefNbr
			GROUP BY CpnyID

		OPEN company_cursor
		FETCH NEXT FROM company_cursor INTO @CpnyID

		WHILE @@Fetch_Status = 0
		BEGIN
			IF @NegRef is NULL
			BEGIN
				DECLARE account_cursor CURSOR FOR
					SELECT S4Future01
					FROM aptran
					WHERE BatNbr = @BatNbr
						AND RefNbr = @RefNbr
						AND CpnyID = @CpnyID
					GROUP BY S4Future01

				OPEN account_cursor
				FETCH NEXT FROM account_cursor INTO @S4Future01

				WHILE @@Fetch_Status = 0
				BEGIN
					IF @NegRef is NULL
					BEGIN
						DECLARE subaccount_cursor CURSOR FOR
							SELECT S4Future02
							FROM aptran
							WHERE BatNbr = @BatNbr
								AND RefNbr = @RefNbr
								AND CpnyID = @CpnyID
								AND S4Future01 = @S4Future01
							GROUP BY S4Future02

						OPEN subaccount_cursor
						FETCH NEXT FROM subaccount_cursor INTO @S4Future02

						WHILE @@Fetch_Status = 0
						BEGIN
							IF @NegRef is NULL
							BEGIN
								SELECT @NegRef = d.RefNbr
								FROM APDoc d INNER JOIN APTran t ON d.RefNbr=t.RefNbr AND d.DocType=t.TranType
								WHERE d.BatNbr=@BatNbr
									AND t.RefNbr = @RefNbr
									AND t.CpnyID = @CpnyID
									AND t.S4Future01 = @S4Future01
									AND t.S4Future02 = @S4Future02
									AND d.Rlsed=0
								GROUP BY d.RefNbr, d.DocType, t.CpnyID
								HAVING SUM(convert(dec(28,3),CuryTranAmt))<0
							END

							FETCH NEXT FROM subaccount_cursor INTO @S4Future02
						END

						CLOSE subaccount_cursor
						DEALLOCATE subaccount_cursor

					END

					FETCH NEXT FROM account_cursor INTO @S4Future01
				END

				CLOSE account_cursor
				DEALLOCATE account_cursor

			END

			FETCH NEXT FROM company_cursor INTO @CpnyID
		END

		CLOSE company_cursor
		DEALLOCATE company_cursor

	END

	FETCH NEXT FROM ref_cursor INTO @RefNbr
END

CLOSE ref_cursor
DEALLOCATE ref_cursor

IF @NegRef is NULL
	SELECT RefNbr FROM apdoc WHERE 1 = 2
ELSE
	SELECT @NegRef


