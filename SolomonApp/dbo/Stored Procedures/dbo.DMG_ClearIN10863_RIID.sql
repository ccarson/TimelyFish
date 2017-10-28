 create proc DMG_ClearIN10863_RIID
	@ri_id		smallint
as
		delete from IN10863_WRK where ri_id = @ri_id
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


