
CREATE VIEW [dbo].[PJvPJACCT_IndirectGrps]
AS
-- This is part of a group of SQL tables, views, and functions used by the PJAIC SQL stored procedure to
-- generate actual indirect cost amounts.

-- This one exists solely to consistently split the value stored in the ca_id01 field into the ytd and ptd group ids.

select a.acct,
	ptd_indirectgrp = substring(a.ca_id01, 7, 6),
	ytd_indirectgrp = substring(a.ca_id01, 1, 6)
from PJACCT a with (nolock)

