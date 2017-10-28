 CREATE PROCEDURE Update_Existing_BankRecs
                 @Module VARCHAR (2),
                 @CpnyID VARCHAR ( 10),
                 @BankAcct VARCHAR(10),
                 @BankSub VARCHAR ( 24),
                 @TranDate SMALLDATETIME,
                 @ClearDate SMALLDATETIME,
                 @DocType VARCHAR (2),
                 @DrCr VARCHAR (1),
                 @CuryAmt FLOAT (8),
                 @BaseAmt FLOAT (8),
                 @Status  VARCHAR (1)
AS

UPDATE b
SET
CuryDepInTransit =
                 CASE
                 WHEN ((@Module = 'AR') OR
                       (@Module = 'GL' AND @DrCr = 'D' AND (@Status = 'O' OR (@Status = 'C' AND @ClearDate > b.StmtDate))) OR
                       (@Module = 'CA' AND @DrCr = 'C' AND (@Status = 'O' OR (@Status = 'C' AND @ClearDate > b.StmtDate))))
                 THEN  ((CONVERT(DEC(28,3),b.CuryDepInTransit)) + (CONVERT(DEC(28,3),@CuryAmt)))
                 ELSE
                       b.CuryDepInTransit
                 END,
DepInTransit =
                 CASE
                 WHEN ((@Module = 'AR') OR
                       (@Module = 'GL' AND @DrCr = 'D' AND (@Status = 'O' OR (@Status = 'C' AND @ClearDate > b.StmtDate))) OR
                       (@Module = 'CA' AND @DrCr = 'C' AND (@Status = 'O' OR (@Status = 'C' AND @ClearDate > b.StmtDate))))
                 THEN  ((CONVERT(DEC(28,3),b.DepInTransit)) + (CONVERT(DEC(28,3),@BaseAmt)))
                 ELSE
                       b.DepInTransit
                 END,
CuryOutStandingChk  =
                 CASE
                 WHEN ((@Module IN ('AP','PR') AND @DocType IN ('CK','HC','EP')) OR
                       (@Module = 'GL' AND @DrCr = 'C' AND (@Status = 'O' OR (@Status = 'C' AND @ClearDate > b.StmtDate))) OR
                       (@Module = 'CA' AND @DrCr = 'D' AND (@Status = 'O' OR (@Status = 'C' AND @ClearDate > b.StmtDate))))
                 THEN  b.CuryOutStandingChk + @CuryAmt
                 WHEN (@Module IN ('AP','PR') AND @DocType = 'VC')
                 THEN  ((CONVERT(DEC(28,3),b.CuryOutStandingChk)) - (CONVERT(DEC(28,3),@CuryAmt)))
                 ELSE
                       b.CuryOutStandingChk
                 END,
OutStandingChk  =
                 CASE
                 WHEN ((@Module IN ('AP','PR') AND @DocType IN ('CK','HC','EP')) OR
                       (@Module = 'GL' AND @DrCr = 'C' AND (@Status = 'O' OR (@Status = 'C' AND @ClearDate > b.StmtDate))) OR
                       (@Module = 'CA' AND @DrCr = 'D' AND (@Status = 'O' OR (@Status = 'C' AND @ClearDate > b.StmtDate))))
                 THEN  b.OutStandingChk + @BaseAmt
                 WHEN (@Module IN ('AP','PR') AND @DocType = 'VC')
                 THEN  ((CONVERT(DEC(28,3),b.OutStandingChk)) - (CONVERT(DEC(28,3),@BaseAmt)))
                 ELSE
                       b.OutStandingChk
                 END,
CuryStmtBal =
                 CASE
                 WHEN (@Module = 'GL' AND @DrCr = 'D' AND (@Status = 'C' AND @ClearDate <= b.StmtDate)) OR
                      (@Module = 'CA' AND @DrCr = 'C' AND (@Status = 'C' AND @ClearDate <= b.StmtDate))
                 THEN  ((CONVERT(DEC(28,3),b.CuryStmtBal)) + (CONVERT(DEC(28,3),@CuryAmt)))
                 WHEN (@Module = 'GL' AND @DrCr = 'C' AND (@Status = 'C' AND @ClearDate <= b.StmtDate)) OR
                      (@Module = 'CA' AND @DrCr = 'D' AND (@Status = 'C' AND @ClearDate <= b.StmtDate))
                 THEN  ((CONVERT(DEC(28,3),b.CuryStmtBal)) - (CONVERT(DEC(28,3),@CuryAmt)))
                 ELSE
                      b.CuryStmtBal
                 END,
StmtBal =
                 CASE
                 WHEN (@Module = 'GL' AND @DrCr = 'D' AND (@Status = 'C' AND @ClearDate <= b.StmtDate)) OR
                      (@Module = 'CA' AND @DrCr = 'C' AND (@Status = 'C' AND @ClearDate <= b.StmtDate))
                 THEN  ((CONVERT(DEC(28,3),b.StmtBal)) + (CONVERT(DEC(28,3),@BaseAmt)))
                 WHEN (@Module = 'GL' AND @DrCr = 'C' AND (@Status = 'C' AND @ClearDate <= b.StmtDate)) OR
                      (@Module = 'CA' AND @DrCr = 'D' AND (@Status = 'C' AND @ClearDate <= b.StmtDate))
                 THEN  ((CONVERT(DEC(28,3),b.StmtBal)) - (CONVERT(DEC(28,3),@BaseAmt)))
                 ELSE
                      b.StmtBal
                 END

FROM BankRec b

WHERE b.CpnyID = @CpnyID AND
      b.BankAcct = @BankAcct AND
      b.BankSub = @BankSub AND
      b.ReconDate >= @TranDate AND
      b.ReconcileFlag <> 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_Existing_BankRecs] TO [MSDSL]
    AS [dbo];

