 create procedure BATCH_uSTATUS @parm1 varchar (10) , @parm2 varchar (2), @parm3 varchar (1)  as
update BATCH set status = @parm3
where batnbr = @parm1
and module = @parm2


