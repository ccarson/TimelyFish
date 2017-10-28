 create procedure PJEQRATE_SPROJ  @parm1 varchar (16)  as
select *
from   PJEQRATE
where    project     =   @parm1


