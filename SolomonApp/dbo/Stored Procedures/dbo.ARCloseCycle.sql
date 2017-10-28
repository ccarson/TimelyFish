 /****** Object:  Stored Procedure dbo.ARCloseCycle    Script Date: 4/7/98 12:30:33 PM ******/
CREATE Procedure ARCloseCycle @curCycle varchar(2), @stmtDate smalldatetime, @incFutureDocs tinyint
AS
DECLARE @decPl          int,
        @custId         varchar(15),
        @CpnyID         varchar(10),
--Closing must be company sensitive. The variable to fetch CpnyID from AR_Balances
        @perNbr         varchar(6),
        @lastStmtDate   smalldatetime,
        @lastStmtBegBal float,
        @lastStmtBal00  float,
        @lastStmtBal01  float,
        @lastStmtBal02  float,
        @lastStmtBal03  float,
        @lastStmtBal04  float,
        @ageBal00       float,
        @ageBal01       float,
        @ageBal02       float,
        @ageBal03       float,
        @ageBal04       float,
        @msg            varchar(255)
        
SET NOCOUNT ON
		
/* Look up the number of decimal places for the base currency */
SELECT @decPl = ISNULL(MAX(C.DecPl),2)
FROM   GLSetup G INNER JOIN Currncy C ON G.BaseCuryID = C.CuryId
WHERE  G.SetupId = 'GL'

/* Create cursor on customers on the given statement cycle */
/* The cursor is insensitive for performance reasons */
DECLARE Customer_Crsr INSENSITIVE CURSOR FOR
   SELECT Customer.CustId,
	Customer.PerNbr,
	ar_balances.CpnyID,
--Selecting CpnyID, will be used to update THE ONLY AR_Balances record
--(previously all records (regardless of company) for the particular customer were updating)
	ar_balances.LastStmtDate,
	ar_balances.LastStmtBegBal,
	ar_balances.LastStmtBal00,
	ar_balances.LastStmtBal01,
	ar_balances.LastStmtBal02,
	ar_balances.LastStmtBal03,
	ar_balances.LastStmtBal04,
	ar_balances.AgeBal00,
	ar_balances.AgeBal01,
	ar_balances.AgeBal02,
	ar_balances.AgeBal03,
	ar_balances.AgeBal04

   FROM Customer inner join AR_Balances on customer.custid = ar_balances.custid
   WHERE Customer.StmtCycleId = @curCycle
   AND  Ar_Balances.LastStmtDate <= @stmtDate
   ORDER BY Customer.StmtCycleId, Customer.CustId

/* Open cursor and fetch first row */
OPEN Customer_Crsr
FETCH Customer_Crsr INTO @custId, @perNbr, @CpnyID, @lastStmtDate, @lastStmtBegBal, @lastStmtBal00,
--Fetching CpnyID as well, will be used to update THE ONLY AR_Balances record
                         @lastStmtBal01, @lastStmtBal02, @lastStmtBal03, @lastStmtBal04,
                         @ageBal00, @ageBal01, @ageBal02, @ageBal03, @ageBal04

/* Loop over customers */
WHILE @@FETCH_STATUS = 0
BEGIN

   /* If last statement was not today, set statement beginning balance */
   IF @lastStmtDate <> @stmtDate
      SELECT @lastStmtBegBal = ROUND(@lastStmtBal00,@decPl) + ROUND(@lastStmtBal01,@decPl)
         + ROUND(@lastStmtBal02,@decPl) + ROUND(@lastStmtBal03,@decPl) + ROUND(@lastStmtBal04, @decPl)

   /* Set last statement balances to current aged balances */
   SELECT @lastStmtBal00 = @ageBal00, @lastStmtBal01 = @ageBal01, @lastStmtBal02 = @ageBal02,
      @lastStmtBal03 = @ageBal03, @lastStmtBal04 = @ageBal04

   /* Update statement balances for documents with unpaid balances from previous statement */
   UPDATE ARDoc
   SET    StmtBal = DocBal, CuryStmtBal = CuryDocBal
   WHERE  CustId = @custId
     AND  CpnyID = @CpnyID
-- Only update ARDoc for that company we are processing now
     AND  Rlsed = 1
     AND  StmtDate <> ''
     AND  (StmtBal <> 0.0 OR DocBal <> 0.0)

   /* Update statement balances for documents that have not been on a previous statement */
   IF @incFutureDocs = 1
   BEGIN
      UPDATE ARDoc
      SET    StmtDate = @stmtDate, StmtBal = DocBal, CuryStmtBal = CuryDocBal
      WHERE  CustId = @custId
	AND  CpnyID = @CpnyID
-- Only update ARDoc for that company we are processing now
        AND  Rlsed = 1
        AND  StmtDate = ''
   END
   ELSE
/*  If include future docs is unchecked,
      this includes only those docs that are older than current period
*/
   BEGIN
      UPDATE ARDoc
      SET    StmtDate = @stmtDate, StmtBal = DocBal, CuryStmtBal = CuryDocBal
      WHERE  CustId = @custId
     	AND  CpnyID = @CpnyID
-- Only update ARDoc for that company we are processing now
        AND  Rlsed = 1
        AND  StmtDate = ''
        AND  PerPost <= @perNbr
      /* Modify document statement balances to remove effects of future adjustments */
      /* Future payments, old invoices */
      UPDATE D
      SET    -- Moved to ARAgeCycle////@lastStmtBal00 = ROUND(@lastStmtBal00 + A.AdjAmt + A.adjdiscamt, @decPl),
-- StmtBal is increasing by future adjustments regardless of company of credit documents.
             D.StmtBal = ROUND(D.StmtBal + A.AdjAmt + A.adjdiscamt, @decPl),
             D.CuryStmtBal = ROUND(D.CuryStmtBal + A.CuryAdjAmt + curyadjddiscamt, @decPl)
      FROM   (SELECT AdjAmt = SUM(AdjAmt), CuryAdjAmt = SUM(CuryAdjdAmt), DocType = AdjdDocType,
                     RefNbr = AdjdRefNbr, adjdiscamt = SUM(adjdiscamt), curyadjddiscamt = SUM(curyadjddiscamt)
              FROM   ARAdjust
              WHERE  CustId = @custId
              AND  AdjgPerPost > @perNbr
              GROUP BY AdjdDocType, AdjdRefNbr) A, ARDoc D
      WHERE  D.DocType = A.DocType
        AND  D.RefNbr = A.RefNbr
        AND  D.CustId = @custId
     	AND  D.CpnyID = @CpnyID
-- Considering only debit documents for the particular company.
        AND  D.Rlsed = 1
        AND  D.StmtDate <> ''
        AND (D.PerClosed > @PerNbr OR D.PerClosed = ' ')
-- We needn't update balance with future applications applied to future invoices.
      /* Future invoices, old payments */
      UPDATE D
      SET    -- Moved to ARAgeCycle////@lastStmtBal00 = ROUND(@lastStmtBal00 - A.AdjAmt + A.curyrgolamt, @decPl),
-- StmtBal is decreasing by future adjustments regardless of company of debit documents.
             D.StmtBal = ROUND(D.StmtBal + A.AdjAmt - A.curyrgolamt, @decPl),
             D.CuryStmtBal = ROUND(D.CuryStmtBal + A.CuryAdjAmt, @decPl)
      FROM   (SELECT AdjAmt = SUM(j.AdjAmt), CuryAdjAmt = SUM(j.CuryAdjgAmt), DocType = j.AdjgDocType,
                     RefNbr = j.AdjgRefNbr, curyrgolamt = SUM(j.curyrgolamt)
              FROM   ARAdjust j
                     INNER JOIN ARDoc n ON n.CustID = j.CustID AND n.DocType = j.AdjdDocType AND n.RefNbr = j.AdjdRefNbr
              WHERE  n.Rlsed = 1 AND j.CustId = @custId
              AND  n.PerPost > @perNbr
              GROUP BY j.AdjgDocType, j.AdjgRefNbr) A, ARDoc D
      WHERE  D.DocType = A.DocType
        AND  D.RefNbr = A.RefNbr
        AND  D.CustId = @custId
     	AND  D.CpnyID = @CpnyID
-- Considering only credit documents for the particular company.
        AND  D.Rlsed = 1
        AND  D.StmtDate <> ''
        AND (D.PerClosed > @PerNbr OR D.PerClosed = ' ')
-- We needn't update balance with future applications applied to future invoices.
   END
-- The statement was removed here. It was wrong. The correct logic was included in the previous statement.

   /* Update the customer statement balances and date */
   UPDATE AR_Balances
   SET    LastStmtDate = @stmtDate,
          LastStmtBegBal = ROUND(@lastStmtBegBal,@decPl),
          LastStmtBal00 = ROUND(@lastStmtBal00,@decPl),
          LastStmtBal01 = ROUND(@lastStmtBal01,@decPl),
          LastStmtBal02 = ROUND(@lastStmtBal02,@decPl),
          LastStmtBal03 = ROUND(@lastStmtBal03,@decPl),
          LastStmtBal04 = ROUND(@lastStmtBal04,@decPl)
   WHERE AR_BALANCES.CUSTID = @CUSTID
   	AND AR_BALANCES.CpnyID = @CpnyID
-- The only record will be updated.

   /* Get the next customer */
   FETCH Customer_Crsr INTO @custId, @perNbr, @CpnyID, @lastStmtDate, @lastStmtBegBal, @lastStmtBal00,
-- Fetching CpnyID as well.
                            @lastStmtBal01, @lastStmtBal02, @lastStmtBal03, @lastStmtBal04,
                            @ageBal00, @ageBal01, @ageBal02, @ageBal03, @ageBal04
END

/* Close and deallocate the customer cursor */
CLOSE Customer_Crsr
DEALLOCATE Customer_Crsr

/*
Set new field CloseDateTime_Prev = Last month's closing date (CloseDateTime)
And update CloseDateTime = to current Calendar Date
*/
UPDATE ARStmt
   SET ARStmt.CloseDateTime_Prev = ARStmt.CloseDateTime,
	ARStmt.CloseDateTime = getdate(),
	ARStmt.LastStmtDate = @StmtDate
 WHERE ARStmt.StmtCycleID = @CurCycle



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARCloseCycle] TO [MSDSL]
    AS [dbo];

