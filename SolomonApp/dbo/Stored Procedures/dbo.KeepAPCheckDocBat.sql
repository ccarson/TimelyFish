 /****** Object:  Stored Procedure dbo.KeepAPCheckDocBat    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure KeepAPCheckDocBat @parm1 varchar ( 10) As
        Select * From APCheck Where
                BatNbr = @parm1 and
                Status = 'T'
         Order By BatNbr, CheckRefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[KeepAPCheckDocBat] TO [MSDSL]
    AS [dbo];

