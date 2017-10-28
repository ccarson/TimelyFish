 /****** Object:  Stored Procedure dbo.ARDoc_Cpny_RefNbr    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_Cpny_RefNbr @parm1 varchar ( 10),@parm2 varchar ( 10) as
    Select * from ARDoc where CpnyId Like @parm1 And RefNbr like @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Cpny_RefNbr] TO [MSDSL]
    AS [dbo];

