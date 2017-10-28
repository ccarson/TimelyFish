 CREATE PROCEDURE AP_PPAmt
	@VORefNbr AS varchar(10),
	@PPRefNbr AS varchar(10),
	@BaseCuryID AS varchar(10)
AS

DECLARE @Amt1 AS Float
DECLARE @Amt2 AS Float

IF NOT EXISTS (	SELECT	*
		FROM	APDoc
		WHERE	RefNbr = @VORefNbr
		AND	DocType in ('VO', 'AC')
		AND	PrePay_RefNbr = @PPRefNbr)

/* We'll go on and calculate the maximum amount we can apply to this voucher by this prepayment */
  BEGIN
	SELECT @Amt1 = CASE WHEN d.CuryID = j.CuryAdjdCuryID THEN j.CuryAdjdAmt
                            WHEN d.CuryID <> j.CuryAdjdCuryID AND j.CuryAdjdCuryID = @BaseCuryID
                            THEN CASE d.CuryMultDiv
                                     WHEN 'M'
                                     THEN ROUND(CONVERT(DEC(28,3), j.CuryAdjdAmt) / CONVERT(DEC(19,9), d.CuryRate), c1.DecPl)
                                     ELSE ROUND(CONVERT(DEC(28,3), j.CuryAdjdAmt) * CONVERT(DEC(19,9), d.CuryRate), c1.DecPl)
                                  END
                            ELSE 0 /* We would never apply PP to VO if PP is of different, non-base currency */
                       END,
           @Amt2 = d.CuryDocBal
	FROM APDoc d
		INNER JOIN Currncy c1 (NOLOCK) ON c1.CuryID = d.CuryID
		CROSS JOIN APDoc p
		INNER JOIN APAdjust j ON p.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = 'PP'
	WHERE	p.RefNbr = @PPRefNbr
	AND	p.DocType = 'PP'
	AND	d.RefNbr = @VORefNbr
	AND	d.DocType in ('VO', 'AC')
    AND j.s4Future11 <> 'V'

	SELECT @Amt1, @Amt2
  END

ELSE

  SELECT 0, 0


