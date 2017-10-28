 create proc ADG_ReportInfoBySite
	@cpnyid			varchar(10),
	@sotypeid		varchar(4),
	@currfunction		varchar(8),
	@currclass		varchar(4),
	@siteid			varchar(10)
as
	declare @currseq	varchar(4),
		@sitekey	varchar(10)

	-- Determine the Seq for the current function and class.
	select	@currseq = seq
	from 	sostep
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @currfunction
	  and	functionclass = @currclass

	-- Set the default value for @sitekey to 'DEFAULT'.  If the next select fails
	-- to find any records, @sitekey will retain this value.
	select	@sitekey = 'DEFAULT'

	-- Try to find a record in SOPrintControl for the specified site.
	select 	@sitekey = siteid
	from	soprintcontrol
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	seq = @currseq
	  and	siteid = @siteid

	-- Now that we know the correct site ID, select the DeviceName from the
	-- correct SOPrintControl record.
	select	c.devicename,
		c.reportformat,
		c.reportname,
		s.noteson
	from	sostep s
	  left join soprintcontrol c on s.cpnyid = c.cpnyid and s.sotypeid = c.sotypeid and s.seq = c.seq
		and	(c.siteid = @sitekey or c.siteid is null)
	where	s.cpnyid = @cpnyid
	  and	s.sotypeid = @sotypeid
	  and	s.seq = @currseq


-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


