 create proc DMG_SOStep_EventType
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4),
	@FunctionID	varchar(8),
	@FunctionClass	varchar(4),
	@EventType	varchar(4) OUTPUT
as
	select  @EventType = ltrim(rtrim(EventType))
	from    SOStep (NOLOCK)
	where   CpnyID = @CpnyID
	  and   SOTypeID = @SOTypeID
	  and   FunctionID = @FunctionID
          and	FunctionClass = @FunctionClass
	  and   EventType <> 'X'

	if @@ROWCOUNT = 0 begin
		set @EventType = ''
		return 0	--Failure
	end
	else
		return 1	--Success


