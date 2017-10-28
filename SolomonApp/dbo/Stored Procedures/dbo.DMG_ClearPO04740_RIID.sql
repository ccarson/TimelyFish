 create proc DMG_ClearPO04740_RIID
	@ri_id		smallint
as
		delete from PO04740_WRK where ri_id = @ri_id
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


