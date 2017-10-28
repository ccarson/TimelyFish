 CREATE PROCEDURE ADG_CustLkp_Customer
	@Phone varchar(30),
	@NameSeg1 varchar(20),
	@NameSeg2 varchar(20),
	@NameSeg3 varchar(20),
	@NameSeg4 varchar(20),
	@NameSeg5 varchar(20)
AS
	-- This procedure is dependent on the name segments being
	-- passed contiguously, meaning if a segment is passed with a
	-- value, all the segments before it must have a value.
	-- For Example, if segment 4 has a value in it then segments 1
	-- to 3 must also have a value.

	-- No wildcards need to be passed for any parameters, any
	-- parameters not passed will not be referenced in the where
	-- clause.

	-- If no name segments were passed, we can go directly to the
	-- main query.
	IF @NameSeg1 = ''
	BEGIN
		GOTO MainQuery
	END

	CREATE TABLE #CustLkpTemp
	(	CustID varchar(15)
	)

	-- If 5 name segments were passed.
	IF @NameSeg5 <> ''
	BEGIN

		INSERT INTO #CustLkpTemp
		SELECT d1.CustID
		FROM CustNameXref d1
		JOIN CustNameXref d2 ON d2.CustID = d1.CustID
		JOIN CustNameXref d3 ON d3.CustID = d1.CustID
		JOIN CustNameXref d4 ON d4.CustID = d1.CustID
		JOIN CustNameXref d5 ON d5.CustID = d1.CustID
		WHERE d1.NameSeg LIKE @NameSeg1 AND
			d2.NameSeg LIKE @NameSeg2 AND
			d3.NameSeg LIKE @NameSeg3 AND
			d4.NameSeg LIKE @NameSeg4 AND

			d5.NameSeg LIKE @NameSeg5

		GOTO MainQuery
	END

	-- If 4 name segments were passed.
	IF @NameSeg4 <> ''
	BEGIN
		INSERT INTO #CustLkpTemp
		SELECT d1.CustID
		FROM CustNameXref d1
		JOIN CustNameXref d2 ON d2.CustID = d1.CustID
		JOIN CustNameXref d3 ON d3.CustID = d1.CustID
		JOIN CustNameXref d4 ON d4.CustID = d1.CustID
		WHERE d1.NameSeg LIKE @NameSeg1 AND
			d2.NameSeg LIKE @NameSeg2 AND
			d3.NameSeg LIKE @NameSeg3 AND
			d4.NameSeg LIKE @NameSeg4

		GOTO MainQuery
	END

	-- If 3 name segments were passed.
	IF @NameSeg3 <> ''
	BEGIN
		INSERT INTO #CustLkpTemp
		SELECT d1.CustID
		FROM CustNameXref d1
		JOIN CustNameXref d2 ON d2.CustID = d1.CustID
		JOIN CustNameXref d3 ON d3.CustID = d1.CustID
		WHERE d1.NameSeg LIKE @NameSeg1 AND
			d2.NameSeg LIKE @NameSeg2 AND
			d3.NameSeg LIKE @NameSeg3

		GOTO MainQuery
	END

	-- If 2 name segments were passed.
	IF @NameSeg2 <> ''
	BEGIN
		INSERT INTO #CustLkpTemp
		SELECT d1.CustID
		FROM CustNameXref d1
		JOIN CustNameXref d2 ON d2.CustID = d1.CustID
		WHERE d1.NameSeg LIKE @NameSeg1 AND
			d2.NameSeg LIKE @NameSeg2


		GOTO MainQuery
	END

	-- If 1 name segment was passed.
	IF @NameSeg1 <> ''
	BEGIN
		INSERT INTO #CustLkpTemp

		SELECT d1.CustID
		FROM CustNameXref d1
		WHERE d1.NameSeg LIKE @NameSeg1

		GOTO MainQuery
	END

MainQuery:

	-- If no name segments were passed.
	IF @NameSeg1 = ''

	BEGIN
		-- If no phone was passed.
		IF @Phone = ''
		BEGIN
			SELECT CustID, Name, Phone
			FROM Customer
			ORDER BY CustID
		END
		ELSE
		BEGIN
			SELECT CustID, Name, Phone
			FROM Customer
			WHERE Phone LIKE @Phone
			ORDER BY CustID
		END
	END
	ELSE
	BEGIN
		-- If one or more name segments were passed.

		-- If no phone was passed.
		IF @Phone = ''
		BEGIN
			SELECT distinct #CustLkpTemp.CustID, Name, Phone
			FROM #CustLkpTemp
			LEFT JOIN Customer ON Customer.CustID = #CustLkpTemp.CustID
			ORDER BY #CustLkpTemp.CustID
		END
		ELSE
		BEGIN
			SELECT distinct #CustLkpTemp.CustID, Name, Phone
			FROM #CustLkpTemp
			LEFT JOIN Customer ON Customer.CustID = #CustLkpTemp.CustID
			WHERE Phone LIKE @Phone
			ORDER BY #CustLkpTemp.CustID
		END

		drop table #CustLkpTemp
	END

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


