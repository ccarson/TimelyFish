 create proc ADG_ShipTot_SOMisc
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	select		'OpenCury' = (CuryMiscChrg - CuryMiscChrgAppl),
			'OpenReg' = (MiscChrg - MiscChrgAppl),
			Taxable,
			TaxCat

	from		SOMisc
	where		CpnyID = @CpnyID
	  and		OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


