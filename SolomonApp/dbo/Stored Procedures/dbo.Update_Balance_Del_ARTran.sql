 CREATE	PROCEDURE Update_Balance_Del_ARTran
			@BatNbr VARCHAR(10), @CustID VARCHAR(15),
			@PADocType VARCHAR(2), @PARefNbr VARCHAR(10),
			@INDocType VARCHAR(2), @INRefNbr VARCHAR(10),
			@INBalance FLOAT, @INDiscount FLOAT
AS
UPDATE	ARTran SET
	CuryTxblAmt00 = CASE WHEN (CuryTxblAmt00 = 0 AND @INBalance <> 0) OR @PADocType = 'SB'  THEN @INBalance ELSE CuryTxblAmt00 END,
	CuryTxblAmt01 = CASE WHEN CuryTxblAmt01 = 0 AND @INDiscount <> 0 THEN @INDiscount ELSE CuryTxblAmt01 END
WHERE	BatNbr = @BatNbr AND DrCr = 'U'
	AND CustID = @CustID AND CostType = @INDocType AND SiteID = @INRefNbr
	AND TranType IN('PA','PP','CM')
	AND (TranType <> @PADocType OR RefNbr <> @PARefNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_Balance_Del_ARTran] TO [MSDSL]
    AS [dbo];

