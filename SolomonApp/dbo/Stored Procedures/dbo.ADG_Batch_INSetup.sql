 create proc ADG_Batch_INSetup
as
	select		CurrPerNbr,
			GLPostOpt
	from		INSetup WITH (NOLOCK)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


