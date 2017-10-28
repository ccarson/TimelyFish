 create procedure ARTRAN_uRELEASE @parm1 varchar (10) as
update ARTRAN set rlsed=1
where batnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTRAN_uRELEASE] TO [MSDSL]
    AS [dbo];

