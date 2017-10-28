 -- Drop Proc IRGet_SkipT_oSeqNbr
CREATE procedure IRGet_SkipTo_SeqNbr
	@cpnyid			varchar (10),
	@sotypeid		varchar (4),
	@currfunction		varchar (8),
	@currclass		varchar (4)
as
	declare	@SkipToSeq	varchar (4)
Set NoCount On
	-- Determine the Seq for the current function and class.
	select	@SkipToSeq = SkipTo
	from 	sostep
	where	cpnyid = @cpnyid
	  and	sotypeid = @sotypeid
	  and	functionid = @currfunction
	  and	functionclass = @currclass

	if @SkipToSeq IS NULL
	  select @SkipToSeq = ''
Set Nocount Off
Select @SkipToSeq As 'SkipToSeq'


