 create proc ADG_SkipTest_AlwaysAdvance
	@cpnyid		varchar(10),
	@ordnbr		varchar(15),
	@shipperid	varchar(15)
as
	select	'Status' = 'NEXT',
		'Descr' = substring('Auto-advance' + space(30),1,30)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


