 create proc ADG_SOType_RMAShipment
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select		*
	from		SOType
	where		CpnyID Like @CpnyID
	  and		SOTypeID Like @SOTypeID
	  and		Behavior Like 'RMSH'
	order by 	CpnyID,
			SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOType_RMAShipment] TO [MSDSL]
    AS [dbo];

