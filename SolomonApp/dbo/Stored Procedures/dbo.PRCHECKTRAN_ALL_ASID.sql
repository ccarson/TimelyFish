﻿
CREATE PROCEDURE PRCHECKTRAN_ALL_ASID 
AS

        SELECT * FROM PRCheckTran WHERE ASID = 0
		ORDER BY EMPID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRCHECKTRAN_ALL_ASID] TO [MSDSL]
    AS [dbo];
