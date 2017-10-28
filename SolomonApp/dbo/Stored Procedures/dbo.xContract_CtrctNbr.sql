Create Procedure xContract_CtrctNbr @parm1 varchar (10) as 
    Select * from xContract Where CtrctNbr Like @parm1 Order by CtrctNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xContract_CtrctNbr] TO [MSDSL]
    AS [dbo];

