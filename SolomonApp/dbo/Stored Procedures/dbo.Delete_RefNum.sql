 /****** Object:  Stored Procedure dbo.Delete_RefNum    Script Date: 4/7/98 12:30:33 PM ******/
Create proc Delete_RefNum @parm1 varchar ( 10) As
Delete refnbr from RefNbr where
        RefNbr.Refnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_RefNum] TO [MSDSL]
    AS [dbo];

