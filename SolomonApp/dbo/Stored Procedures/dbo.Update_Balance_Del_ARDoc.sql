 CREATE	PROCEDURE Update_Balance_Del_ARDoc
			@BatNbr VARCHAR(10), @CustID VARCHAR(15),
			@PADocType VARCHAR(2), @PARefNbr VARCHAR(10)
AS
UPDATE	r SET
	CuryTxblAmt00 = CASE WHEN r.CuryTxblAmt00 = 0 AND t.CuryTranAmt <> 0 THEN 1 ELSE r.CuryTxblAmt00 END,
	CuryTxblAmt01 = CASE WHEN r.CuryTxblAmt01 = 0 AND t.CuryUnitPrice <> 0 THEN 1 ELSE r.CuryTxblAmt01 END
FROM	ARTran r
	INNER JOIN ARTran t ON t.BatNbr = r.BatNbr AND t.CustID = r.CustID
	AND t.CostType = r.CostType AND t.SiteID = r.SiteID
	AND t.TranType = @PADocType AND t.RefNbr = @PARefNbr
WHERE	r.BatNbr = @BatNbr AND r.DrCr = 'U'
	AND r.CustID = @CustID
	AND r.TranType IN('PA','PP','CM')
	AND t.DrCr = 'U' AND t.TranType IN('PA','PP','CM')
	AND (r.TranType <> @PADocType OR r.RefNbr <> @PARefNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_Balance_Del_ARDoc] TO [MSDSL]
    AS [dbo];

