 create proc ADG_ProcessMgr_SOBehavior
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	select		t.Behavior
	from		SOHeader h

	join		SOType t
	on		t.CpnyID = @CpnyID
	and		t.SOTypeID = h.SOTypeID

	where		h.CpnyID = @CpnyID
	and		h.OrdNbr = @OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_SOBehavior] TO [MSDSL]
    AS [dbo];

