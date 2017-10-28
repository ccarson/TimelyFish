 create procedure PJTRANWK_sall @parm1 varchar (10), @parm2 varchar (16) as
select * from PJTRANWK
    where alloc_batch = @parm1
    and project = @parm2


