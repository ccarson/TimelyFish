﻿

CREATE PROCEDURE XDD_PR_Installed
AS
	select 		case when count(*) > 0
  			then 1
  			else 0
  			end
 	from 		PRSetup (nolock)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDD_PR_Installed] TO [MSDSL]
    AS [dbo];

