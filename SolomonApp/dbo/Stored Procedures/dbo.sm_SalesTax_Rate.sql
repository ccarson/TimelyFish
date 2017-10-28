 CREATE PROCEDURE
	sm_SalesTax_Rate
		@TaxID	varchar(10)
AS
	DECLARE	@TaxType	varchar(1),
		@TaxRate	float

	SELECT @TaxType = '', @TaxRate = 0.00

	SELECT @TaxType = TaxType, @TaxRate = TaxRate
	FROM SalesTax (NOLOCK)
	WHERE TaxID = @TaxID

--	PRINT 'TaxType = ' + @TaxType
--	PRINT 'TaxRate = ' + CAST(@TaxRate AS varchar(10))

	IF @TaxType = 'G'
	BEGIN
		SELECT @TaxRate = SUM(TaxRate)
		FROM SalesTax (NOLOCK) INNER JOIN SlsTaxGrp (NOLOCK) ON SalesTax.TaxID = SlsTaxGrp.TaxID
		WHERE SlsTaxGrp.GroupID = @TaxID

--		PRINT '*TaxType = ' + @TaxType
--		PRINT '*TaxRate = ' + CAST(@TaxRate AS varchar(10))
	END

	SELECT @TaxRate


