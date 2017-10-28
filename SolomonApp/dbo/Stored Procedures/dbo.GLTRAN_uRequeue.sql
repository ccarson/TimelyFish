 create procedure  GLTRAN_uRequeue  @parm1 varchar (6)  as
update GLTRAN
set pc_status = '1'
where
GLTRAN.perpost =  @parm1  and
GLTRAN.pc_status =  '9'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTRAN_uRequeue] TO [MSDSL]
    AS [dbo];

