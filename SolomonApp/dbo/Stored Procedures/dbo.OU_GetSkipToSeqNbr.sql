 create proc OU_GetSkipToSeqNbr
	@CpnyID			varchar (10),
	@SOTypeID		varchar (4),
	@CurrFunction		varchar (8),
	@CurrClass		varchar (4)
as
	set nocount on

	declare	@SkipToSeq	varchar (4)

	-- Determine the Seq for the current function and class.
	select	@SkipToSeq = SkipTo
	from 	SOStep
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID
	and	FunctionID = @CurrFunction
	and	FunctionClass = @CurrClass

	if @SkipToSeq is null
		select @SkipToSeq = ''

	select @SkipToSeq as 'SkipToSeq'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[OU_GetSkipToSeqNbr] TO [MSDSL]
    AS [dbo];

