﻿ /****** Object:  Stored Procedure dbo.APDoc_RefNbr_DocType1    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_RefNbr_DocType1 @parm1 varchar ( 10) As
Select * from APDoc Where RefNbr = @parm1 and (DocType = 'VO' or
        DocType = 'AD' or DocType = 'AC' or DocType = 'PP') and Rlsed = 1
        and Selected = 1
Order By RefNbr, DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_RefNbr_DocType1] TO [MSDSL]
    AS [dbo];

