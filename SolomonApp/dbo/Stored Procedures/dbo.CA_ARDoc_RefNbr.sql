 create Proc CA_ARDoc_RefNbr @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 varchar ( 10) as
Select * from ardoc
Where cpnyid = @parm1
and bankacct = @parm2
and banksub = @parm3
and refnbr = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA_ARDoc_RefNbr] TO [MSDSL]
    AS [dbo];

