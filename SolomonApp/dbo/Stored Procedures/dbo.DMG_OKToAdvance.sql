 create proc DMG_OKToAdvance
	@cpnyid			varchar (10),
	@sotypeid		varchar (4),
	@nextfunction		varchar (8),
	@nextclass		varchar (4),
	@desiredfunction	varchar (8),
	@desiredclass		varchar (4),
	@Descr			varchar(30) OUTPUT,
	@Status			varchar(1) OUTPUT
as
	declare	@nextseq	varchar (4),
		@nextdescr	varchar (30),
		@custstatus	varchar (1),
		@desiredseq	varchar (4),
		@reqdcount	smallint

	-- Determine the Seq for the previously-planned NextFunction and NextClass.
	select	@nextseq = ltrim(rtrim(seq)),
		@nextdescr = ltrim(rtrim(descr))
	from 	sostep (NOLOCK)
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @nextfunction
	  and	functionclass = @nextclass

	-- Determine the Seq for the desired function and class.
	select	@desiredseq = ltrim(rtrim(seq))
	from 	sostep (NOLOCK)
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @desiredfunction
	  and	functionclass = @desiredclass

	-- If the desired step is invalid for this order type, return an
	-- appropriate message.
	if @desiredseq is null begin
	    select @Status = 'I',
		   @Descr  = ''

	    return 1
	end

	-- Ensure that the DesiredSeq is greater than or equal to the previously-
	-- planned NextSeq.
	if @desiredseq < @nextseq
	begin
	    -- The DesiredSeq is less than the NextSeq, which means that the user is
	    -- trying to move backwards in the order cycle. Return an error status
	    -- and the description for the previously-planned next step.
	    select  @Status = 'S',
		    @Descr = @nextdescr

	    return 1
	end
	else begin

	    -- The DesiredSeq is greater than the NextSeq.

	    -- First, determine how many required steps are being skipped (if any).
	    select  @reqdcount = count(*)
	    from    sostep (NOLOCK)
	    where   cpnyid = @cpnyid
	      and   sotypeid = @sotypeid
	      and   seq >= @nextseq
	      and   seq < @desiredseq
	      and   status = 'R'

	    if @reqdcount > 0
	    begin
		-- At least one requried step was found. Return them.
		select  top 1
			@Status = ltrim(rtrim(status)),
			@Descr = ltrim(rtrim(descr))
		from    sostep (NOLOCK)
		where   cpnyid = @cpnyid
		  and   sotypeid = @sotypeid
		  and   seq >= @nextseq
		  and   seq < @desiredseq
		  and   status = 'R'
		order by
			seq

		if @@ROWCOUNT = 0 begin
			set @Status = ''
			set @Descr = ''
			return 0	--Failure
		end
		else
			--select @Descr, @Status
			return 1	--Success
	    end
	    else begin

		-- Return 'C' if the next step is a credit check
		-- step. Otherwise, return an empty recordset.
		select  @Status = 'C',
			@Descr  = ''
		from    sostep (NOLOCK)
		where   cpnyid = @cpnyid
		  and   sotypeid = @sotypeid
		  and   seq = @desiredseq
		  and   creditchk = 1

		if @@ROWCOUNT = 0 begin
			set @Status = ''
			set @Descr = ''
			return 0	--Failure
		end
		else
			return 1	--Success
	    end
	end


