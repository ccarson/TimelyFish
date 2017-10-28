 create procedure GLTRAN_uRELEASE @parm1 varchar (10) , @parm2 varchar (2)  as
update GLTRAN set rlsed=1
where batnbr = @parm1
and module = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTRAN_uRELEASE] TO [MSDSL]
    AS [dbo];

