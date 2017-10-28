 create proc ADG_ARDoc_CopyNotes
as
	select	convert(smallint, coalesce(CopyNotes, 0))
	from	SOSetup

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


