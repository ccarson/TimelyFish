 create proc ADG_OrdTot_SOMisc
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	select	'OpenCury' = (CuryMiscChrg - CuryMiscChrgAppl),
		'OpenReg' = (MiscChrg - MiscChrgAppl),
		Taxable,
		TaxCat

	from	SOMisc
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_OrdTot_SOMisc] TO [MSDSL]
    AS [dbo];

