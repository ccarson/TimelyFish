 CREATE PROCEDURE ED850Rpt_Extr3 @CpnyID varchar(10), @EDIPoId varchar(10), @LineID int AS
SELECT Indicator, CuryTotAmt, Qty, LDiscRate, Pct FROM ED850LDisc
where CpnyId = @CpnyID and
EDIPOId = @EDIPOID and
LineID = @LineId and
Indicator = 'A'
ORDER BY CpnyID, EDIPoId, LineID, LineNbr, CuryTotAmt



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Rpt_Extr3] TO [MSDSL]
    AS [dbo];

