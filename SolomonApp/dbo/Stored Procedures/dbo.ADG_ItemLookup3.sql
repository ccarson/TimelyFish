 CREATE PROCEDURE ADG_ItemLookup3
	@ClassID varchar(6),
	@SiteID varchar(10),
	@TranMthd varchar(1),
	@AttribNumFrom0 float, @AttribNumTo0 float, @AttribStr0 varchar(10),
	@AttribNumFrom1 float, @AttribNumTo1 float, @AttribStr1 varchar(10),
	@AttribNumFrom2 float, @AttribNumTo2 float, @AttribStr2 varchar(10),
	@AttribNumFrom3 float, @AttribNumTo3 float, @AttribStr3 varchar(10),
	@AttribNumFrom4 float, @AttribNumTo4 float, @AttribStr4 varchar(10),
	@AttribNumFrom5 float, @AttribNumTo5 float, @AttribStr5 varchar(10),
	@AttribNumFrom6 float, @AttribNumTo6 float, @AttribStr6 varchar(10),
	@AttribNumFrom7 float, @AttribNumTo7 float, @AttribStr7 varchar(10),
	@AttribNumFrom8 float, @AttribNumTo8 float, @AttribStr8 varchar(10),
	@AttribNumFrom9 float, @AttribNumTo9 float, @AttribStr9 varchar(10)
AS
	DECLARE @WhereClause varchar(255)
	DECLARE @WhereClause0 varchar(255)
	DECLARE @WhereClause1 varchar(255)
	DECLARE @WhereClause2 varchar(255)
	DECLARE @WhereClause3 varchar(255)
	DECLARE @WhereClause4 varchar(255)
	DECLARE @WhereClause5 varchar(255)
	DECLARE @WhereClause6 varchar(255)
	DECLARE @WhereClause7 varchar(255)
	DECLARE @WhereClause8 varchar(255)
	DECLARE @WhereClause9 varchar(255)

	-- Must have a ClassID...
	SELECT @WhereClause = 'WHERE Inventory.ClassID = ' + QUOTENAME(@ClassID, '''')

	IF @SiteID <> ''
	BEGIN
		SELECT @WhereClause = @WhereClause + ' AND ItemSite.SiteID = ' + QUOTENAME(@SiteID, '''')
	END

	-- If the query is for purchases
	if @TranMthd = 'P'
	begin
		select @WhereClause = @WhereClause + ' and Inventory.TranStatusCode in (''AC'',''NU'') '
	end

	-- If the query is for sales
	if @TranMthd = 'S'
	begin
		select @WhereClause = @WhereClause + ' and Inventory.TranStatusCode in (''AC'',''NP'') '
	end

	SELECT @WhereClause0 = ''

	IF @AttribNumFrom0 <> 0
	BEGIN
		SELECT @WhereClause0 = @WhereClause0 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib00)) >= ' + CONVERT(varchar(10), @AttribNumFrom0)
	END

	IF @AttribNumTo0 <> 0
	BEGIN
		SELECT @WhereClause0 = @WhereClause0 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib00)) <= ' + CONVERT(varchar(10), @AttribNumTo0)
	END

	IF @AttribStr0 <> ''
	BEGIN
		SELECT @WhereClause0 = @WhereClause0 + ' AND ItemAttribs.Attrib00 like ' + QUOTENAME(@AttribStr0, '''')
	END
		SELECT @WhereClause1 = ''

	IF @AttribNumFrom1 <> 0
	BEGIN
		SELECT @WhereClause1 = @WhereClause1 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib01)) >= ' + CONVERT(varchar(10), @AttribNumFrom1)
	END

	IF @AttribNumTo1 <> 0
	BEGIN
		SELECT @WhereClause1 = @WhereClause1 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib01)) <= ' + CONVERT(varchar(10), @AttribNumTo1)
	END

	IF @AttribStr1 <> ''
	BEGIN
		SELECT @WhereClause1 = @WhereClause1 + ' AND ItemAttribs.Attrib01 like ' + QUOTENAME(@AttribStr1, '''')
	END

	SELECT @WhereClause2 = ''

	IF @AttribNumFrom2 <> 0
	BEGIN
		SELECT @WhereClause2 = @WhereClause2 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib02)) >= ' + CONVERT(varchar(10), @AttribNumFrom2)
	END

	IF @AttribNumTo2 <> 0
	BEGIN
		SELECT @WhereClause2 = @WhereClause2 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib02)) <= ' + CONVERT(varchar(10), @AttribNumTo2)
	END

	IF @AttribStr2 <> ''
	BEGIN
		SELECT @WhereClause2 = @WhereClause2 + ' AND ItemAttribs.Attrib02 like ' + QUOTENAME(@AttribStr2, '''')
	END

	SELECT @WhereClause3 = ''

	IF @AttribNumFrom3 <> 0
	BEGIN
		SELECT @WhereClause3 = @WhereClause3 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib03)) >= ' + CONVERT(varchar(10), @AttribNumFrom3)
	END

	IF @AttribNumTo3 <> 0
	BEGIN
		SELECT @WhereClause3 = @WhereClause3 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib03)) <= ' + CONVERT(varchar(10), @AttribNumTo3)
	END

	IF @AttribStr3 <> ''
	BEGIN
		SELECT @WhereClause3 = @WhereClause3 + ' AND ItemAttribs.Attrib03 like ' + QUOTENAME(@AttribStr3, '''')
	END

	SELECT @WhereClause4 = ''

	IF @AttribNumFrom4 <> 0
	BEGIN
		SELECT @WhereClause4 = @WhereClause4 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib04)) >= ' + CONVERT(varchar(10), @AttribNumFrom4)
	END

	IF @AttribNumTo4 <> 0
	BEGIN
		SELECT @WhereClause4 = @WhereClause4 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib04)) <= ' + CONVERT(varchar(10), @AttribNumTo4)
	END

	IF @AttribStr4 <> ''
	BEGIN
		SELECT @WhereClause4 = @WhereClause4 + ' AND ItemAttribs.Attrib04 like ' + QUOTENAME(@AttribStr4, '''')
	END

	SELECT @WhereClause5 = ''

	IF @AttribNumFrom5 <> 0
	BEGIN
		SELECT @WhereClause5 = @WhereClause5 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib05)) >= ' + CONVERT(varchar(10), @AttribNumFrom5)
	END

	IF @AttribNumTo5 <> 0
	BEGIN
		SELECT @WhereClause5 = @WhereClause5 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib05)) <= ' + CONVERT(varchar(10), @AttribNumTo5)
	END

	IF @AttribStr5 <> ''
	BEGIN
		SELECT @WhereClause5 = @WhereClause5 + ' AND ItemAttribs.Attrib05 like ' + QUOTENAME(@AttribStr5, '''')
	END

	SELECT @WhereClause6 = ''

	IF @AttribNumFrom6 <> 0
	BEGIN
		SELECT @WhereClause6 = @WhereClause6 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib06)) >= ' + CONVERT(varchar(10), @AttribNumFrom6)
	END

	IF @AttribNumTo6 <> 0
	BEGIN
		SELECT @WhereClause6 = @WhereClause6 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib06)) <= ' + CONVERT(varchar(10), @AttribNumTo6)
	END

	IF @AttribStr6 <> ''
	BEGIN
		SELECT @WhereClause6 = @WhereClause6 + ' AND ItemAttribs.Attrib06 like ' + QUOTENAME(@AttribStr6, '''')
	END

	SELECT @WhereClause7 = ''

	IF @AttribNumFrom7 <> 0
	BEGIN
		SELECT @WhereClause7 = @WhereClause7 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib07)) >= ' + CONVERT(varchar(10), @AttribNumFrom7)
	END

	IF @AttribNumTo7 <> 0
	BEGIN
		SELECT @WhereClause7 = @WhereClause7 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib07)) <= ' + CONVERT(varchar(10), @AttribNumTo7)
	END

	IF @AttribStr7 <> ''
	BEGIN
		SELECT @WhereClause7 = @WhereClause7 + ' AND ItemAttribs.Attrib07 like ' + QUOTENAME(@AttribStr7, '''')
	END

	SELECT @WhereClause8 = ''

	IF @AttribNumFrom8 <> 0
	BEGIN
		SELECT @WhereClause8 = @WhereClause8 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib08)) >= ' + CONVERT(varchar(10), @AttribNumFrom8)
	END

	IF @AttribNumTo8 <> 0
	BEGIN
		SELECT @WhereClause8 = @WhereClause8 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib08)) <= ' + CONVERT(varchar(10), @AttribNumTo8)
	END

	IF @AttribStr8 <> ''
	BEGIN
		SELECT @WhereClause8 = @WhereClause8 + ' AND ItemAttribs.Attrib08 like ' + QUOTENAME(@AttribStr8, '''')
	END

	SELECT @WhereClause9 = ''

	IF @AttribNumFrom9 <> 0
	BEGIN
		SELECT @WhereClause9 = @WhereClause9 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib09)) >= ' + CONVERT(varchar(10), @AttribNumFrom9)
	END

	IF @AttribNumTo9 <> 0
	BEGIN
		SELECT @WhereClause9 = @WhereClause9 + ' AND CONVERT(float, LTrim(ItemAttribs.Attrib09)) <= ' + CONVERT(varchar(10), @AttribNumTo9)
	END

	IF @AttribStr9 <> ''

	BEGIN
		SELECT @WhereClause9 = @WhereClause9 + ' AND ItemAttribs.Attrib09 like ' + QUOTENAME(@AttribStr9, '''')
	END

	/* SELECT @WhereClause
	SELECT @WhereClause0 */

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
		'  LEFT LOOP JOIN ItemAttribs ON ItemAttribs.InvtID = Inventory.InvtID ' +
		@WhereClause +
		@WhereClause0 +
		@WhereClause1 +
		@WhereClause2 +
		@WhereClause3 +
		@WhereClause4 +
		@WhereClause5 +
		@WhereClause6 +
		@WhereClause7 +
		@WhereClause8 +
		@WhereClause9 +
		'ORDER BY Inventory.InvtID, ItemSite.SiteID')

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


