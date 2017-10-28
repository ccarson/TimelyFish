 create procedure ADG_ProcessMgr_FetchSO
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	select		H.CustID,
			H.LUpd_Prog,
			T.Behavior,
			H.AdminHold

	from		SOHeader H
	join		SOType T (nolock)
	on		T.SOTypeID = H.SOTypeID

	where		H.CpnyID = @CpnyID
	and		H.OrdNbr = @OrdNbr


