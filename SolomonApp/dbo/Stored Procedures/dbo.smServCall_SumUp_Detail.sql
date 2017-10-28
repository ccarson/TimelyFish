 CREATE PROCEDURE
	smServCall_SumUp_Detail
		@parm1	varchar(10)
AS
-- local variables
DECLARE
	@ServiceCallID	varchar(10),
	@FetchStatus	int,
-- smProServSetup variables
	@Incl_NB_Labor	int,
	@Incl_NB_TM	int,
-- smServiceCall variables
	@FRTMCost	float,
	@FRTMAmt	float,
	@FRTMTax	float,
	@LaborHrsBilled	float,
	@LaborHrsWorked	float,
	@LaborCost	float,
	@LaborAmt	float,
	@LaborTax	float,
	@TaxTot		float,
	@InvoiceAmt	float,
	@DiscPercent float,
	@DiscAmount  float,
	@SubTotal    float,
-- smServDetail variables
	@DetailType	varchar(1),
	@LineType	varchar(1),
	@TranAmt	float,
	@BillableHr	float,
	@WorkHr		float,
	@ExtPrice	float,
	@TaxAmt		float,
	@POCost		float,
	@Cost		float,
	@Qty		float,
-- SalesTax variable
	@InclusiveTax	varchar(1),
    @DecPl as SmallInt

SELECT  @DecPl = c.DecPl
  FROM  GLSetup s (nolock)  INNER JOIN Currncy c
                      ON s.BaseCuryID = c.CuryID
-- initialize
SELECT @ServiceCallID = @parm1

SELECT @FRTMCost = 0
SELECT @FRTMAmt = 0
SELECT @FRTMTax = 0
SELECT @LaborHrsBilled = 0
SELECT @LaborHrsWorked = 0
SELECT @LaborCost = 0
SELECT @LaborAmt = 0
SELECT @LaborTax = 0
SELECT @TaxTot = 0
SELECT @InvoiceAmt = 0
SELECT @DiscPercent = 0
SELECT @DiscAmount = 0
SELECT @SubTotal = 0

-- make sure this Service Call record is not compeleted yet
IF NOT EXISTS (	SELECT ServiceCallID
		FROM smServCall
		WHERE 	ServiceCallID = @ServiceCallID AND
			ServiceCallCompleted = 0)
BEGIN
	GOTO FINISH
END

-- get flags from smProServSetup, need to include Cost for Non-Billable line type
SELECT @Incl_NB_Labor = InclNBLabor, @Incl_NB_TM = InclNBTM FROM smProServSetup (NOLOCK) option(Fast 100)
IF @@error <> 0 OR @@rowcount = 0 GOTO FINISH

-- cursor for smServDetail table
DECLARE crs_smServDetail CURSOR FOR
	SELECT 	sd.DetailType, sd.LineTypes, sd.TranAmt, sd.Billable, sd.WorkHr,
		sd.ExtPrice, sd.TaxAmt00, sd.POCost, sd.Cost, sd.Quantity, ISNULL (st.PrcTaxIncl, 'N')
	FROM	smServDetail sd (NOLOCK) LEFT OUTER JOIN SalesTax st (NOLOCK) ON sd.TaxID00 = st.TaxID
	WHERE	sd.ServiceCallID = @ServiceCallID

OPEN crs_smServDetail

FETCH NEXT FROM crs_smServDetail into
		@DetailType, @LineType, @TranAmt, @BillableHr,
		@WorkHr, @ExtPrice, @TaxAmt, @POCost, @Cost, @Qty, @InclusiveTax

SELECT @FetchStatus = @@Fetch_Status
WHILE @FetchStatus = 0
BEGIN
	-- labor
	IF @DetailType = 'L'
	BEGIN
		-- for Non-Billable linetype, include only if flag is set
		-- for other linetype, include always
		IF @LineType <> 'N' OR @Incl_NB_Labor <> 0
		BEGIN
			SELECT @LaborCost = @LaborCost + @TranAmt
		END

		SELECT @LaborHrsBilled = @LaborHrsBilled + @BillableHr
		SELECT @LaborHrsWorked = @LaborHrsWorked + @WorkHr
		SELECT @LaborAmt = @LaborAmt + @ExtPrice
		SELECT @LaborTax = @LaborTax + @TaxAmt
	END
	-- material
	ELSE BEGIN
		-- for Non-Billable linetype, include only if flag is set
		-- for other linetype, include always
		IF @LineType <> 'N' OR @Incl_NB_TM <> 0
		BEGIN
			SELECT @FRTMCost = @FRTMCost + @TranAmt
		END
		IF @InclusiveTax = 'Y' AND @LineType = 'B'
			SELECT @FRTMAmt = @FRTMAmt + @ExtPrice - @TaxAmt
		ELSE
			SELECT @FRTMAmt = @FRTMAmt + @ExtPrice
		SELECT @FRTMTax = @FRTMTax + @TaxAmt
	END

	FETCH NEXT FROM crs_smServDetail into
		@DetailType, @LineType, @TranAmt, @BillableHr,
		@WorkHr, @ExtPrice, @TaxAmt, @POCost, @Cost, @Qty, @InclusiveTax
	SELECT @FetchStatus = @@Fetch_Status
END

CLOSE crs_smServDetail
DEALLOCATE crs_smServDetail

-- IP 07/10/2002 de 229773
SELECT @DiscPercent = DiscPercent,
	   @DiscAmount = DiscAmount
FROM 	smServCall
WHERE 	ServiceCallID = @ServiceCallID
AND		ServiceCallCompleted = 0

-- sum up Tax total, and Invoice amount
SELECT @TaxTot = @LaborTax + @FRTMTax
SELECT @SubTotal = @LaborAmt + @FRTMAmt

-- print 'The OLD discount percent:' + STR(@DiscPercent, 10, 2)
-- print 'The OLD discount amount:' + STR(@DiscAmount, 10, 2)
-- if the there is a discount amount, then, use it and recalc the %
-- else if the is a discount %, then, use it and recalc the amount
IF @DiscAmount > 0.0
	BEGIN
		IF @SubTotal > 0.0
			BEGIN
				SELECT @DiscPercent = @DiscAmount / @SubTotal * 100
			END
		ELSE
			BEGIN
				SELECT @DiscPercent = 0
			END
		-- print 'NEW discount percent: ' + STR(@DiscPercent, 10, 2)
	END
ELSE
	BEGIN
		IF @DiscPercent > 0.0 	SELECT @DiscAmount = Round(@SubTotal * (@DiscPercent / 100), @DecPl)
		-- print 'NEW discount amount:' + STR(@DiscAmount, 10, 2)
	END

SELECT @InvoiceAmt =  @SubTotal - @DiscAmount + @TaxTot

-- print 'subtotal amount: ' + str(@SubTotal, 10, 2)
-- print 'discount amount: ' + str(@DiscAmount, 10, 2)
-- print 'tax amount: ' + str(@TaxTot, 10, 2)
-- print 'invoice amount: ' + str(@InvoiceAmt, 10, 2)

-- start a transaction
BEGIN TRAN

-- update smServCall record
UPDATE smServCall
SET	CostFRTM = @FRTMCost,
	AmountFRTM = @FRTMAmt,
	HrsBilled = @LaborHrsBilled,
	HrsWorked = @LaborHrsWorked,
	CostLabor = @LaborCost,
	AmountLabor = @LaborAmt,
	TaxFRTM = @FRTMTax,
	TaxLabor = @LaborTax,
	TaxTot = @TaxTot,
	InvoiceAmount = @InvoiceAmt,
	DiscPercent = @DiscPercent,
	DiscAmount = @DiscAmount
WHERE ServiceCallID = @ServiceCallID

-- if get here, everything is OK, commit transaction
COMMIT TRAN

FINISH:


