 create proc ADG_CrtPrtQueue_Order
	@ri_id		smallint,
	@function	varchar(8),
	@class		varchar(4),
	@cpnyid		varchar(10),
	@ordnbr		varchar(15),
	@status		varchar(1),
	@printername	varchar(255),
	@desiredreport	varchar(30),
	@noteson	smallint,
	@WhereStr	varchar(1024)
as
	declare @devicename 	varchar(40)
	declare @SelectStr1	varchar(2000)
	declare @FromStr1	varchar(2000)
	declare @WhereStr1	varchar(2000)

	-- Initialize variables.
	select @devicename = 'DEFAULT'

	-- Clear the print queue of any pre-existing records.
	delete from soprintqueue where ri_id = @ri_id
	delete from SOPrintQueue_Temp where ri_id = @ri_id

	-- Select all eligible records (not accounting for the printer)
	-- into a temporary table.
	Select @SelectStr1 =
	'insert into SOPrintQueue_Temp (CpnyID, DeviceName, NotesOn,
		OrdNbr, ReportName, Reprint, RI_ID, Seq, ShipperID,
		SiteID, SOTypeID, InvcNbr)
	select distinct
		SOHeader.cpnyid,
		''' + @devicename + ''',
		IsNull(s.noteson, 0),
		SOHeader.ordnbr,
		Substring(SOHeader.NextFunctionID, 1, 5),
		Case WHEN e.eventid is null then 0 ELSE 1 END,
		' + Convert(varchar(10), @ri_id) + ',
		IsNull(s.seq, ''''),
		'''',
		SOHeader.sellingsiteid,
		SOHeader.sotypeid,
		'''' '

	select @FromStr1 =
	'from	SOHeader (READPAST)
	  left join
		soprintqueue q on SOHeader.cpnyid = q.cpnyid and SOHeader.ordnbr = q.ordnbr '

		--If the Function value is a wild card '%', this indicates that the form is being printed off
		--of the Order screen or from AutoAdvance.  We have to add the ReporNbr to the join to the
		--SOPrintQueue table in case the Order has to automatically auto advance through two reports.
		--This will seperate which report it is printing so it doesn't print a blank page.
		If @function = '%'
			select @FromStr1 = @FromStr1 +
			'and Substring(SOHeader.NextFunctionID, 1, 5) = q.S4Future11 '

	-- If the Function value is a wild card '%', this indicates that the form is being printed off of the Order screen.
	-- If this is the case, then to a left join on the SOStep table to include closed invoices where NextFunctionID = ''.
	If @function = '%'
		select @FromStr1 = @FromStr1 +
		  'left join
			sostep s on SOHeader.cpnyid = s.cpnyid and SOHeader.sotypeid = s.sotypeid and s.functionid = ''' + RTrim(@desiredreport) + ''' and s.functionclass = (select top 1 p.functionclass from sostep p where p.cpnyid = s.cpnyid and p.sotypeid = s.sotypeid and p.functionid = s.functionid order by p.cpnyid, p.sotypeid, p.seq) '
	else
		select @FromStr1 = @FromStr1 +
		  'join
			sostep s on SOHeader.cpnyid = s.cpnyid and SOHeader.sotypeid = s.sotypeid and SOHeader.nextfunctionid = s.functionid and SOHeader.nextfunctionclass = s.functionclass '

	select @FromStr1 = @FromStr1 +
	  'left join
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
			SOLine (nolock) ON SOHeader.CpnyID = SOLine.CpnyID AND SOHeader.OrdNbr = SOLine.OrdNbr
	  	left join
			ShipVia ON SOHeader.CpnyID=ShipVia.CpnyID AND SOHeader.ShipViaID=ShipVia.ShipViaID
	  	left join
			CertificationText ON SOHeader.CertID = CertificationText.CertID
	  	left join
			Salesperson ON SOHeader.SlsperID = Salesperson.SlsperId
	  	left join
			Site ON SOLine.SiteID = Site.SiteId '
	end

	select @WhereStr1 = 'where SOHeader.cpnyid like ''' + @cpnyid + ''''
		-- If there is an order number
	if @OrdNbr <> '' and @OrdNbr <> '%'
	begin
		-- If it doesn't have a wildcard in it
		if charindex('%', @OrdNbr) = 0
		begin
			select @WhereStr1 = @WhereStr1 + ' and SOHeader.ordnbr = ''' + @OrdNbr + ''''
		end
		else
		begin
			select @WhereStr1 = @WhereStr1 + ' and SOHeader.ordnbr like ''' + @OrdNbr + ''''
		end
	end

	-- If there is a next function id
	if @function <> '' and @function <> '%'
	begin
		-- If it doesn't have a wildcard in it
		if charindex('%', @function) = 0
		begin
			select @WhereStr1 = @WhereStr1 + ' and nextfunctionid = ''' + @function + ''''
		end
		else
		begin
			select @WhereStr1 = @WhereStr1 + ' and nextfunctionid like ''' + @function + ''''
		end
	end

	-- If there is a next class id
	if @class <> '' and @class <> '%'
	begin
		-- If it doesn't have a wildcard in it
		if charindex('%', @class) = 0
		begin
			select @WhereStr1 = @WhereStr1 + ' and nextfunctionclass = ''' + @class + ''''
		end
		else
		begin
			select @WhereStr1 = @WhereStr1 + ' and nextfunctionclass like ''' + @class + ''''
		end
	end

	-- If there is a status
	if @status <> '' and @status <> '%'
	begin
		-- If it doesn't have a wildcard in it
		if charindex('%', @status) = 0
		begin
			select @WhereStr1 = @WhereStr1 + ' and SOHeader.Status = ''' + @status + ''''
		end
		else
		begin
			select @WhereStr1 = @WhereStr1 + ' and SOHeader.Status like ''' + @status + ''''
		end
	end

	if @ordnbr = '%'
		select @WhereStr1 = @WhereStr1 +
		  'and	((s.creditchk = 0 or SOHeader.creditchk = 0 or SOHeader.credithold = 0) And SOHeader.AdminHold = 0) '
	else
		select @WhereStr1 = @WhereStr1 + ' '

	If @function <> '%'
		select @WhereStr1 = @WhereStr1 +
	  		'and	q.ordnbr is null '

	exec (@SelectStr1 + @FromStr1 + @WhereStr1 + @WhereStr)

	-- Now copy the correct subset of records into the SOPrintQueue
	-- table.
	if @printername = '%'

		-- Since we don't care about which printer the shippers
		-- would normally print on, just copy into the
		-- print queue table.
		insert into soprintqueue (cpnyid, InvcNbr, ordnbr, reprint, ri_id, s4future01, s4future02, s4future03, s4future04, s4future05, s4future06, s4future07, s4future08, s4future09, s4future10, s4future11, s4future12, shipperid)
		select	cpnyid,
			'InvcNbr' = '',
			ordnbr,
			reprint,
			ri_id,
			's4future01' = '',
			's4future02' = '',
			's4future03' = 0,
			's4future04' = 0,
			's4future05' = 0,
			's4future06' = 0,
			's4future07' = '',
			's4future08' = '',
			's4future09' = 0,
			's4future10' = 0,
			's4future11' = ReportName,
			's4future12' = '',
			'shipperid'  = ''
		from	SOPrintQueue_Temp (nolock)
		where	ri_id = @ri_id

	else begin

		-- If an @printername other than the SQL wildcard has
		-- been provided, it is because we only want to select
		-- records for the designated printer. The first step,
		-- then, is to determine which printer each shipper should
		-- print to...

		-- First, update all the records that have a corresponding
		-- 'DEFAULT' site record in the SOPrintControl table.
		update 	SOPrintQueue_Temp
		set 	SOPrintQueue_Temp.devicename = c.devicename,
			SOPrintQueue_Temp.reportname = c.reportname
		from 	SOPrintQueue_Temp, soprintcontrol c
		where 	SOPrintQueue_Temp.cpnyid = c.cpnyid
		  and 	SOPrintQueue_Temp.sotypeid = c.sotypeid
		  and 	SOPrintQueue_Temp.seq = c.seq
		  and 	c.siteid = 'DEFAULT'
		  and 	SOPrintQueue_Temp.ri_id = @ri_id

		-- Next, update all the records in the temp table where
		-- there is an explicit match on the site ID.
		update 	SOPrintQueue_Temp
		set 	SOPrintQueue_Temp.devicename = c.devicename,
			SOPrintQueue_Temp.reportname = c.reportname
		from 	SOPrintQueue_Temp, soprintcontrol c
		where 	SOPrintQueue_Temp.cpnyid = c.cpnyid
		  and 	SOPrintQueue_Temp.sotypeid = c.sotypeid
		  and 	SOPrintQueue_Temp.seq = c.seq
		  and 	SOPrintQueue_Temp.siteid = c.siteid
		  and 	SOPrintQueue_Temp.ri_id = @ri_id

		-- As a safety precaution, anything that still doesn't
		-- have a printer name needs set to DEFAULT.
		update 	SOPrintQueue_Temp
		set 	devicename = 'DEFAULT',
			reportname = ''
		where 	devicename = ''
		  or 	devicename is null
		  and 	ri_id = @ri_id

		-- Any records that have a reportname of '' need to be set.
		update 	SOPrintQueue_Temp
		set 	reportname = substring(@function, 1, 5)
		where 	reportname = ''
		  and 	ri_id = @ri_id

		-- Finally, copy only the records for the specified printer
		-- into the print queue table.
		insert into soprintqueue (cpnyid, InvcNbr, ordnbr, reprint, ri_id, s4future01, s4future02, s4future03, s4future04, s4future05, s4future06, s4future07, s4future08, s4future09, s4future10, s4future11, s4future12, shipperid)
		select	cpnyid,
			'InvcNbr' = '',
			ordnbr,
			reprint,
			ri_id,
			's4future01' = '',
			's4future02' = '',
			's4future03' = 0,
			's4future04' = 0,
			's4future05' = 0,
			's4future06' = 0,
			's4future07' = '',
			's4future08' = '',
			's4future09' = 0,
			's4future10' = 0,
			's4future11' = ReportName,
			's4future12' = '',
			'shipperid'  = ''
		from	SOPrintQueue_Temp (nolock)
		where	devicename = @printername
		  and	reportname = @desiredreport
		  and	noteson    = @noteson
		  and	ri_id = @ri_id

	end

	--Delete all the records from the SOPrintQueue_Temp table.
	delete from SOPrintQueue_Temp where ri_id = @ri_id

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_CrtPrtQueue_Order] TO [MSDSL]
    AS [dbo];

