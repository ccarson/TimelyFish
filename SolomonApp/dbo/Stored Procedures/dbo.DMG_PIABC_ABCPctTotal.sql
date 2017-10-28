 CREATE PROCEDURE DMG_PIABC_ABCPctTotal

AS

	select 	sum(ClassPct)
	from 	piabc
	where 	ABCCode in ('A', 'B', 'C')

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


