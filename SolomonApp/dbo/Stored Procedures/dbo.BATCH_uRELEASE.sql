 create procedure BATCH_uRELEASE @parm1 varchar (10) , @parm2 varchar (2)  as
update BATCH set rlsed=1
where batnbr = @parm1
and module = @parm2


