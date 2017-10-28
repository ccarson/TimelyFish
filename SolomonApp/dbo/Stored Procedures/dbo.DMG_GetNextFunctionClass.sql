 create proc DMG_GetNextFunctionClass
	@CpnyID			varchar(10),
	@SOTypeID		varchar(4),
	@CurrFunctionID		varchar(8),
	@CurrFunctionClass	varchar(4),
	@NextFunctionID		varchar(8) OUTPUT,
	@NextFunctionClass	varchar(4) OUTPUT
as
	declare	@currseq	varchar (4)

	-- Determine the Seq for the current function and class.
	select	@currseq = seq
	from 	sostep (NOLOCK)
	where	cpnyid = @CpnyID
	  and	sotypeid = @SOTypeID
	  and	functionid = @CurrFunctionID
	  and	functionclass = @CurrFunctionClass

	if @currseq IS NULL
	  select @currseq = ''

	-- Get the next non-disabled order step and return the function ID and class.
	select	top 1
		@NextFunctionID = ltrim(rtrim(FunctionID)),
		@NextFunctionClass = ltrim(rtrim(FunctionClass))
	from    sostep (NOLOCK)
	where   cpnyid = @cpnyid
	  and   sotypeid = @sotypeid
	  and   seq > @currseq
	  and   status <> 'D'
	order by
		seq

	if @@ROWCOUNT = 0 begin
		set @NextFunctionID = ''
		set @NextFunctionClass = ''
		return 0	--Failure
	end
	else
		--select @NextFunctionID, @NextFunctionClass
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetNextFunctionClass] TO [MSDSL]
    AS [dbo];

