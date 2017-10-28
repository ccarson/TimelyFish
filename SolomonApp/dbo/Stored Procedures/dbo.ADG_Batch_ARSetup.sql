 create proc ADG_Batch_ARSetup
as
	select		CurrPerNbr,
			GLPostOpt
	from		ARSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


