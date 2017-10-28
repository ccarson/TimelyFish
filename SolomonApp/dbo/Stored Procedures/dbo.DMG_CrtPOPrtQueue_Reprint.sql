 create proc DMG_CrtPOPrtQueue_Reprint
	@ri_id		smallint,
	@CpnyID		varchar(10),
	@ReqNbr		varchar(10),
	@ReqCntr	varchar(2),
	@PrintMode	varchar(1),
	@ReportType	varchar(2),
	@WhereStr	VARCHAR(1024)
as
	declare @SelectStr1	varchar(2000)
	declare @FromStr1	varchar(2000)
	declare @WhereStr1	varchar(2000)
	declare @BlankRestrict	varchar(5)

	-- Clear the print queue of any pre-existing records.
	delete from POPrintQueue where ri_id = @ri_id

	if exists(select * from rptruntime where ri_id = @ri_id and ShortAnswer04 = 'FALSE')
	select @BlankRestrict = '''BL'','
	else
	select @BlankRestrict = ''

	-- Select all eligible records (not accounting for the
	-- output characteristics) into a temporary table.
	select @SelectStr1 =
	'insert into POPrintQueue (CpnyID, PONbr, Reprint, ReqCntr, ReqNbr,
		RI_ID, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09,
		S4Future10,S4Future11, S4Future12)
	select 	distinct
		POReqHdr.cpnyid,
		POReqHdr.PONbr,
		POReqHdr.POPrinted,
		POReqHdr.ReqCntr,
		POReqHdr.ReqNbr,
		' + Convert(varchar(10), @ri_id) + ',
		S4Future01 = '''',
		S4Future02 = '''',
		S4Future03 = 0,
		S4Future04 = 0,
		S4Future05 = 0,
		S4Future06 = 0,
		S4Future07 = '''',
		S4Future08 = '''',
		S4Future09 = 0,
		S4Future10 = 0,
		S4Future11 = '''',
		S4Future12 = '''' '

	select @FromStr1 =
	'from	POReqHdr (READPAST)
	  left join
		POPrintQueue q on POReqHdr.ReqNbr = q.ReqNbr and POReqHdr.ReqCntr = q.ReqCntr '

	-- The following joins are used to accomodate any Selection Criteria from any table
	-- passed in from the ROI.
	if @WhereStr <> '' and @WhereStr is not NULL
	begin

		select @FromStr1 = @FromStr1 +
	     	  'LEFT JOIN Terms Terms ON
	        	POReqHdr.Terms = Terms.TermsId
		  LEFT JOIN PurchOrd Purchord ON
			POReqHdr.PONbr = purchord.ponbr
	     	  LEFT JOIN Country ShipCountry ON
	        	POReqHdr.ShipCountry = ShipCountry.CountryID
		  LEFT JOIN FOBPoint FOBPoint ON
	        	POReqHdr.FOB = FOBPoint.FOBID
	     	  LEFT JOIN Country Country ON
		        POReqHdr.Country = Country.CountryID
	     	  LEFT JOIN Country BillCountry ON
	        	POReqHdr.BillCountry = BillCountry.CountryID
		  LEFT JOIN ShipVia ShipVia ON
		        POReqHdr.ShipVia = ShipVia.ShipViaID
	     	  LEFT JOIN SIBuyer SIBuyer ON
		        POReqHdr.Buyer = SIBuyer.Buyer
		  LEFT JOIN POReqDet POReqDet ON
		        POReqHdr.ReqNbr = POReqDet.ReqNbr
	     	  LEFT JOIN Snote Snote ON
		        POReqHdr.NoteID = Snote.nID
	     	  LEFT JOIN Snote Snote1 ON
	        	POReqDet.NoteID = Snote1.nID '
	end
		select @WhereStr1 =
	'where	q.ReqCntr is null
	  and	q.ReqNbr is null '

	-- If there is a ReqCntr
	if @ReqCntr <> '' and @ReqCntr <> '%'
	begin
		-- If it doesn't have a wildcard in it
		if charindex('%', @ReqCntr) = 0
		begin
			select @WhereStr1 = @WhereStr1 + ' and POReqHdr.ReqCntr = ''' + @ReqCntr + ''''
		end
		else
		begin
			select @WhereStr1 = @WhereStr1 + ' and POReqHdr.ReqCntr like ''' + @ReqCntr + ''''
		end
	end

	-- If there is a ReqNbr
	if @ReqNbr <> '' and @ReqNbr <> '%'
	begin
		-- If it doesn't have a wildcard in it
		if charindex('%', @ReqNbr) = 0
		begin
			select @WhereStr1 = @WhereStr1 + ' and POReqHdr.ReqNbr = ''' + @ReqNbr + ''''
		end
		else
		begin
			select @WhereStr1 = @WhereStr1 + ' and POReqHdr.ReqNbr like ''' + @ReqNbr + ''''
		end
	end

	-- If there is a CpnyID
	if @CpnyID <> '' and @CpnyID <> '%'
	begin
		-- If it doesn't have a wildcard in it
		if charindex('%', @CpnyID) = 0
		begin
			select @WhereStr1 = @WhereStr1 + ' and POReqHdr.CpnyID = ''' + @CpnyID + ''''
		end
		else
		begin
			select @WhereStr1 = @WhereStr1 + ' and POReqHdr.CpnyID like ''' + @CpnyID + ''''
		end
	end
		If @PrintMode <> '3'
	Begin
		select @WhereStr1 = @WhereStr1 +
		' and 	POReqHdr.POType Not In (' + @BlankRestrict + ' ''ST'')
		  and 	POReqHdr.reqcntr =
			(select max(convert(int, P2.reqcntr))
			from poreqhdr P2
			where P2.reqnbr = POReqHdr.reqnbr
			  and P2.CpnyID = POReqHdr.CpnyID
			group by P2.reqnbr) '


		If @ReportType = 'CO'
			select @WhereStr1 = @WhereStr1 +
			' and	POReqHdr.COPrinted <> 1 '
	End
		exec (@SelectStr1 +  @FromStr1 + @WhereStr1 + @WhereStr)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CrtPOPrtQueue_Reprint] TO [MSDSL]
    AS [dbo];

