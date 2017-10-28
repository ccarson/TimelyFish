 create proc ADG_PrintBatchCount_Order
	@cpnyid		varchar(10),
	@function	varchar(8),
	@class		varchar(4)
as
	declare @devicename 	varchar(40)
	declare @reportname 	varchar(30)
	declare @ri_id	    	smallint
	Declare @RiidValid  smallint

	-- Initialize variables.
	select @devicename = 'DEFAULT', @reportname = ''

	-- Genereate a random smallint number to be used as the ri_id.
	-- Make sure that the ri_id is not being used already.
	select @RiidValid = 0
	While @RiidValid <> 1
	Begin
		select @ri_id = (Select convert(int, Rand() * 10000))

		If (select count(*) from SOPrintQueue_Temp where ri_id = @ri_id) > 0
			Select @RiidValid  = 0
		Else
			Select @RiidValid  = 1
	End

	-- Select all eligible records (not accounting for the printer)
	-- into a temporary table.
	insert into SOPrintQueue_Temp (CpnyID, DeviceName, NotesOn, OrdNbr, ReportName,
		Reprint, RI_ID, Seq, ShipperID, SiteID, SOTypeID, InvcNbr)
	select	distinct
		h.cpnyid,
		'DeviceName'	= @devicename,
		s.noteson,
		h.ordnbr,
		'ReportName'	= @reportname,
		'Reprint'	= 0,
		'RI_ID' 	= @ri_id,
		s.seq,
		'ShipperID'	= '',
		'SiteID'	= h.sellingsiteid,
		h.sotypeid,
		'InvcNbr'	= ''
	from	SOHeader h (READPAST)
	  left join
		soprintqueue q on h.cpnyid = q.cpnyid and h.ordnbr = q.ordnbr
	  join
		sostep s on h.cpnyid = s.cpnyid and h.sotypeid = s.sotypeid and h.nextfunctionid = s.functionid and h.nextfunctionclass = s.functionclass
	  left join
		Customer ON h.CustID = Customer.CustId
	where	nextfunctionid like @function
	  and	nextfunctionclass like @class
	  and	h.status = 'O'
	  and	h.cpnyid like @cpnyid
	  and	((s.creditchk = 0 or h.creditchk = 0 or h.credithold = 0) and h.AdminHold = 0)
          and	q.ordnbr is null

	-- Determine which printer each order should print to --

	-- First, update all the records that have a corresponding
	-- 'DEFAULT' site record in the SOPrintControl table.
	update 	soprintqueue_temp
	set 	soprintqueue_temp.devicename = c.devicename,
		soprintqueue_temp.reportname = c.reportname
	from 	soprintqueue_temp, soprintcontrol c
	where 	soprintqueue_temp.cpnyid = c.cpnyid
	  and 	soprintqueue_temp.sotypeid = c.sotypeid
	  and 	soprintqueue_temp.seq = c.seq
	  and 	c.siteid = 'DEFAULT'
	  and 	soprintqueue_temp.RI_ID = @ri_id

	-- Next, update all the records in the temp table where
	-- there is an explicit match on the site ID.
	update 	soprintqueue_temp
	set 	soprintqueue_temp.devicename = c.devicename,
		soprintqueue_temp.reportname = c.reportname
	from 	soprintqueue_temp, soprintcontrol c
	where 	soprintqueue_temp.cpnyid = c.cpnyid
	  and 	soprintqueue_temp.sotypeid = c.sotypeid
	  and 	soprintqueue_temp.seq = c.seq
	  and 	soprintqueue_temp.siteid = c.siteid
	  and 	soprintqueue_temp.RI_ID = @ri_id

	-- As a safety precaution, anything that still doesn't
	-- have a printer name needs set to DEFAULT.
	update 	soprintqueue_temp
	set 	devicename = 'DEFAULT', reportname = ''
	where 	(devicename = ''
	  or 	devicename is null)
	  and 	RI_ID = @ri_id

	-- Any records that have a reportname of '' need to be set.
	update 	soprintqueue_temp
	set 	reportname = substring(@function, 1, 5)
	where 	reportname = ''
	  and 	RI_ID = @ri_id

	-- Finally, return the record counts for each printer.
	select	devicename,
		reportname,
		RI_ID,
		noteson,
		'PrinterCount' = convert(int, count(*))
	from 	soprintqueue_temp (nolock)
	where	RI_ID = @ri_id
	group by devicename, reportname, RI_ID, noteson

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


