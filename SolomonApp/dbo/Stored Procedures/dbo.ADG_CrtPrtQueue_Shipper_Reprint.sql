 create proc ADG_CrtPrtQueue_Shipper_Reprint
	@ri_id		smallint,
	@function	varchar(8),
	@class		varchar(4),
	@cpnyid		varchar(10),
	@status		varchar(1),
	@consolidated	smallint,
	@WhereStr	varchar(1024)
as
	declare @SelectStr1	varchar(2000)
	declare @FromStr1	varchar(2000)
	declare @WhereStr1	varchar(2000)
	declare @EventType	varchar(4)

	-- Clear the print queue of any pre-existing records.
	delete from soprintqueue where ri_id = @ri_id

	-- Get the EventType value for the current report
	select 	@EventType = EventType
	from	SOStep
	where	CpnyID Like @cpnyid
	  and	FunctionID = @function
	  and 	FunctionClass like @class

	-- Select all eligible records (not accounting for the
	-- output characteristics) into a temporary table.
	select @SelectStr1 =
	'insert into soprintqueue (cpnyid, InvcNbr, ordnbr, reprint, ri_id, s4future01, s4future02, s4future03, s4future04, s4future05, s4future06, s4future07, s4future08, s4future09, s4future10, s4future11, s4future12, shipperid)
	select distinct
		SOShipHeader.CpnyID,
		SOShipHeader.InvcNbr,
		SOShipHeader.OrdNbr,
		Reprint = 1,
		RI_ID = ' + Convert(varchar(10), @ri_id) + ',
		s4future01 = '''',
		s4future02 = '''',
		s4future03 = 0,
		s4future04 = 0,
		s4future05 = 0,
		s4future06 = 0,
		s4future07 = '''',
		s4future08 = '''',
		s4future09 = 0,
		s4future10 = 0,
		s4future11 = '''',
		s4future12 = '''',
		SOShipHeader.ShipperID '

	select @FromStr1 =
	'from	(select Reprint = 1, RptNbr = ''' + left(@Function, 5) + ''', RI_ID = ' + Convert(varchar(10), @ri_id) + ',* from SOShipHeader) SOPrintQueue
	  join
		SOShipHeader on SOShipHeader.CpnyID = SOPrintQueue.CpnyID and SOShipHeader.ShipperID = SOPrintQueue.ShipperID
	  join
		sostep s on SOShipHeader.cpnyid = s.cpnyid and SOShipHeader.sotypeid = s.sotypeid
	  join
		soevent e on SOShipHeader.cpnyid = e.cpnyid and SOShipHeader.shipperid = e.shipperid and s.eventtype = e.eventtype
	  left join
		Customer ON SOShipHeader.CustID = Customer.CustId '

	-- The following joins are used to accomodate any Selection Criteria from any table
	-- passed in from the ROI.
	if @WhereStr <> '' and @WhereStr is not NULL
	begin
		if patindex('%CertificationText%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
	  	'left join
			CertificationText ON SOShipHeader.CertID = CertificationText.CertID '
		if patindex('%FOBPoint%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
	  	'left join
			FOBPoint ON SOShipHeader.FOBID = FOBPoint.FOBID '
		if patindex('%Inventory%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
	  	'left join
			Inventory ON SOShipHeader.BuildInvtID = Inventory.InvtId '
		if patindex('%Salesperson%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
	  	'left join
			Salesperson ON SOShipHeader.SlsperID = Salesperson.SlsperId '
		if patindex('%SOShipLine%', @WhereStr) > 0 or
		   patindex('%SOShipLot%', @WhereStr) > 0 or
		   patindex('%Inventory2%', @WhereStr) > 0 or
		   patindex('%Snote1%', @WhereStr) > 0 or
		   patindex('%Snote2%', @WhereStr) > 0 or
		   patindex('%Inspection%', @WhereStr) > 0 or
		   patindex('%SOLine%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
	  	'left join
			SOShipLine (nolock) ON SOShipHeader.CpnyID = SOShipLine.CpnyID AND SOShipHeader.ShipperID = SOShipLine.ShipperID '
		if patindex('%ShipVia%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
	  	'left join
			ShipVia ON SOShipHeader.CpnyID = ShipVia.CpnyID AND SOShipHeader.ShipViaID = ShipVia.ShipViaID '
		if patindex('%SOShipLot%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
	  	'left join
			SOShipLot (nolock) ON SOShipLine.CpnyID = SOShipLot.CpnyID AND SOShipLine.LineRef = SOShipLot.LineRef AND SOShipLine.ShipperID = SOShipLot.ShipperID '
		if patindex('%Terms%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
	  	'left join
			Terms ON SOShipHeader.TermsID = Terms.TermsId '
		if patindex('%SOHeaderMark%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
     		'left join
			SOHeaderMark (nolock) ON SOShipHeader.CpnyID = SOHeaderMark.CpnyID AND SOShipHeader.OrdNbr = SOHeaderMark.OrdNbr '
		if patindex('%SOShipMark%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			SOShipMark (nolock) ON SOShipHeader.CpnyID = SOShipMark.CpnyID AND SOShipHeader.ShipperID = SOShipMark.ShipperID '
		if patindex('%Country%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			Country (nolock) ON SOShipHeader.BillCountry = Country.CountryID '
		if patindex('%ShipCountry%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			Country ShipCountry (nolock) ON SOShipHeader.ShipCountry = ShipCountry.CountryID '
		if patindex('%SOType%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			SOType (nolock) ON SOShipHeader.CpnyID = SOType.CpnyID AND SOShipHeader.SOTypeID = SOType.SOTypeID '
		if patindex('%Site%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			Site (nolock) ON SOShipHeader.SiteID = Site.SiteId '
		if patindex('%Inventory2%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			Inventory Inventory2 (nolock) ON SOShipLine.InvtID = Inventory2.InvtId '
		if patindex('%Snote%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			Snote (nolock) ON SOShipHeader.NoteID = Snote.nID '
		if patindex('%Snote1%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			Snote Snote1 (nolock) ON SOShipLine.NoteID = Snote1.nID '
		if patindex('%Snote2%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			Snote Snote2 (nolock) ON SOShipLine.NoteID = Snote2.nID '
		if patindex('%Inspection%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			Inspection (nolock) ON SOShipLine.InvtID = Inspection.InvtID '
		if patindex('%SOLine%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			SOLine (nolock) ON SOShipLine.CpnyID = SOLine.CpnyID AND SOShipLine.OrdLineRef = SOLine.LineRef AND SOShipLine.OrdNbr = SOLine.OrdNbr '
		if patindex('%FrtTerms%', @WhereStr) > 0
		select @FromStr1 = @FromStr1 +
		'left join
			FrtTerms (nolock) ON SOShipHeader.FrtTermsID = FrtTerms.FrtTermsID '
	end

	select @WhereStr1 = 'where SOShipHeader.cpnyid Like ''' + @cpnyid + '''
		and RTrim(SOShipHeader.NextFunctionID) + SOShipHeader.NextFunctionClass not like ''' + RTrim(@function) + @Class + '''
		and SOShipHeader.Status like ''' + @status + '''' + case @function when '4068000' then '
		and SOShipHeader.ConsolInv = ' + Str(@consolidated) else '' end + '
		and e.EventType = ''' + @EventType + ''' '

	exec (@SelectStr1 + @FromStr1 + @WhereStr1 + @WhereStr)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_CrtPrtQueue_Shipper_Reprint] TO [MSDSL]
    AS [dbo];

