 /****** Object:  Stored Procedure dbo.RefNbr_All    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc RefNbr_All @parm1 varchar ( 10) as
            Select * from RefNbr where RefNbr like @parm1
                    order by RefNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RefNbr_All] TO [MSDSL]
    AS [dbo];

