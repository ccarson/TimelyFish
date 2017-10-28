 CREATE PROCEDURE ADG_ItemLookup2
	@InvtID varchar(30),
	@ClassID varchar(6),
	@MfgClassID varchar(10),           -- New parm
	@ProjectID varchar(16),
	@SiteID varchar(10),
	@CustID varchar(15),
	@VendID varchar(15),
	@Substitutes smallint,
	@Globals smallint,
	@ManufacturerPartNo smallint,
	@TranMthd varchar(1),
	@XRefNeeded smallint,
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
	DECLARE @WhereClause varchar(2000)
	DECLARE @OrderClause varchar(255)
	DECLARE @AllocWhere varchar(200)

	-- This procedure is dependent on the description segments
	-- being passed contiguously, meaning if a segment is passed
	-- with a value, all the segments before it must have a value.
	-- For Example, if segment 6 has a value in it then segments 1
	-- to 5 must also have a value.

	-- No wildcards need to be passed for any parameters, any
	-- parameters not passed will not be referenced in the where
	-- clause.

	-- If no description segments were passed, we can go directly
	-- to the main query.
	IF @DescrSeg1 = ''
	BEGIN

		GOTO MainQuery
	END

	CREATE TABLE #ItemLookupTemp
	(	InvtID varchar(30)
	)

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
		WHERE d1.DescrSeg LIKE @DescrSeg1 AND
			d2.DescrSeg LIKE @DescrSeg2 AND
			d3.DescrSeg LIKE @DescrSeg3 AND
			d4.DescrSeg LIKE @DescrSeg4 AND
			d5.DescrSeg LIKE @DescrSeg5 AND
			d6.DescrSeg LIKE @DescrSeg6 AND
			d7.DescrSeg LIKE @DescrSeg7 AND
			d8.DescrSeg LIKE @DescrSeg8 AND
			d9.DescrSeg LIKE @DescrSeg9 AND
			d10.DescrSeg LIKE @DescrSeg10

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
		WHERE d1.DescrSeg LIKE @DescrSeg1 AND
			d2.DescrSeg LIKE @DescrSeg2 AND
			d3.DescrSeg LIKE @DescrSeg3 AND
			d4.DescrSeg LIKE @DescrSeg4 AND
			d5.DescrSeg LIKE @DescrSeg5 AND
			d6.DescrSeg LIKE @DescrSeg6 AND
			d7.DescrSeg LIKE @DescrSeg7 AND
			d8.DescrSeg LIKE @DescrSeg8 AND
			d9.DescrSeg LIKE @DescrSeg9

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
		WHERE d1.DescrSeg LIKE @DescrSeg1 AND
			d2.DescrSeg LIKE @DescrSeg2 AND
			d3.DescrSeg LIKE @DescrSeg3 AND

			d4.DescrSeg LIKE @DescrSeg4 AND
			d5.DescrSeg LIKE @DescrSeg5 AND
			d6.DescrSeg LIKE @DescrSeg6 AND
			d7.DescrSeg LIKE @DescrSeg7 AND
			d8.DescrSeg LIKE @DescrSeg8

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
		WHERE d1.DescrSeg LIKE @DescrSeg1 AND
			d2.DescrSeg LIKE @DescrSeg2 AND
			d3.DescrSeg LIKE @DescrSeg3 AND
			d4.DescrSeg LIKE @DescrSeg4 AND
			d5.DescrSeg LIKE @DescrSeg5 AND
			d6.DescrSeg LIKE @DescrSeg6 AND
			d7.DescrSeg LIKE @DescrSeg7

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
		WHERE d1.DescrSeg LIKE @DescrSeg1 AND
			d2.DescrSeg LIKE @DescrSeg2 AND
			d3.DescrSeg LIKE @DescrSeg3 AND
			d4.DescrSeg LIKE @DescrSeg4 AND
			d5.DescrSeg LIKE @DescrSeg5 AND

			d6.DescrSeg LIKE @DescrSeg6

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
		WHERE d1.DescrSeg LIKE @DescrSeg1 AND
			d2.DescrSeg LIKE @DescrSeg2 AND
			d3.DescrSeg LIKE @DescrSeg3 AND
			d4.DescrSeg LIKE @DescrSeg4 AND
			d5.DescrSeg LIKE @DescrSeg5

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
		WHERE d1.DescrSeg LIKE @DescrSeg1 AND
			d2.DescrSeg LIKE @DescrSeg2 AND
			d3.DescrSeg LIKE @DescrSeg3 AND
			d4.DescrSeg LIKE @DescrSeg4

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
		WHERE d1.DescrSeg LIKE @DescrSeg1 AND
			d2.DescrSeg LIKE @DescrSeg2 AND
			d3.DescrSeg LIKE @DescrSeg3

		GOTO MainQuery
	END

	-- If 2 description segments were passed...
	IF @DescrSeg2 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		  JOIN InvtDescrXref d2 ON d2.InvtID = d1.InvtID
		WHERE d1.DescrSeg LIKE @DescrSeg1 AND
			d2.DescrSeg LIKE @DescrSeg2

		GOTO MainQuery

	END

	-- If 1 description segment was passed...
	IF @DescrSeg1 <> ''
	BEGIN
		INSERT INTO #ItemLookupTemp
		SELECT d1.InvtID
		FROM InvtDescrXref d1
		WHERE d1.DescrSeg LIKE @DescrSeg1

		IF (@@RowCount = 0) and (@DescrSeg2 = '')
		-- only one lookup segment defind and it was not found in InvtDescrXref;
		-- try to find using full decsription field because it may be splitted in InvtDescrXref on '-' chars
			INSERT INTO #ItemLookupTemp
			SELECT InvtID
			FROM Inventory
			WHERE Descr LIKE @DescrSeg1

		GOTO MainQuery
	END

MainQuery:

	----------------------------------------------
	-- CREATE THE WHERE CLAUSE
	----------------------------------------------

	SELECT @WhereClause = ' '
	SELECT @AllocWhere = ' '
	-- If only an inventory id was passed...
	IF @InvtID <> ''
	BEGIN
		IF @XRefNeeded = 0
			SELECT @WhereClause = @WhereClause + 'Inventory.InvtID LIKE ' + QUOTENAME(@InvtID,'''') + ' and '
		else
			SELECT @WhereClause = @WhereClause + 'ItemXref.AlternateID LIKE ' + QUOTENAME(@InvtID,'''') + ' and '
	END

	-- If only a class id was passed...
	IF @ClassID <> ''
			SELECT @WhereClause = @WhereClause + 'Inventory.ClassID LIKE ' + QUOTENAME(@ClassID,'''') + ' and '

	-- If only a site id was passed...
	IF @SiteID <> ''
		SELECT @WhereClause = @WhereClause + 'ItemSite.SiteID LIKE ' + QUOTENAME(@SiteID,'''') + ' and '

	-- If only a Mfg Class ID was passed...
	IF @MfgClassID <> ''
			SELECT @WhereClause = @WhereClause + 'ItemSite.MfgClassID LIKE ' + QUOTENAME(@MfgClassID,'''') + ' and '

	-- If Project ID was passed...for allocated
	IF @ProjectID <> ''
	BEGIN
	
		SELECT @AllocWhere = @AllocWhere + 'InvProjAlloc.ProjectID LIKE ' + QUOTENAME(@ProjectID,'''') + ''
		SELECT @AllocWhere = ' WHERE ' + @AllocWhere
	END

	-- If the query is for purchases
	if @TranMthd = 'P'
		select @WhereClause = @WhereClause + 'Inventory.TranStatusCode in (''AC'',''NU'') and '

	-- If the query is for sales
	if @TranMthd = 'S'
		select @WhereClause = @WhereClause + 'Inventory.TranStatusCode in (''AC'',''NU'') and '

	-- If the customer id was passed...
        If @CustID <> ''
	     	SELECT @WhereClause = @WhereClause + '(AltIDType = ''C'' AND EntityID = ' + QUOTENAME(@CustID,'''') + ') and '

	-- If the vendor id was passed...
        If @VendID <> ''
	        SELECT @WhereClause = @WhereClause + '(AltIDType = ''V'' AND EntityID = ' + QUOTENAME(@VendID,'''') + ') and '

	-- If substitutes was passed...
        If @Substitutes <> 0
	        SELECT @WhereClause = @WhereClause + 'AltIDType = ''S'' and '

	-- If globals was passed...
        If @Globals <> 0
	      	SELECT @WhereClause = @WhereClause + 'AltIDType in (''G'',''K'',''U'',''E'',''I'',''D'',''P'',''B'',''A'',''O'',''N'') and '

	-- If Manufacturer part no was passed...
	If @ManufacturerPartNo <> 0
		SELECT @WhereClause = @WhereClause + 'AltIDType = ''M'' and '
		If Len(@WhereClause) > 1
	BEGIN
		-- Strip off the final 'AND ' and add the closing paren.
		SELECT @WhereClause = SUBSTRING(@WhereClause, 1, DATALENGTH(@WhereClause) - 5)

		-- Add the 'WHERE' word to the where string.
		SELECT @WhereClause = ' WHERE ' + @WhereClause
	END

	----------------------------------------------
	-- EXECUTE THE SQL STATEMENT
	----------------------------------------------

	--Process records that need the ItemXRef table
	If @XRefNeeded <> 0
	BEGIN
		-- If no description segments were passed...
		IF @DescrSeg1 = ''
		BEGIN

			-- The results should be ordered by the alternate ID if it will be displayed.
			-- It will be displayed if different values could be returned for it based on
			-- the search criteria.
		    If CHARINDEX('%', @InvtID) <> 0 Or @InvtID = ''
				SELECT @OrderClause = 'ORDER BY ItemXref.AlternateID, ItemXref.AltIDType, Inventory.InvtID, ItemSite.SiteID'
			ELSE
				SELECT @OrderClause = 'ORDER BY ItemXref.AltIDType, Inventory.InvtID, ItemSite.SiteID'

			IF @ProjectID = ''
			BEGIN
				EXECUTE ('SELECT distinct ' +
					'Inventory.ClassId, ' +
					'Inventory.Descr, ' +
					'Inventory.InvtID, ' +
					'Inventory.StkBasePrc, ' +
					'ItemSite.AvgCost, ' +
					'ItemSite.QtyAvail, ' +
					'ItemSite.QtyAllocProjIN, ' +
					'ItemSite.QtyOnPO, ' +
					'ItemSite.SiteID, ' +
					'AttribDef.*, ' +
					'ItemAttribs.Attrib00, ' +
					'ItemAttribs.Attrib01, ' +
					'ItemAttribs.Attrib02, ' +
					'ItemAttribs.Attrib03, ' +
					'ItemAttribs.Attrib04, ' +
					'ItemAttribs.Attrib05, ' +
					'ItemAttribs.Attrib06, ' +
					'ItemAttribs.Attrib07, ' +
					'ItemAttribs.Attrib08, ' +
					'ItemAttribs.Attrib09 ,' +
	        			'ItemXref.AlternateID, ' +
	        			'ItemXref.AltIDType, ' +
	        			'ItemXref.Descr, ' +
	        			'ItemXref.EntityID ' +
					'FROM Inventory ' +
					'  LEFT JOIN ItemSite ON ItemSite.InvtID = Inventory.InvtID ' +
					'  LEFT JOIN AttribDef ON AttribDef.ClassID = Inventory.ClassID ' +
					'  LEFT JOIN ItemAttribs ON ItemAttribs.InvtID = Inventory.InvtID ' +
					'  LEFT JOIN ItemXref ON ItemXref.InvtID = Inventory.InvtID ' +
					@WhereClause +
					@OrderClause)
			END
			ELSE 
			BEGIN
				EXECUTE ('SELECT distinct ' +
					'Inventory.ClassId, ' +
					'Inventory.Descr, ' +
					'Inventory.InvtID, ' +
					'Inventory.StkBasePrc, ' +
					'ItemSite.AvgCost, ' +
					'ItemSite.QtyAvail, ' +
					'InvProjAlloc.QtyAlloc, ' +
					'ItemSite.QtyOnPO, ' +
					'ItemSite.SiteID, ' +
					'AttribDef.*, ' +
					'ItemAttribs.Attrib00, ' +
					'ItemAttribs.Attrib01, ' +
					'ItemAttribs.Attrib02, ' +
					'ItemAttribs.Attrib03, ' +
					'ItemAttribs.Attrib04, ' +
					'ItemAttribs.Attrib05, ' +
					'ItemAttribs.Attrib06, ' +
					'ItemAttribs.Attrib07, ' +
					'ItemAttribs.Attrib08, ' +
					'ItemAttribs.Attrib09 ,' +
	        			'ItemXref.AlternateID, ' +
	        			'ItemXref.AltIDType, ' +
	        			'ItemXref.Descr, ' +
	        			'ItemXref.EntityID ' +
					'FROM Inventory ' +
					'  LEFT JOIN ItemSite ON ItemSite.InvtID = Inventory.InvtID ' +
					'  JOIN (SELECT InvProjAlloc.InvtID, InvProjAlloc.SiteID, 
					Sum(InvProjAlloc.QtyRemainToIssue)QtyAlloc FROM InvProjAlloc ' + @AllocWhere + ' GROUP BY InvProjAlloc.InvtID, InvProjAlloc.SiteID) InvProjAlloc
					ON InvProjAlloc.InvtID = Inventory.InvtID AND InvProjAlloc.SiteID = ItemSite.SiteID ' +					
					'  LEFT JOIN AttribDef ON AttribDef.ClassID = Inventory.ClassID ' +
					'  LEFT JOIN ItemAttribs ON ItemAttribs.InvtID = Inventory.InvtID ' +
					'  LEFT JOIN ItemXref ON ItemXref.InvtID = Inventory.InvtID ' +

					@WhereClause +
					@OrderClause)
			END
		END
			-- If one or more description segments were passed...
		IF @DescrSeg1 <> ''
		BEGIN
				-- The results should be ordered by the alternate id if it will be displayed.
			-- It will be displayed if different values could be returned for it based on
			-- the search criteria.
	        If CHARINDEX('%', @InvtID) <> 0 Or @InvtID = ''
				SELECT @OrderClause = 'ORDER BY ItemXref.AlternateID, ItemXref.AltIDType, #ItemLookupTemp.InvtID, ItemSite.SiteID'
			ELSE
	            SELECT @OrderClause = 'ORDER BY ItemXref.AltIDType, #ItemLookupTemp.InvtID, ItemSite.SiteID'

			IF @ProjectID = ''
			BEGIN
				EXECUTE ('SELECT distinct ' +
					'Inventory.ClassId, ' +
					'Inventory.Descr, ' +
					'#ItemLookupTemp.InvtID, ' +
					'Inventory.StkBasePrc, ' +
					'ItemSite.AvgCost, ' +
					'ItemSite.QtyAvail, ' +
					'ItemSite.QtyAllocProjIN, ' +
					'ItemSite.QtyOnPO, ' +
					'ItemSite.SiteID, ' +
					'AttribDef.*, ' +
					'ItemAttribs.Attrib00, ' +
					'ItemAttribs.Attrib01, ' +
					'ItemAttribs.Attrib02, ' +
					'ItemAttribs.Attrib03, ' +
					'ItemAttribs.Attrib04, ' +
					'ItemAttribs.Attrib05, ' +
					'ItemAttribs.Attrib06, ' +
					'ItemAttribs.Attrib07, ' +
					'ItemAttribs.Attrib08, ' +
					'ItemAttribs.Attrib09, ' +
	        			'ItemXref.AlternateID, ' +
	        			'ItemXref.AltIDType, ' +
	        			'ItemXref.Descr, ' +
	        			'ItemXref.EntityID ' +
					'FROM #ItemLookupTemp ' +
					'  JOIN Inventory ON Inventory.InvtID = #ItemLookupTemp.InvtID ' +
					'  LEFT JOIN ItemSite ON ItemSite.InvtID = #ItemLookupTemp.InvtID ' +
					'  LEFT JOIN AttribDef ON AttribDef.ClassID = Inventory.ClassID ' +
					'  LEFT JOIN ItemAttribs ON ItemAttribs.InvtID = #ItemLookupTemp.InvtID ' +
	        			'  LEFT JOIN ItemXref ON ItemXref.InvtID = #ItemLookupTemp.InvtID ' +
					@WhereClause +
					@OrderClause)
			END
			ELSE
			BEGIN
				EXECUTE ('SELECT distinct ' +
					'Inventory.ClassId, ' +
					'Inventory.Descr, ' +
					'#ItemLookupTemp.InvtID, ' +
					'Inventory.StkBasePrc, ' +
					'ItemSite.AvgCost, ' +
					'ItemSite.QtyAvail, ' +
					'InvProjAlloc.QtyAlloc, ' +
					'ItemSite.QtyOnPO, ' +
					'ItemSite.SiteID, ' +
					'AttribDef.*, ' +
					'ItemAttribs.Attrib00, ' +
					'ItemAttribs.Attrib01, ' +
					'ItemAttribs.Attrib02, ' +
					'ItemAttribs.Attrib03, ' +
					'ItemAttribs.Attrib04, ' +
					'ItemAttribs.Attrib05, ' +
					'ItemAttribs.Attrib06, ' +
					'ItemAttribs.Attrib07, ' +
					'ItemAttribs.Attrib08, ' +
					'ItemAttribs.Attrib09, ' +
	        			'ItemXref.AlternateID, ' +
	        			'ItemXref.AltIDType, ' +
	        			'ItemXref.Descr, ' +
	        			'ItemXref.EntityID ' +
					'FROM #ItemLookupTemp ' +
					'  JOIN Inventory ON Inventory.InvtID = #ItemLookupTemp.InvtID ' +
					'  LEFT JOIN ItemSite ON ItemSite.InvtID = #ItemLookupTemp.InvtID ' +
					'	JOIN (SELECT InvProjAlloc.InvtID, InvProjAlloc.SiteID,  
					Sum(InvProjAlloc.QtyRemainToIssue)QtyAlloc FROM InvProjAlloc ' + @AllocWhere + ' GROUP BY InvProjAlloc.InvtID, InvProjAlloc.SiteID) InvProjAlloc
					ON InvProjAlloc.InvtID = Inventory.InvtID AND InvProjAlloc.SiteID = ItemSite.SiteID ' +
					'  LEFT JOIN AttribDef ON AttribDef.ClassID = Inventory.ClassID ' +
					'  LEFT JOIN ItemAttribs ON ItemAttribs.InvtID = #ItemLookupTemp.InvtID ' +
	        			'  LEFT JOIN ItemXref ON ItemXref.InvtID = #ItemLookupTemp.InvtID ' +
					@WhereClause +
					@OrderClause)
			END
		END
	END
	--Process records that need the ItemXRef table
	If @XRefNeeded = 0
	BEGIN
		-- If no description segments were passed...
		IF @DescrSeg1 = ''
		BEGIN
			IF @ProjectID = ''
			BEGIN
			EXECUTE ('SELECT distinct ' +
				'Inventory.ClassId, ' +
				'Inventory.Descr, ' +
				'Inventory.InvtID, ' +
				'Inventory.StkBasePrc, ' +
				'ItemSite.AvgCost, ' +
				'ItemSite.QtyAvail, ' +
				'ItemSite.QtyAllocProjIN, ' +
				'ItemSite.QtyOnPO, ' +
				'ItemSite.SiteID, ' +
				'AttribDef.*, ' +
				'ItemAttribs.Attrib00, ' +
				'ItemAttribs.Attrib01, ' +
				'ItemAttribs.Attrib02, ' +
				'ItemAttribs.Attrib03, ' +
				'ItemAttribs.Attrib04, ' +
				'ItemAttribs.Attrib05, ' +
				'ItemAttribs.Attrib06, ' +
				'ItemAttribs.Attrib07, ' +
				'ItemAttribs.Attrib08, ' +
				'ItemAttribs.Attrib09 ' +
				'FROM Inventory ' +
				'  LEFT JOIN ItemSite ON ItemSite.InvtID = Inventory.InvtID ' +
				'  LEFT JOIN AttribDef ON AttribDef.ClassID = Inventory.ClassID ' +
				'  LEFT JOIN ItemAttribs ON ItemAttribs.InvtID = Inventory.InvtID ' +
				@WhereClause +
				'ORDER BY Inventory.InvtID, ItemSite.SiteID')
			END
			ELSE 
			BEGIN
				EXECUTE ('SELECT distinct ' +
					'Inventory.ClassId, ' +
					'Inventory.Descr, ' +
					'Inventory.InvtID, ' +
					'Inventory.StkBasePrc, ' +
					'ItemSite.AvgCost, ' +
					'ItemSite.QtyAvail, ' +
					'InvProjAlloc.QtyAlloc, ' +
					'ItemSite.QtyOnPO, ' +
					'ItemSite.SiteID, ' +
					'AttribDef.*, ' +
					'ItemAttribs.Attrib00, ' +
					'ItemAttribs.Attrib01, ' +
					'ItemAttribs.Attrib02, ' +
					'ItemAttribs.Attrib03, ' +
					'ItemAttribs.Attrib04, ' +
					'ItemAttribs.Attrib05, ' +
					'ItemAttribs.Attrib06, ' +
					'ItemAttribs.Attrib07, ' +
					'ItemAttribs.Attrib08, ' +
					'ItemAttribs.Attrib09 ' +
					'FROM Inventory ' +
					'  LEFT JOIN ItemSite ON ItemSite.InvtID = Inventory.InvtID ' +
					'  JOIN (SELECT InvProjAlloc.InvtID, InvProjAlloc.SiteID,  
					Sum(InvProjAlloc.QtyRemainToIssue)QtyAlloc FROM InvProjAlloc ' + @AllocWhere + ' GROUP BY InvProjAlloc.InvtID, InvProjAlloc.SiteID) InvProjAlloc
					ON InvProjAlloc.InvtID = Inventory.InvtID AND InvProjAlloc.SiteID = ItemSite.SiteID ' +
					'  LEFT JOIN AttribDef ON AttribDef.ClassID = Inventory.ClassID ' +
					'  LEFT JOIN ItemAttribs ON ItemAttribs.InvtID = Inventory.InvtID ' +
					@WhereClause +
					'ORDER BY Inventory.InvtID, ItemSite.SiteID')
			END
		END

		-- If one or more description segments were passed...
		IF @DescrSeg1 <> ''
		BEGIN
			IF @ProjectID = ''
			BEGIN
				EXECUTE ('SELECT distinct ' +
					'Inventory.ClassId, ' +
					'Inventory.Descr, ' +
					'#ItemLookupTemp.InvtID, ' +
					'Inventory.StkBasePrc, ' +
					'ItemSite.AvgCost, ' +
					'ItemSite.QtyAvail, ' +
					'ItemSite.QtyAllocProjIN, ' +
					'ItemSite.QtyOnPO, ' +
					'ItemSite.SiteID, ' +
					'AttribDef.*, ' +
					'ItemAttribs.Attrib00, ' +
					'ItemAttribs.Attrib01, ' +
					'ItemAttribs.Attrib02, ' +
					'ItemAttribs.Attrib03, ' +
					'ItemAttribs.Attrib04, ' +
					'ItemAttribs.Attrib05, ' +
					'ItemAttribs.Attrib06, ' +
					'ItemAttribs.Attrib07, ' +
					'ItemAttribs.Attrib08, ' +
					'ItemAttribs.Attrib09 ' +
					'FROM #ItemLookupTemp ' +
					'  JOIN Inventory ON Inventory.InvtID = #ItemLookupTemp.InvtID ' +
					'  LEFT JOIN ItemSite ON ItemSite.InvtID = #ItemLookupTemp.InvtID ' +
					'  LEFT JOIN AttribDef ON AttribDef.ClassID = Inventory.ClassID ' +
					'  LEFT JOIN ItemAttribs ON ItemAttribs.InvtID = #ItemLookupTemp.InvtID ' +
					@WhereClause +
					'ORDER BY #ItemLookupTemp.InvtID, ItemSite.SiteID')
			END
			ELSE
			BEGIN
				EXECUTE ('SELECT distinct ' +
					'Inventory.ClassId, ' +
					'Inventory.Descr, ' +
					'#ItemLookupTemp.InvtID, ' +
					'Inventory.StkBasePrc, ' +
					'ItemSite.AvgCost, ' +
					'ItemSite.QtyAvail, ' +
					'InvProjAlloc.QtyAlloc, ' +
					'ItemSite.QtyOnPO, ' +
					'ItemSite.SiteID, ' +
					'AttribDef.*, ' +
					'ItemAttribs.Attrib00, ' +
					'ItemAttribs.Attrib01, ' +
					'ItemAttribs.Attrib02, ' +
					'ItemAttribs.Attrib03, ' +
					'ItemAttribs.Attrib04, ' +
					'ItemAttribs.Attrib05, ' +
					'ItemAttribs.Attrib06, ' +
					'ItemAttribs.Attrib07, ' +
					'ItemAttribs.Attrib08, ' +
					'ItemAttribs.Attrib09 ' +
					'FROM #ItemLookupTemp ' +
					'  JOIN Inventory ON Inventory.InvtID = #ItemLookupTemp.InvtID ' +
					'  LEFT JOIN ItemSite ON ItemSite.InvtID = #ItemLookupTemp.InvtID ' +
					'  JOIN (SELECT InvProjAlloc.InvtID, InvProjAlloc.SiteID, 
					Sum(InvProjAlloc.QtyRemainToIssue)QtyAlloc FROM InvProjAlloc ' + @AllocWhere + ' GROUP BY InvProjAlloc.InvtID, InvProjAlloc.SiteID) InvProjAlloc
					ON InvProjAlloc.InvtID = Inventory.InvtID AND InvProjAlloc.SiteID = ItemSite.SiteID ' +
					'  LEFT JOIN AttribDef ON AttribDef.ClassID = Inventory.ClassID ' +
					'  LEFT JOIN ItemAttribs ON ItemAttribs.InvtID = #ItemLookupTemp.InvtID ' +
					@WhereClause +
					'ORDER BY #ItemLookupTemp.InvtID, ItemSite.SiteID')
			END
		END
	END

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ItemLookup2] TO [MSDSL]
    AS [dbo];

