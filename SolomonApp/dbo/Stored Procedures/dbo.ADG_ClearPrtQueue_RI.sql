 create proc ADG_ClearPrtQueue_RI
	@ri_id		smallint
as
	delete from soprintqueue where ri_id = @ri_id

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


