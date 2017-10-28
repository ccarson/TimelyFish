 /****** Object:  Stored Procedure dbo.ARAdjust_AdJd_Cust_Ref_Type    Script Date: 4/7/98 12:30:32 PM ******/
Create proc ARAdjust_AdJd_Cust_Ref_Type @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 2) As
Select * from Aradjust where
        Aradjust.custid = @parm1 and
        Aradjust.ADJDRefNbr = @parm2 and
        Aradjust.ADJDDoctype = @parm3


