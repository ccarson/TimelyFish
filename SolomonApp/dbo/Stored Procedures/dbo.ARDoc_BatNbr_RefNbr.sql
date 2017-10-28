 /****** Object:  Stored Procedure dbo.ARDoc_BatNbr_RefNbr    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_BatNbr_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 10) as
    Select * from ARDoc where BatNbr = @parm1
        and ARDoc.RefNbr like @parm2
        order by RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_BatNbr_RefNbr] TO [MSDSL]
    AS [dbo];

