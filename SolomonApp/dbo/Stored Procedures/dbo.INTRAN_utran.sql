 create procedure  INTRAN_utran @parm1 varchar (1) , @parm2 varchar (10) , @parm3 smallint   as
update INTRAN
set pc_status = @parm1
where INTRAN.batnbr =  @parm2 and
INTRAN.linenbr =  @parm3


