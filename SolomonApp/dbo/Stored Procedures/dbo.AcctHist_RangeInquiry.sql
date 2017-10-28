 CREATE PROC AcctHist_RangeInquiry  @cpnyid varchar (10), @ledgerid varchar (10), @Acct varchar ( 10), @Sub varchar (24) , @BegPer varchar ( 6), @EndPer varchar ( 6) AS

DECLARE @BegYr varchar(4), @EndYr varchar(4)

SET @BegYr = SUBSTRING(@BegPer,1,4)
SET @EndYr = SUBSTRING(@EndPer,1,4)
SET @BegPer = SUBSTRING(@BegPer,5,2)
SET @EndPer = SUBSTRING(@EndPer,5,2)

DECLARE Bound CURSOR READ_ONLY FOR
SELECT MAX(h.FiscYr),MAX(s.NbrPer) FROM AcctHist h, GLSetup s WHERE h.cpnyid  = @cpnyid and h.ledgerid = @ledgerid and h.acct = @acct and h.sub = @sub HAVING max(h.fiscyr)<@endyr
OPEN Bound
FETCH NEXT FROM Bound INTO @EndYr, @EndPer
CLOSE Bound
DEALLOCATE Bound

SELECT
BegBal=Sum(CASE WHEN h.FiscYr = @BegYr THEN (CASE
WHEN @BegPer = "01" THEN h.BegBal
WHEN @BegPer = "02" THEN h.YtdBal00
WHEN @BegPer = "03" THEN h.YtdBal01
WHEN @BegPer = "04" THEN h.YtdBal02
WHEN @BegPer = "05" THEN h.YtdBal03
WHEN @BegPer = "06" THEN h.YtdBal04
WHEN @BegPer = "07" THEN h.YtdBal05
WHEN @BegPer = "08" THEN h.YtdBal06
WHEN @BegPer = "09" THEN h.YtdBal07
WHEN @BegPer = "10" THEN h.YtdBal08
WHEN @BegPer = "11" THEN h.YtdBal09
WHEN @BegPer = "12" THEN h.YtdBal10
WHEN @BegPer = "13" THEN h.YtdBal11
END) ELSE 0 END),
EndBal=Sum(CASE WHEN h.FiscYr = @EndYr THEN (CASE
WHEN @EndPer = "01" THEN h.YtdBal00
WHEN @EndPer = "02" THEN h.YtdBal01
WHEN @EndPer = "03" THEN h.YtdBal02
WHEN @EndPer = "04" THEN h.YtdBal03
WHEN @EndPer = "05" THEN h.YtdBal04
WHEN @EndPer = "06" THEN h.YtdBal05
WHEN @EndPer = "07" THEN h.YtdBal06
WHEN @EndPer = "08" THEN h.YtdBal07
WHEN @EndPer = "09" THEN h.YtdBal08
WHEN @EndPer = "10" THEN h.YtdBal09
WHEN @EndPer = "11" THEN h.YtdBal10
WHEN @EndPer = "12" THEN h.YtdBal11
WHEN @EndPer = "13" THEN h.YtdBal12
END) ELSE 0 END)
FROM AcctHist h
WHERE
h.cpnyid  = @cpnyid and h.ledgerid = @ledgerid and h.acct = @acct and h.sub = @sub and
h.fiscyr BETWEEN @BegYr AND @EndYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_RangeInquiry] TO [MSDSL]
    AS [dbo];

