 /****** Object:  Stored Procedure dbo.POReceipt_04020    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure POReceipt_04020 @parm1 varchar ( 10) As
        Select * from POReceipt where
                RcptNbr like @parm1 and
                Batnbr = ''
        Order by RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_04020] TO [MSDSL]
    AS [dbo];

