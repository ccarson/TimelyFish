 /****** Object:  Stored Procedure dbo.ARDoc_BatNbr_RefNbr3    Script Date: 7/27/00 12:30:32 PM ******/
Create Procedure ARDoc_BatNbr_RefNbr3 @parm1 varchar ( 10), @parm2 varchar ( 10) as
    Select * from ARDoc where BatNbr = @parm1
        and ARDoc.RefNbr like @parm2
        order by Doctype,RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_BatNbr_RefNbr3] TO [MSDSL]
    AS [dbo];

