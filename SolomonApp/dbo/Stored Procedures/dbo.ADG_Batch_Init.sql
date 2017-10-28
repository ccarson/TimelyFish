 create proc ADG_Batch_Init
as
	select		*
	from		Batch
	where		Module = 'Z'
	  and		BatNbr = 'Z'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


