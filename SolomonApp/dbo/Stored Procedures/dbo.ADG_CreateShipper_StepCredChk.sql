 create proc ADG_CreateShipper_StepCredChk
 	@CpnyID		varchar(10),
	@SOTypeID	varchar(4),
	@FunctionID	varchar(8),
	@FunctionClass	varchar(4)
as
	select	CreditChk
	from	SOStep WITH (NOLOCK)
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID
	  and	FunctionID = @FunctionID
	  and	FunctionClass = @FunctionClass


