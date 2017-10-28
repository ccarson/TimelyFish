 CREATE PROCEDURE Update_Existing_BankRecs_20440
                 @Module VARCHAR (2),
                 @CpnyID VARCHAR (10),
                 @BankAcct VARCHAR(10),
                 @BankSub VARCHAR (24),
                 @ClearDate SMALLDATETIME,
                 @DocType VARCHAR (2),
                 @DrCr VARCHAR (1),
                 @CuryAmt FLOAT (8),
                 @BaseAmt FLOAT (8)
AS

UPDATE b
SET
CuryDepInTransit =
                 CASE
                 WHEN ((@Module = 'AR') OR (@Module = 'CA' AND @DrCr = 'C'))
                 THEN  ((CONVERT(DEC(28,3),b.CuryDepInTransit)) - (CONVERT(DEC(28,3),@CuryAmt)))
                 ELSE
                       b.CuryDepInTransit
                 END,
DepInTransit =
                 CASE
                 WHEN ((@Module = 'AR') OR (@Module = 'CA' AND @DrCr = 'C'))
                 THEN  ((CONVERT(DEC(28,3),b.DepInTransit)) - (CONVERT(DEC(28,3),@BaseAmt)))
                 ELSE
                       b.DepInTransit
                 END,
CuryOutStandingChk  =
                 CASE
                 WHEN ((@Module = 'AP' AND @DocType IN ('CK','HC','EP')) OR (@Module = 'CA' AND @DrCr = 'D'))
                 THEN  ((CONVERT(DEC(28,3),b.CuryOutStandingChk)) - (CONVERT(DEC(28,3),@CuryAmt)))
                 WHEN  (@Module = 'AP' AND @DocType = 'VC')
                 THEN  ((CONVERT(DEC(28,3),b.CuryOutStandingChk)) + (CONVERT(DEC(28,3),@CuryAmt)))
                 ELSE
                       b.CuryOutStandingChk
                 END,
OutStandingChk  =
                 CASE
                 WHEN ((@Module = 'AP' AND @DocType IN ('CK','HC','EP')) OR (@Module = 'CA' AND @DrCr = 'D'))
                 THEN  ((CONVERT(DEC(28,3),b.OutStandingChk)) - (CONVERT(DEC(28,3),@BaseAmt)))
                 WHEN (@Module = 'AP' AND @DocType = 'VC')
                 THEN  ((CONVERT(DEC(28,3),b.OutStandingChk)) + (CONVERT(DEC(28,3),@BaseAmt)))
                 ELSE
                       b.OutStandingChk
                 END,
CuryStmtBal =
                 CASE
                 WHEN ((@Module = 'CA' AND @DrCr = 'D') OR
                       (@Module = 'AP' AND @DocType IN('CK','HC','EP')))
                 THEN  ((CONVERT(DEC(28,3),b.CuryStmtBal)) - (CONVERT(DEC(28,3),@CuryAmt)))
                 WHEN ((@Module = 'CA' AND @DrCr = 'C') OR
                       (@Module = 'AR'))
                 THEN  ((CONVERT(DEC(28,3),b.CuryStmtBal)) + (CONVERT(DEC(28,3),@CuryAmt)))
                 ELSE
                      b.CuryStmtBal
                 END,
StmtBal =
                 CASE
                 WHEN ((@Module = 'CA' AND @DrCr = 'D') OR
                       (@Module = 'AP' AND @DocType IN('CK','HC','EP')))
                 THEN  ((CONVERT(DEC(28,3),b.StmtBal)) - (CONVERT(DEC(28,3),@BaseAmt)))
                 WHEN ((@Module = 'CA' AND @DrCr = 'C') OR
                       (@Module = 'AR' ))
                 THEN  ((CONVERT(DEC(28,3),b.StmtBal)) + (CONVERT(DEC(28,3),@BaseAmt)))
                 ELSE
                      b.StmtBal
                 END

FROM BankRec b

WHERE b.CpnyID = @CpnyID AND
      b.BankAcct = @BankAcct AND
      b.BankSub = @BankSub AND
      b.StmtDate >= @ClearDate AND
      b.ReconcileFlag <> 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_Existing_BankRecs_20440] TO [MSDSL]
    AS [dbo];

