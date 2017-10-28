 create proc ADG_ClearPrtQueueTemp_RI
	@ri_id		smallint
as
	delete from soprintqueue_temp where ri_id = @ri_id

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


