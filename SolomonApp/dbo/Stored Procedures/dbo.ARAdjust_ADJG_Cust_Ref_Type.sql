 /****** Object:  Stored Procedure dbo.ARAdjust_ADJG_Cust_Ref_Type    Script Date: 4/7/98 12:30:32 PM ******/
Create proc ARAdjust_ADJG_Cust_Ref_Type @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 2) As
Select * from Aradjust where
        aradjust.custid = @parm1 and
        aradjust.adjgrefnbr = @parm2 and
        aradjust.adjgdoctype = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARAdjust_ADJG_Cust_Ref_Type] TO [MSDSL]
    AS [dbo];

