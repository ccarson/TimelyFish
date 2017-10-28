 /****** Object:  Stored Procedure dbo.ARDoc_ApplBat_Cust_Type_Ref    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_ApplBat_Cust_Type_Ref @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar ( 2), @parm4 varchar ( 10) as
    Select * from ARDoc where ApplBatNbr = @parm1
        and CustId = @parm2
        and DocType = @parm3
        and RefNbr like @parm4
        order by ApplBatNbr, CustId, DocType, RefNbr


