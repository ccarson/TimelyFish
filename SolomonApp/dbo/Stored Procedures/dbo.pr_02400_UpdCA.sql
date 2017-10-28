 CREATE PROCEDURE pr_02400_UpdCA @BatNbr varchar(10) AS

DECLARE @CpnyID VARCHAR (10)
DECLARE @BankAcct VARCHAR(10)
DECLARE @BankSub VARCHAR (24)
DECLARE @TranDate SMALLDATETIME
DECLARE @ClearDate SMALLDATETIME
DECLARE @CuryAmt FLOAT (8)
DECLARE @BaseAmt FLOAT (8)
DECLARE @DocType VARCHAR(2)
DECLARE @AcceptTransDate smalldatetime
DECLARE @UpdOK smallint

DECLARE RDocCursor CURSOR FOR
        SELECT d.CpnyID, d.Acct, d.Sub, d.ChkDate, d.ClearDate, d.NetAmt, d.NetAmt, d.DocType
                FROM PRDoc d
                WHERE d.BatNbr = @BatNbr

SELECT @AcceptTransDate=MAX(AcceptTransDate)
FROM CASetup

OPEN RDocCursor
FETCH NEXT FROM RDocCursor INTO @CpnyID, @BankAcct, @BankSub, @TranDate, @ClearDate, @BaseAmt, @CuryAmt, @DocType

WHILE (@@FETCH_STATUS <> -1)
BEGIN
        IF (@@FETCH_STATUS <> -2)
                AND (SELECT MAX(ReconDate) FROM BankRec WHERE CpnyID = @CpnyID AND BankAcct = @BankAcct AND BankSub = @BankSub) >= @TranDate
                AND @AcceptTransDate <= @TranDate
        BEGIN
                EXEC Update_Existing_BankRecs 'PR', @CpnyID, @BankAcct, @BankSub, @TranDate, @ClearDate, @DocType, '', @CuryAmt, @BaseAmt, 'O'
                IF @@ERROR < > 0 GOTO ABORT
        END
        FETCH NEXT FROM RDocCursor INTO @CpnyID, @BankAcct, @BankSub, @TranDate, @ClearDate, @BaseAmt, @CuryAmt, @DocType
END

CLOSE RDocCursor
DEALLOCATE RDocCursor

SELECT @UpdOk=1
SELECT @UpdOk
GOTO FINISH

ABORT:
SELECT @UpdOk=0
SELECT @UpdOk

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pr_02400_UpdCA] TO [MSDSL]
    AS [dbo];

