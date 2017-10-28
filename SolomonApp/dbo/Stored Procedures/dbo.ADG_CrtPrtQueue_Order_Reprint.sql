 create proc ADG_CrtPrtQueue_Order_Reprint
	@ri_id		smallint,
	@function	varchar(8),
	@class		varchar(4),
	@cpnyid		varchar(10),
	@status		varchar(1),
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

	-- Select all eligible records (not accounting for the printer)
	-- into a temporary table.
	Select @SelectStr1 =
	'insert into soprintqueue (cpnyid, InvcNbr, ordnbr, reprint, ri_id, s4future01, s4future02, s4future03, s4future04, s4future05, s4future06, s4future07, s4future08, s4future09, s4future10, s4future11, s4future12, shipperid)
	select distinct
		SOHeader.cpnyid,
		InvcNbr = '''',
		SOHeader.ordnbr,
		1,
		' + Convert(varchar(10), @ri_id) + ',
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
		ShipperID = '''' '

	select @FromStr1 =
	'from	SOHeader
	  join
		sostep s on SOHeader.cpnyid = s.cpnyid and SOHeader.sotypeid = s.sotypeid
	  join
		soevent e on SOHeader.cpnyid = e.cpnyid and SOHeader.ordnbr = e.ordnbr and s.eventtype = e.eventtype
	  left join
		Customer ON SOHeader.CustID = Customer.CustID '

	  -- The following joins are used to accomodate any Selection Criteria from any table
	  -- passed in from the ROI.
	if @WhereStr <> '' and @WhereStr is not NULL
	begin
		select @FromStr1 = @FromStr1 +
	  	'left join
			FOBPoint ON SOHeader.FOBID = FOBPoint.FOBID
	  	left join
			Terms ON SOHeader.TermsID = Terms.TermsId
	  	left join
			SOType ON SOHeader.SOTypeID = SOType.SOTypeID
	  	left join
			SOLine ON SOHeader.CpnyID = SOLine.CpnyID AND SOHeader.OrdNbr = SOLine.OrdNbr
	  	left join
			ShipVia ON SOHeader.CpnyID = ShipVia.CpnyID AND SOHeader.ShipViaID = ShipVia.ShipViaID
	  	left join
			CertificationText ON SOHeader.CertID = CertificationText.CertID
	  	left join
			Salesperson ON SOHeader.SlsperID = Salesperson.SlsperId
	  	left join
			Site ON SOLine.SiteID = Site.SiteId '
	end

	select @WhereStr1 = 'where SOHeader.cpnyid Like ''' + @cpnyid + '''
		and RTrim(nextfunctionid) + nextfunctionclass not like ''' + RTrim(@function) + @Class + '''
		and SOHeader.Status like ''' + @status + '''
		and e.EventType = ''' + @EventType + ''' '

	exec (@SelectStr1 + @FromStr1 + @WhereStr1 + @WhereStr)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_CrtPrtQueue_Order_Reprint] TO [MSDSL]
    AS [dbo];

