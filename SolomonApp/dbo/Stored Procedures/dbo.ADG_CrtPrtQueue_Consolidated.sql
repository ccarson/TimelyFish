 create proc ADG_CrtPrtQueue_Consolidated
	@ri_id		smallint,
	@function	varchar(8),
	@class		varchar(4),
	@cpnyid		varchar(10),
	@shipperid	varchar(15),
	@status		varchar(1),
	@printername	varchar(255),
	@desiredreport	varchar(30),
	@noteson	smallint,
	@DropShip	smallint,
	@PerPost	varchar(6),
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

	-- Do an initial query that will get all its data from the index
	-- so we can avoid index deadlocks
	IF PATINDEX('%[%]%', @cpnyid) = 0 AND PATINDEX('%[%]%', @ShipperID) = 0
	BEGIN
		insert into SOPrintQueue_Temp (CpnyID, DeviceName, NotesOn,
			OrdNbr, ReportName, Reprint, RI_ID, Seq, ShipperID,
			SiteID, SOTypeID, InvcNbr)
		select	SOShipHeader.CpnyID,
			@DeviceName,
			0,
			SOShipHeader.OrdNbr,
			Substring(SOShipHeader.NextFunctionID, 1, 5),
			0,
			Convert(varchar(10), @ri_id),
			'',
			SOShipHeader.ShipperID,
			'',
			'',
			''
		from	SOShipHeader
		Where	CpnyID = @CpnyID
		and	ShipperID = @ShipperID and ConsolInv = 1
		and	Status + '' like @Status
		and	NextFunctionID + '' like @Function
		and	NextFunctionClass + '' like @Class
	END
	ELSE
	BEGIN
		insert into SOPrintQueue_Temp (CpnyID, DeviceName, NotesOn,
			OrdNbr, ReportName, Reprint, RI_ID, Seq, ShipperID,
			SiteID, SOTypeID, InvcNbr)
		select	SOShipHeader.CpnyID,
			@DeviceName,
			0,
			SOShipHeader.OrdNbr,
			Substring(SOShipHeader.NextFunctionID, 1, 5),
			0,
			Convert(varchar(10), @ri_id),
			'',
			SOShipHeader.ShipperID,
			'',
			'',
			''
		from	SOShipHeader
		Where	CpnyID like @CpnyID
		and	ShipperID like @ShipperID and ConsolInv = 1
		and	Status like @Status
		and	NextFunctionID like @Function
		and	NextFunctionClass like @Class
	END
		-- Update the remaining data in all eligible records (not accounting for the
	-- output characteristics) into a temporary table. This should use the
	-- clustered index on SOShipHeader so index deadlocks should be avoided
	select @SelectStr1 =
	'update SOPrintQueue
		Set	NotesOn = IsNull(s.noteson, 0),
			Reprint = Case WHEN e.eventid is null then 0 ELSE 1 END,
			Seq = IsNull(s.seq, ''''),
			SiteID = SOShipHeader.siteid,
			SOTypeID = SOShipHeader.sotypeid,
			InvcNbr = SOShipHeader.InvcNbr '

	select @FromStr1 =
	'from vp_SOPrintQueue_FromTemp SOPrintQueue
	left join SOShipHeader on SOShipHeader.CpnyID = SOPrintQueue.CpnyID and SOShipHeader.ShipperID = SOPrintQueue.ShipperID
	left join SOPrintQueue q on SOShipHeader.cpnyid = q.cpnyid and SOShipHeader.shipperid = q.shipperid '
		--If the Function value is a wild card '%', this indicates that the form is being printed off
		--of the Shipper screen or from AutoAdvance.  We have to add the ReporNbr to the join to the
		--SOPrintQueue table in case the Shipper has to automatically auto advance through two reports.
		--This will seperate which report it is printing so it doesn't print a blank page.
		If @function = '%'
			select @FromStr1 = @FromStr1 +
			'and Substring(SOShipHeader.NextFunctionID, 1, 5) = q.S4Future11 '

	-- If the Function value is a wild card '%', this indicates that the form is being printed off of the Shipper screen or from AutoAdvance.
	-- If this is the case, then do a left join on the SOStep table to include closed invoices where NextFunctionID = ''.
	If @function = '%'
		select @FromStr1 = @FromStr1 +
		  'left join
			sostep s on SOShipHeader.cpnyid = s.cpnyid and SOShipHeader.sotypeid = s.sotypeid and s.functionid = ''' + RTrim(@desiredreport) + ''' and s.functionclass = (select top 1 p.functionclass from sostep p where p.cpnyid = s.cpnyid and p.sotypeid = s.sotypeid and p.functionid = s.functionid order by p.cpnyid, p.sotypeid, p.seq) '
	else
		select @FromStr1 = @FromStr1 +
		  'join
			sostep s on SOShipHeader.cpnyid = s.cpnyid and SOShipHeader.sotypeid = s.sotypeid and SOShipHeader.nextfunctionid = s.functionid and SOShipHeader.nextfunctionclass = s.functionclass '

	select @FromStr1 = @FromStr1 +
	  'left join
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
		if @shipperid = '%'
		select @WhereStr1 =
			'where ((s.creditchk = 0 or SOShipHeader.creditchk = 0 or SOShipHeader.credithold = 0) and SOShipHeader.AdminHold = 0)
	 		and q.shipperid is null and SOShipHeader.DropShip <> ''' + Convert(varchar(2), @DropShip) + ''''
	else

	     	If @function <> '%'
		select @WhereStr1 =
	  		'where q.shipperid is null and SOShipHeader.DropShip <> ''' + Convert(varchar(2), @DropShip) + ''''

	exec (@SelectStr1 + @FromStr1 + @WhereStr1 + @WhereStr)

	--select @SelectStr1
	--select @FromStr1
	--select @WhereStr1
	--select @WhereStr

	-- Now copy the correct subset of records into the SOPrintQueue
	-- table.
	if @printername = '%'

		-- Since we don't care about which printer the shippers
		-- would normally print on, just copy into the
		-- print queue table.  Modes 1, 3, and 4.
		-- Additionally test on the SOTypeID. If it is blank we know the
		-- record was excluded in the update statement above so we can
		-- exclude the whole record here
		insert into soprintqueue (cpnyid, InvcNbr, ordnbr, reprint, ri_id, s4future01, s4future02, s4future03, s4future04, s4future05, s4future06, s4future07, s4future08, s4future09, s4future10, s4future11, s4future12, shipperid,
						ARAcct, ARSub, PerPost, SOTypeID)
		select	SOPrintQueue_Temp.cpnyid,
			COALESCE(NULLIF(SOPrintQueue_Temp.InvcNbr,''),NULLIF(SOHeader.InvcNbr,''),''),
			SOPrintQueue_Temp.ordnbr,
			SOPrintQueue_Temp.reprint,
			SOPrintQueue_Temp.ri_id,
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
			's4future11' = SOPrintQueue_Temp.ReportName,
			's4future12' = '',
			SOPrintQueue_Temp.shipperid,
			SOShipHeader.ARAcct,
			SOShipHeader.ARSub,
			COALESCE(NULLIF(@PerPost,''),NULLIF(SOShipHeader.PerPost,''),NULLIF(SOHeader.PerPost,''),''),
			COALESCE(NULLIF(SOType.InvcNbrType,''),SOPrintQueue_Temp.SOTypeID)
		from	SOPrintQueue_Temp
		inner join
			SOShipHeader (NOLOCK)
		on	SOShipHeader.CpnyID = SOPrintQueue_Temp.CpnyID
		and	SOShipHeader.ShipperID = SOPrintQueue_Temp.ShipperID
		left join
			SOHeader (NOLOCK)
		on	SOHeader.CpnyID = SOPrintQueue_Temp.CpnyID
		and	SOHeader.OrdNbr = SOPrintQueue_Temp.OrdNbr
		left join
			SOType (NOLOCK)
		on	SOPrintQueue_Temp.CpnyID = SOType.CpnyID
		and	SOPrintQueue_Temp.SOTypeID = SOType.SOTypeID
		where	SOPrintQueue_Temp.ri_id = @ri_id
		and	SOPrintQueue_Temp.SOTypeID <> ''

	else begin

		-- If an @printername other than the SQL wildcard has
		-- been provided, it is because we only want to select
		-- records for the designated printer. The first step,
		-- then, is to determine which printer each shipper should
		-- print to.  This is used only for Mode 2 Automatic Batch
		-- that is printed from 40.602.00 Shipper Form Batch Manager.

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
		  and	SOPrintQueue_Temp.ri_id = @ri_id

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
		  and	SOPrintQueue_Temp.ri_id = @ri_id

		-- As a safety precaution, anything that still doesn't
		-- have a printer name needs set to DEFAULT.
		update 	SOPrintQueue_Temp
		set 	devicename = 'DEFAULT',
			reportname = ''
		where 	(devicename = ''
		  or 	devicename is null)
		  and	ri_id = @ri_id

		-- Any records that have a reportname of '' need to be set.
		update 	SOPrintQueue_Temp
		set 	reportname = substring(@function, 1, 5)
		where 	reportname = ''
		  and	ri_id = @ri_id

		-- Finally, copy only the records for the specified printer
		-- into the print queue table.
		-- Additionally test on the SOTypeID. If it is blank we know the
		-- record was excluded in the update statement above so we can
		-- exclude the whole record here
		select	SOPrintQueue_Temp.cpnyid,
			COALESCE(NULLIF(SOPrintQueue_Temp.InvcNbr,''),NULLIF(SOHeader.InvcNbr,''),''),
			SOPrintQueue_Temp.ordnbr,
			SOPrintQueue_Temp.reprint,
			SOPrintQueue_Temp.ri_id,
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
			's4future11' = SOPrintQueue_Temp.ReportName,
			's4future12' = '',
			SOPrintQueue_Temp.shipperid,
			SOShipHeader.ARAcct,
			SOShipHeader.ARSub,
			COALESCE(NULLIF(@PerPost,''),NULLIF(SOShipHeader.PerPost,''),NULLIF(SOHeader.PerPost,''),''),
			COALESCE(NULLIF(SOType.InvcNbrType,''),SOPrintQueue_Temp.SOTypeID)
		from	SOPrintQueue_Temp
		inner join
			SOShipHeader (NOLOCK)
		on	SOShipHeader.CpnyID = SOPrintQueue_Temp.CpnyID
		and	SOShipHeader.ShipperID = SOPrintQueue_Temp.ShipperID
		left join
			SOHeader (NOLOCK)
		on	SOHeader.CpnyID = SOPrintQueue_Temp.CpnyID
		and	SOHeader.OrdNbr = SOPrintQueue_Temp.OrdNbr
		left join
			SOType (NOLOCK)
		on	SOPrintQueue_Temp.CpnyID = SOType.CpnyID
		and	SOPrintQueue_Temp.SOTypeID = SOType.SOTypeID
		where	SOPrintQueue_Temp.devicename = @printername
		  and	SOPrintQueue_Temp.reportname = @desiredreport
		  and	SOPrintQueue_Temp.noteson    = @noteson
		  and	SOPrintQueue_Temp.ri_id = @ri_id
		  and	SOPrintQueue_Temp.SOTypeID <> ''

	end

	--Delete all the records from the SOPrintQueue_Temp table.
	delete from SOPrintQueue_Temp where ri_id = @ri_id

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_CrtPrtQueue_Consolidated] TO [MSDSL]
    AS [dbo];

