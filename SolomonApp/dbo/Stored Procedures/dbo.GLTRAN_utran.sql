 create procedure GLTRAN_utran @parm1 varchar (1) , @parm2 varchar (2) , @parm3 varchar (10) , @parm4 smallint   as
update GLTRAN
set pc_status = @parm1
where GLTRAN.module =  @parm2 and
GLTRAN.batnbr = @parm3 and
GLTRAN.linenbr =  @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTRAN_utran] TO [MSDSL]
    AS [dbo];

