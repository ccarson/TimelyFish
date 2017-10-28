 create procedure ARTRAN_uTrantype @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (2) as
update ARTRAN set TranType = @parm3
where batnbr = @parm1 and
      refnbr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTRAN_uTrantype] TO [MSDSL]
    AS [dbo];

