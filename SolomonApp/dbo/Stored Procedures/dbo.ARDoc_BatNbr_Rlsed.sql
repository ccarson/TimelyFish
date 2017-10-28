 /****** Object:  Stored Procedure dbo.ARDoc_BatNbr_Rlsed    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_BatNbr_Rlsed @parm1 varchar ( 10) as
    Select * from ARDoc where BatNbr = @parm1
        and Rlsed = 1
        order by RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_BatNbr_Rlsed] TO [MSDSL]
    AS [dbo];

