
CREATE PROCEDURE WSL_ExpenseTotals
 @parm1 varchar (10) -- Employee
 ,@parm2 varchar (1)  -- History Only? Y/N
 ,@parm3 int --TOP parameter
AS
    SET NOCOUNT ON
	SELECT TOP(@parm3 + 1) --the +1 is necessary because otherwise the last record doesn't always match what's returned from the web service
		hdr.docnbr AS DocumentNumber,
		CASE hdr.status_2
			WHEN 'E' THEN
				ISNULL(
					SUM(
						ROUND(
							CASE WHEN det.CuryMultDiv IS NULL THEN
								0
							WHEN det.CuryMultDiv = 'M' THEN
								det.CuryTranamt * det.CuryRate
							ELSE
								det.CuryTranamt / det.CuryRate
							END
							, CASE WHEN c.DecPl IS NULL THEN 0 ELSE c.DecPl END
						)
					), 0
				) 
			ELSE hdr.advance_amt
		END AS Total
	FROM PJEXPHDR hdr
		LEFT OUTER JOIN PJEXPDET det
			INNER JOIN Currncy c
			ON c.CuryId = det.CuryId
		ON hdr.docnbr = det.docnbr
	WHERE hdr.employee = @parm1 AND (
		(@parm2 = 'Y' AND hdr.status_1 IN ('P','C','A')) 
		OR
		(@parm2 <> 'Y' AND hdr.status_1 IN ('I','R'))
	)
	GROUP BY hdr.docnbr, hdr.report_date, hdr.status_2, hdr.advance_amt
	ORDER BY hdr.report_date DESC, hdr.docnbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ExpenseTotals] TO [MSDSL]
    AS [dbo];

