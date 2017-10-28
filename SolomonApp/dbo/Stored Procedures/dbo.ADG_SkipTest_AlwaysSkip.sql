 create proc ADG_SkipTest_AlwaysSkip
	@cpnyid		varchar(10),
	@ordnbr		varchar(15),
	@shipperid	varchar(15)
as
	select	'Status' = 'SKIP',
		'Descr' = substring('Auto-skip' + space(30),1,30)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


