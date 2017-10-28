 create proc ADG_SOMisc_Total
	@cpnyid	varchar(10),
	@ordnbr	varchar(15)
as
	select		'OpenCury' = coalesce(sum(CuryMiscChrg - CuryMiscChrgAppl), 0),
			'OpenReg' = coalesce(sum(MiscChrg - MiscChrgAppl), 0)
	from		SOMisc
	where		CpnyID = @cpnyid
	  and		OrdNbr = @ordnbr
	group by	CpnyID, OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


