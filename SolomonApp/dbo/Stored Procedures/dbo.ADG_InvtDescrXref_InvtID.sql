 CREATE PROCEDURE ADG_InvtDescrXref_InvtID
	@DescrSeg1 varchar(20),
	@DescrSeg2 varchar(20),
	@DescrSeg3 varchar(20),
	@DescrSeg4 varchar(20),
	@DescrSeg5 varchar(20),
	@DescrSeg6 varchar(20),
	@DescrSeg7 varchar(20),
	@DescrSeg8 varchar(20),
	@DescrSeg9 varchar(20),
	@DescrSeg10 varchar(20)
AS
	DECLARE @WhereClause varchar(1024)

	-- This procedure is dependent on the description segments
	-- being passed contiguously, meaning if a segment is passed
	-- with a value, all the segments before it must have a value.
	-- For Example, if segment 6 has a value in it then segments 1
	-- to 5 must also have a value.

	-- No wildcards need to be passed for any parameters, any
	-- parameters not passed will not be referenced in the where
	-- clause.

	CREATE TABLE #ItemLookupTemp
	(	InvtID varchar(30)
	)

	-- If no description segments were passed, we can go directly
	-- to the main query.
	IF @DescrSeg1 = ''
	BEGIN

		GOTO MainQuery
	END

	-- If 10 description segments were passed...
	IF @DescrSeg10 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		  JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		  JOIN InvtDescrXref d3 ON d3.InvtID = d1.InvtID
		  JOIN InvtDescrXref d4 ON d4.InvtID = d1.InvtID
		  JOIN InvtDescrXref d5 ON d5.InvtID = d1.InvtID
		  JOIN InvtDescrXref d6 ON d6.InvtID = d1.InvtID
		  JOIN InvtDescrXref d7 ON d7.InvtID = d1.InvtID
		  JOIN InvtDescrXref d8 ON d8.InvtID = d1.InvtID
		  JOIN InvtDescrXref d9 ON d9.InvtID = d1.InvtID
		  JOIN InvtDescrXref d10 ON d10.InvtID = d1.InvtID
		WHERE  d1.DescrSeg LIKE @DescrSeg1
		  AND  d2.DescrSeg LIKE @DescrSeg2
		  AND  d3.DescrSeg LIKE @DescrSeg3
		  AND  d4.DescrSeg LIKE @DescrSeg4
		  AND  d5.DescrSeg LIKE @DescrSeg5
		  AND  d6.DescrSeg LIKE @DescrSeg6
		  AND  d7.DescrSeg LIKE @DescrSeg7
		  AND  d8.DescrSeg LIKE @DescrSeg8
		  AND  d9.DescrSeg LIKE @DescrSeg9
		  AND  d10.DescrSeg LIKE @DescrSeg10

		GOTO MainQuery
	END

	-- If 9 description segments were passed...
	IF @DescrSeg9 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		  JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		  JOIN InvtDescrXref d3 ON d3.InvtID = d1.InvtID
		  JOIN InvtDescrXref d4 ON d4.InvtID = d1.InvtID
		  JOIN InvtDescrXref d5 ON d5.InvtID = d1.InvtID
		  JOIN InvtDescrXref d6 ON d6.InvtID = d1.InvtID
		  JOIN InvtDescrXref d7 ON d7.InvtID = d1.InvtID
		  JOIN InvtDescrXref d8 ON d8.InvtID = d1.InvtID
		  JOIN InvtDescrXref d9 ON d9.InvtID = d1.InvtID
		WHERE  d1.DescrSeg LIKE @DescrSeg1
		  AND  d2.DescrSeg LIKE @DescrSeg2
		  AND  d3.DescrSeg LIKE @DescrSeg3
		  AND  d4.DescrSeg LIKE @DescrSeg4
		  AND  d5.DescrSeg LIKE @DescrSeg5
		  AND  d6.DescrSeg LIKE @DescrSeg6
		  AND  d7.DescrSeg LIKE @DescrSeg7
		  AND  d8.DescrSeg LIKE @DescrSeg8
		  AND  d9.DescrSeg LIKE @DescrSeg9

		GOTO MainQuery

	END

	-- If 8 description segments were passed...
	IF @DescrSeg8 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp

		SELECT d1.InvtID
		FROM InvtDescrXref d1
		  JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		  JOIN InvtDescrXref d3 ON d3.InvtID = d1.InvtID
		  JOIN InvtDescrXref d4 ON d4.InvtID = d1.InvtID
		  JOIN InvtDescrXref d5 ON d5.InvtID = d1.InvtID
		  JOIN InvtDescrXref d6 ON d6.InvtID = d1.InvtID
		  JOIN InvtDescrXref d7 ON d7.InvtID = d1.InvtID
		  JOIN InvtDescrXref d8 ON d8.InvtID = d1.InvtID
		WHERE  d1.DescrSeg LIKE @DescrSeg1
		  AND  d2.DescrSeg LIKE @DescrSeg2
		  AND  d3.DescrSeg LIKE @DescrSeg3
		  AND  d4.DescrSeg LIKE @DescrSeg4
		  AND  d5.DescrSeg LIKE @DescrSeg5
		  AND  d6.DescrSeg LIKE @DescrSeg6
		  AND  d7.DescrSeg LIKE @DescrSeg7
		  AND  d8.DescrSeg LIKE @DescrSeg8

		GOTO MainQuery
	END

	-- If 7 description segments were passed...

	IF @DescrSeg7 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		  JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		  JOIN InvtDescrXref d3 ON d3.InvtID = d1.InvtID
		  JOIN InvtDescrXref d4 ON d4.InvtID = d1.InvtID
		  JOIN InvtDescrXref d5 ON d5.InvtID = d1.InvtID
		  JOIN InvtDescrXref d6 ON d6.InvtID = d1.InvtID
		  JOIN InvtDescrXref d7 ON d7.InvtID = d1.InvtID
		WHERE  d1.DescrSeg LIKE @DescrSeg1
		  AND  d2.DescrSeg LIKE @DescrSeg2
		  AND  d3.DescrSeg LIKE @DescrSeg3
		  AND  d4.DescrSeg LIKE @DescrSeg4
		  AND  d5.DescrSeg LIKE @DescrSeg5
		  AND  d6.DescrSeg LIKE @DescrSeg6
		  AND  d7.DescrSeg LIKE @DescrSeg7

		GOTO MainQuery
	END

	-- If 6 description segments were passed...
	IF @DescrSeg6 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		  JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		  JOIN InvtDescrXref d3 ON d3.InvtID = d1.InvtID
		  JOIN InvtDescrXref d4 ON d4.InvtID = d1.InvtID
		  JOIN InvtDescrXref d5 ON d5.InvtID = d1.InvtID
		  JOIN InvtDescrXref d6 ON d6.InvtID = d1.InvtID
		WHERE  d1.DescrSeg LIKE @DescrSeg1
		  AND  d2.DescrSeg LIKE @DescrSeg2
		  AND  d3.DescrSeg LIKE @DescrSeg3
		  AND  d4.DescrSeg LIKE @DescrSeg4
		  AND  d5.DescrSeg LIKE @DescrSeg5
		  AND  d6.DescrSeg LIKE @DescrSeg6

		GOTO MainQuery
	END

	-- If 5 description segments were passed...
	IF @DescrSeg5 <> ''
	BEGIN

		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		  JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		  JOIN InvtDescrXref d3 ON d3.InvtID = d1.InvtID
		  JOIN InvtDescrXref d4 ON d4.InvtID = d1.InvtID
		  JOIN InvtDescrXref d5 ON d5.InvtID = d1.InvtID
		WHERE  d1.DescrSeg LIKE @DescrSeg1
		  AND  d2.DescrSeg LIKE @DescrSeg2
		  AND  d3.DescrSeg LIKE @DescrSeg3
		  AND  d4.DescrSeg LIKE @DescrSeg4
		  AND  d5.DescrSeg LIKE @DescrSeg5

		GOTO MainQuery
	END

	-- If 4 description segments were passed...
	IF @DescrSeg4 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		  JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		  JOIN InvtDescrXref d3 ON d3.InvtID = d1.InvtID
		  JOIN InvtDescrXref d4 ON d4.InvtID = d1.InvtID
		WHERE  d1.DescrSeg LIKE @DescrSeg1
		  AND  d2.DescrSeg LIKE @DescrSeg2
		  AND  d3.DescrSeg LIKE @DescrSeg3
		  AND  d4.DescrSeg LIKE @DescrSeg4

		GOTO MainQuery
	END

	-- If 3 description segments were passed...
	IF @DescrSeg3 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		  JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		  JOIN InvtDescrXref d3 ON d3.InvtID = d1.InvtID
		WHERE  d1.DescrSeg LIKE @DescrSeg1
		  AND  d2.DescrSeg LIKE @DescrSeg2
		  AND  d3.DescrSeg LIKE @DescrSeg3

		GOTO MainQuery
	END

	-- If 2 description segments were passed...
	IF @DescrSeg2 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		 JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		WHERE  d1.DescrSeg LIKE @DescrSeg1
		  AND  d2.DescrSeg LIKE @DescrSeg2

		GOTO MainQuery
	END

	-- If 1 description segment was passed...
	IF @DescrSeg1 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp

		SELECT d1.InvtID
		FROM InvtDescrXref d1
		WHERE d1.DescrSeg LIKE @DescrSeg1

		GOTO MainQuery
	END

MainQuery:

	SELECT DISTINCT(InvtID)
	FROM #ItemLookupTemp

	drop table #ItemLookupTemp

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


