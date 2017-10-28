 Create	Procedure SCM_10400_ClearARTranCosts
	@CpnyID		VarChar(10),
	@BatNbr		VarChar(10),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10)

As

	Update	ARTran
		Set	ExtCost = 0,
			CuryExtCost = 0,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		FROM	INTRAN INNER  JOIN ARTran
                                  ON INTran.ID = ARTran.CustID
			         AND INTran.RefNbr = ARTran.RefNbr
			         AND INTran.ARLineID = ARTran.LineID
		WHERE	INTran.CpnyID = @CpnyID
			AND INTran.Batnbr = @BatNbr
			AND NOT EXISTS (SELECT INTran.Rlsed
                                          FROM INTran
				         WHERE INTran.CpnyID = @CpnyID
				           AND INTran.Batnbr = @BatNbr
				           AND INTran.ID = ARTran.CustID
				           AND INTran.RefNbr = ARTran.RefNbr
				           AND INTran.ARLineID = ARTran.LineID
				           AND INTran.Rlsed = 1)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_ClearARTranCosts] TO [MSDSL]
    AS [dbo];

