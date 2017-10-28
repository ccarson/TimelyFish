 create procedure  APTRAN_utran @parm1 varchar (1) , @parm2 varchar (10) , @parm3 varchar (10) , @parm4 varchar (24) , @parm5 varchar (10) , @parm6 int   as
update APTRAN
set pc_status = @parm1
where APTRAN.batnbr =  @parm2 and
APTRAN.acct = @parm3 and
APTRAN.sub = @parm4 and
APTRAN.refnbr = @parm5 and
APTRAN.recordid =  @parm6


