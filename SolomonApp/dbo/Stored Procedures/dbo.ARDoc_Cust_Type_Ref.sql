﻿ /****** Object:  Stored Procedure dbo.ARDoc_Cust_Type_Ref    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_Cust_Type_Ref @parm1 varchar ( 15), @parm2 varchar ( 2), @parm3 varchar ( 10) as
    Select * from ARDoc where CustId like @parm1
        and DocType like @parm2
        and RefNbr like @parm3
        and Rlsed = 1
        order by CustId, DocType, RefNbr


