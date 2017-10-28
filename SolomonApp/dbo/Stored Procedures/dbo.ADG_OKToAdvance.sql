 create proc ADG_OKToAdvance
	@cpnyid			varchar (10),
	@sotypeid		varchar (4),
	@nextfunction		varchar (8),
	@nextclass		varchar (4),
	@desiredfunction	varchar (8),
	@desiredclass		varchar (4) output
as
	declare	@nextseq	varchar (4),
		@nextdescr	varchar (30),
		@custstatus	varchar (1),
		@desiredseq	varchar (4),
		@reqdcount	smallint

	-- Determine the Seq for the previously-planned NextFunction and NextClass.
	select	@nextseq = seq,
		@nextdescr = descr
	from 	sostep
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @nextfunction
	  and	functionclass = @nextclass

	--in case @desiredclass is blank for reports
	if @desiredclass = ''
	select	top 1 @desiredseq = seq,
		@desiredclass = functionclass
	from 	sostep
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @desiredfunction
	  --and	functionclass like '%'
	  and   seq >= @nextseq
	  and   status <> 'D'
	order by cpnyid, sotypeid, seq

	if @desiredclass = ''
	select	top 1 @desiredseq = seq,
		@desiredclass = functionclass
	from 	sostep
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @desiredfunction
	  --and	functionclass like '%'
	  and   seq < @nextseq
	  and   status <> 'D'
	order by cpnyid, sotypeid, seq

	-- Determine the Seq for the desired function and class.
	if @desiredseq is null
	select	@desiredseq = seq
	from 	sostep
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @desiredfunction
	  and	functionclass = @desiredclass

	-- If the desired step is invalid for this order type, return an
	-- appropriate message.
	if @desiredseq is null begin
	    select 'status' = 'I',
		   'descr'  = convert(varchar(30), '')

	    return
	end

	-- Ensure that the DesiredSeq is greater than or equal to the previously-
	-- planned NextSeq.
	if @desiredseq < @nextseq

	    -- The DesiredSeq is less than the NextSeq, which means that the user is
	    -- trying to move backwards in the order cycle. Return an error status
	    -- and the description for the previously-planned next step.
	    select  'status' = 'S',
		    'descr' = @nextdescr

		--in case of success return record with functionclass in descr
		union all
		select  'status' = '1',
			'descr'  = convert(varchar(30), @desiredclass)
		from    sostep
		where   cpnyid = @cpnyid
		  and   sotypeid = @sotypeid
		  and   seq = @desiredseq

	else begin

	    -- The DesiredSeq is greater than the NextSeq.

	    -- First, determine how many required steps are being skipped (if any).
	    select  @reqdcount = count(*)
	    from    sostep
	    where   cpnyid = @cpnyid
	      and   sotypeid = @sotypeid
	      and   seq >= @nextseq
	      and   seq < @desiredseq
	      and   status = 'R'

	    if @reqdcount > 0

		-- At least one requried step was found. Return them.
		select  status,
			descr
		from    sostep
		where   cpnyid = @cpnyid
		  and   sotypeid = @sotypeid
		  and   seq >= @nextseq
		  and   seq < @desiredseq
		  and   status = 'R'
		order by
			seq

	    else begin

		-- Return 'C' if the next step is a credit check
		-- step. Otherwise, return an empty recordset.
		select  'status' = 'C',
			'descr'  = convert(varchar(30), @desiredclass)
		from    sostep
		where   cpnyid = @cpnyid
		  and   sotypeid = @sotypeid
		  and   seq = @desiredseq
		  and   creditchk = 1

		--in case of success return record with functionclass in descr
		union all
		select  'status' = '1',
			'descr'  = convert(varchar(30), @desiredclass)
		from    sostep
		where   cpnyid = @cpnyid
		  and   sotypeid = @sotypeid
		  and   seq = @desiredseq

	    end

	end

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_OKToAdvance] TO [MSDSL]
    AS [dbo];

