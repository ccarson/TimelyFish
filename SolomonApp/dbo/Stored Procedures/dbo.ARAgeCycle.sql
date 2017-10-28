 /****** Object:  Stored Procedure dbo.ARAgeCycle    Script Date: 4/7/98 12:30:33 PM ******/
CREATE procedure ARAgeCycle @curCycle varchar(2), @ageDate smalldatetime, @incFutureDocs tinyint
AS
SET NOCOUNT ON
DECLARE @decPl    int,
        @date1    smalldatetime,
        @date2    smalldatetime,
        @date3    smalldatetime,
        @credits  float,
        @custId   varchar(15),
        @docType  varchar(2),
        @refNbr   varchar(10),
        @perNbr   varchar(6),
	@cpnyid   varchar(10),
        @ageBal00 float,
        @ageBal01 float,
        @ageBal02 float,
        @ageBal03 float,
        @ageBal04 float,
        @SaveAgeBal00 float,
        @SaveAgeBal01 float,
        @SaveAgeBal02 float,
        @SaveAgeBal03 float,
        @SaveAgeBal04 float,
        @InclCredits INT,
        @dueDate  smalldatetime,
        @docBal   float,
        @msg      varchar(255)

SELECT @InclCredits=S4Future09 FROM ARSetup (NOLOCK) WHERE SetupID='AR'

/* Look up the number of decimal places for the base currency */
SELECT @decPl = ISNULL(MAX(C.DecPl),2)
FROM   GLSetup G INNER JOIN Currncy C ON G.BaseCuryID = C.CuryId
WHERE  G.SetupId = 'GL'

/* Compute the boundary dates for the aging buckets */
SELECT @date1 = dateadd( day, -AgeDays00, @ageDate ),
       @date2 = dateadd( day, -AgeDays01, @ageDate ),
       @date3 = dateadd( day, -AgeDays02, @ageDate )
FROM   ARStmt
WHERE  StmtCycleId = @curCycle

/* Create cursor on customers on the given statement cycle */
DECLARE Customer_Crsr INSENSITIVE CURSOR FOR
   SELECT Customer.CustId, Customer.PerNbr, AR_Balances.cpnyid
   FROM   Customer INNER JOIN ar_balances ON customer.custid = ar_balances.custid
   WHERE  customer.StmtCycleId = @curCycle
     AND  ar_balances.LastAgeDate <= @ageDate
   ORDER BY Customer.StmtCycleId, Customer.CustId

/* Open cursor and fetch first row */
OPEN Customer_Crsr
FETCH Customer_Crsr INTO @custId, @perNbr, @cpnyid

/* Loop over customers */
WHILE @@FETCH_STATUS = 0
BEGIN
   /* Initialize age balances */
   SELECT @ageBal00 = 0.0, @ageBal01 = 0.0, @ageBal02 = 0.0, @ageBal03 = 0.0, @ageBal04 = 0.0

   /* Send customer id as progress message */
   SELECT @msg = 'Customer ID: ' + @custId
   PRINT @msg

   /* Get a total of unapplied credits */
   IF @incFutureDocs = 1
   BEGIN
      SELECT @credits = ISNULL(SUM(DocBal),0.0)
      FROM   ARDoc
      WHERE  CustId = @custId
        AND  Rlsed = 1
        AND  DocBal > 0
        AND  (DocType IN ( 'PA', 'CM', 'PP' ) AND @InclCredits=0 OR DocType IN ( 'DA', 'SB'))
	AND  cpnyid = @cpnyid
   END
   ELSE
   BEGIN
      SELECT @credits = ISNULL(SUM(DocBal),0.0)
      FROM   ARDoc
      WHERE  CustId = @custId
        AND  Rlsed = 1
        AND  DocBal > 0
        AND  (DocType IN ( 'PA', 'CM', 'PP' ) AND @InclCredits=0 OR DocType IN ( 'DA', 'SB'))
        AND  PerPost <= @perNbr
	AND  cpnyid = @cpnyid

      /* Adjust credits balance to remove effects of future adjustments */
      /* Future invoices, old payments */
      SELECT    @credits = ROUND(@credits + COALESCE(SUM(A.AdjAmt - A.curyrgolamt),0), @decPl)
-- @credits is decreasing by future adjustments regardless of company of debit documents.
      FROM	ARDoc D INNER JOIN ARAdjust A ON
		D.DocType = A.AdjdDocType AND  D.RefNbr = A.AdjdRefNbr AND A.CustID=D.CustID
		INNER JOIN ARDoc P ON
		P.DocType = A.AdjgDocType AND  P.RefNbr = A.AdjgRefNbr AND A.CustID=P.CustID
      WHERE	D.CustID = @custid
-- Considering only credit documents for the particular company.
     	AND  P.CpnyID = @CpnyID
        AND  (P.DocType NOT IN ( 'PA', 'CM', 'PP' ) OR @InclCredits = 0)
-- We needn't update balance with future applications applied to future invoices.
	AND  D.PerPost > @pernbr
	AND  A.AdjgPerPost <= @pernbr
        AND  P.Rlsed = 1
   END

   /* Declare cursor on documents to compute aging bucket values */
   IF @incFutureDocs = 1
   BEGIN
      DECLARE Doc_Crsr CURSOR FOR
      SELECT  DocType, RefNbr,
              DueDate=CASE WHEN DocType IN ('PA','CM','PP') THEN DocDate ELSE DueDate END, DocBal=CASE WHEN DocType IN ('PA','CM','PP') THEN -DocBal ELSE DocBal END
      FROM   ARDoc
      WHERE  CustId = @custId
        AND  Rlsed = 1
        AND  DocBal > 0
        AND  (DocType IN ( 'IN', 'DM', 'FI', 'NC', 'NS', 'RP', 'SC' ) OR @InclCredits=1 AND DocType IN ('PA','CM','PP'))
	AND  cpnyid = @cpnyid
      FOR READ ONLY
   END
   ELSE
   BEGIN
      DECLARE Doc_Crsr CURSOR FOR
      SELECT DocType, RefNbr,
             DueDate=CASE WHEN DocType IN ('PA','CM','PP') THEN DocDate ELSE DueDate END, DocBal=CASE WHEN DocType IN ('PA','CM','PP') THEN -DocBal ELSE DocBal END
      FROM   ARDoc
      WHERE  CustId = @custId
        AND  Rlsed = 1
        AND  (DocType IN ( 'IN', 'DM', 'FI', 'NC', 'NS', 'RP', 'SC' ) OR @InclCredits=1 AND DocType IN ('PA','CM','PP'))
        AND  PerPost <= @perNbr
        AND  (PerClosed > @PerNbr OR PerClosed = ' ')
	AND  cpnyid = @cpnyid
      FOR READ ONLY
   END

   /* Add doc balances to appropriate aging total */
   OPEN Doc_Crsr
   FETCH Doc_Crsr INTO @docType, @refNbr, @dueDate, @docBal
   WHILE @@FETCH_STATUS = 0
   BEGIN
      IF @incFutureDocs = 0 BEGIN
	   /* Adjust document balance to remove effects of future adjustments */
	   /* Future payments, old invoices */
           IF @DocType IN ( 'IN', 'DM', 'FI', 'NC', 'NS', 'RP', 'SC' )
	   SELECT    @docBal = ROUND(@docBal + COALESCE(SUM(A.AdjAmt + A.adjdiscamt),0), @decPl)
      -- @docBal is increasing by future adjustments regardless of company of credit documents.
	      FROM	ARAdjust A
	      WHERE	A.CustID = @CustID
		AND  A.AdjdDocType = @docType AND  A.AdjdRefNbr = @RefNbr
		AND  A.AdjgPerPost > @pernbr
           ELSE
	      /* Future invoices, old payments */
	      SELECT    @docBal = ROUND(@docBal - COALESCE(SUM(A.AdjAmt - A.curyrgolamt),0), @decPl)
	-- @docBal is decreasing by future adjustments regardless of company of debit documents.
	      FROM	ARDoc D INNER JOIN ARAdjust A ON
			D.DocType = A.AdjdDocType AND  D.RefNbr = A.AdjdRefNbr AND A.CustID=D.CustID
	      WHERE	A.CustID = @custid
		AND  A.AdjgDocType = @docType AND  A.AdjgRefNbr = @RefNbr
		AND  D.PerPost > @pernbr
      END

      /* Determine aging bucket by due date */
      IF @dueDate < @date3
         SELECT @ageBal04 = @ageBal04 + @docBal
      ELSE IF @dueDate < @date2
         SELECT @ageBal03 = @ageBal03 + @docBal
      ELSE IF @dueDate < @date1
         SELECT @ageBal02 = @ageBal02 + @docBal
      ELSE IF @dueDate < @ageDate
         SELECT @ageBal01 = @ageBal01 + @docBal
      ELSE
         SELECT @ageBal00 = @ageBal00 + @docBal
	      /* Fetch next document */
      FETCH Doc_Crsr INTO @docType, @refNbr, @dueDate, @docBal
   END
   CLOSE Doc_Crsr
   DEALLOCATE Doc_Crsr

   SELECT @SaveAgeBal00=CASE WHEN @ageBal00<0 THEN @ageBal00 ELSE 0 END,
	    @SaveAgeBal01=CASE WHEN @ageBal01<0 THEN @ageBal01 ELSE 0 END,
	    @SaveAgeBal02=CASE WHEN @ageBal02<0 THEN @ageBal02 ELSE 0 END,
	    @SaveAgeBal03=CASE WHEN @ageBal03<0 THEN @ageBal03 ELSE 0 END,
	    @SaveAgeBal04=CASE WHEN @ageBal04<0 THEN @ageBal04 ELSE 0 END

   SELECT @AgeBal00=CASE WHEN @ageBal00>0 THEN @ageBal00 ELSE 0 END,
	    @AgeBal01=CASE WHEN @ageBal01>0 THEN @ageBal01 ELSE 0 END,
	    @AgeBal02=CASE WHEN @ageBal02>0 THEN @ageBal02 ELSE 0 END,
	    @AgeBal03=CASE WHEN @ageBal03>0 THEN @ageBal03 ELSE 0 END,
	    @AgeBal04=CASE WHEN @ageBal04>0 THEN @ageBal04 ELSE 0 END

   /* Apply open credits to aging balances, oldest category first */
   IF @credits < @ageBal04
   BEGIN
      SELECT @ageBal04 = @ageBal04 - @credits
   END
   ELSE IF @credits < @ageBal04 + @ageBal03
   BEGIN
      SELECT @credits = @credits - @ageBal04
      SELECT @ageBal04 = 0.0, @ageBal03 = @ageBal03 - @credits
   END
   ELSE IF @credits < @ageBal04 + @ageBal03 + @ageBal02
   BEGIN
      SELECT @credits = @credits - @ageBal04 - @ageBal03
      SELECT @ageBal04 = 0.0, @ageBal03 = 0.0, @ageBal02 = @ageBal02 - @credits
   END
   ELSE IF @credits < @ageBal04 + @ageBal03 + @ageBal02 + @ageBal01
   BEGIN
      SELECT @credits = @credits - @ageBal04 - @ageBal03 - @ageBal02
      SELECT @ageBal04 = 0.0, @ageBal03 = 0.0, @ageBal02 = 0.0, @ageBal01 = @ageBal01 - @credits
   END
   ELSE
   BEGIN
      SELECT @credits = @credits - @ageBal04 - @ageBal03 - @ageBal02 - @ageBal01
      SELECT @ageBal04 = 0.0, @ageBal03 = 0.0, @ageBal02 = 0.0, @ageBal01 = 0.0,
         @ageBal00 = @ageBal00 - @credits
   END

   SELECT @AgeBal00=@SaveAgeBal00+@AgeBal00,
	    @AgeBal01=@SaveAgeBal01+@AgeBal01,
	    @AgeBal02=@SaveAgeBal02+@AgeBal02,
	    @AgeBal03=@SaveAgeBal03+@AgeBal03,
	    @AgeBal04=@SaveAgeBal04+@AgeBal04

   /* Update the customer aging balances */
   UPDATE ar_balances
   SET    AgeBal00 = ROUND(@ageBal00,@decPl), AgeBal01 = ROUND(@ageBal01,@decPl),
          AgeBal02 = ROUND(@ageBal02,@decPl), AgeBal03 = ROUND(@ageBal03,@decPl),
          AgeBal04 = ROUND(@ageBal04,@decPl), LastAgeDate = @ageDate
   WHERE ar_balances.custid = @custid and ar_balances.cpnyid = @cpnyid

   /* Get the next customer */
   FETCH Customer_Crsr INTO @custId, @perNbr, @cpnyid
END

/* Close and deallocate the customer cursor */
CLOSE Customer_Crsr
DEALLOCATE Customer_Crsr


