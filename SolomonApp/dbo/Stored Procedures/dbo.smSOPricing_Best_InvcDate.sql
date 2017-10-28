 CREATE PROCEDURE
	smSOPricing_Best_InvcDate
		@CustID				varchar(15),
		@CustSiteID			varchar(10),
		@InvtID				varchar(30),
		@InvcDate			smalldatetime,
		@BasePrice			float
		
AS
	--Used in SD20300 to retrieve the lowest special price among all smSOPricing records with StartDate/EndDate ranges
	--that include the Invoice Date.  If Base Option is Amount, price = Amount.  If Base Option is Discount, discount is
	--applied to BasePrice parm to determine price.  Returns dataset of prices in order from lowest to highest.

	SELECT * FROM smSOPricing

	WHERE
		CustID = @CustID AND
		ShipToID = @CustSiteID AND
		Invtid = @InvtID AND
		StartDate <= @InvcDate AND
		(EndDate = '01/01/1900' OR EndDate >= @InvcDate)

	ORDER BY
		CASE WHEN BaseOption = 'A' THEN
			Amount
		ELSE
			ROUND(@BasePrice - (@BasePrice * Amount * .01), 3)
		END


		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[smSOPricing_Best_InvcDate] TO [MSDSL]
    AS [dbo];

