 /****** Object:  Stored Procedure dbo.Delete_Artran_All    Script Date: 4/7/98 12:30:33 PM ******/
Create proc Delete_Artran_All @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 2) As
Delete artran from artran where
        Artran.CustId = @parm1 and
        Artran.RefNbr = @parm2 and
        Artran.Trantype = @parm3


