 /****** Object:  Stored Procedure dbo.SelectAPTempCheck    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure SelectAPTempCheck @parm1 varchar ( 10), @parm2 varchar ( 10) As
        Select * From APDoc Where
                BatNbr = @parm1 and
                RefNbr = @parm2 and
		    DocType = "VC"



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SelectAPTempCheck] TO [MSDSL]
    AS [dbo];

