 /****** Object:  Stored Procedure dbo.RlsedARDoc_Cust_Type_Ref    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure RlsedARDoc_Cust_Type_Ref @parm1 varchar ( 15), @parm2 varchar ( 2), @parm3 varchar ( 10) as
    Select * from ARDoc where CustId = @parm1
        and DocType = @parm2
        and RefNbr = @parm3
        and Rlsed = 1
        order by CustId, DocType, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RlsedARDoc_Cust_Type_Ref] TO [MSDSL]
    AS [dbo];

