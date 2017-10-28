 /****** Object:  Stored Procedure dbo.ARDoc_RefNbr    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_RefNbr @parm1 varchar ( 10) as
    Select * from ARDoc where RefNbr like @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_RefNbr] TO [MSDSL]
    AS [dbo];

