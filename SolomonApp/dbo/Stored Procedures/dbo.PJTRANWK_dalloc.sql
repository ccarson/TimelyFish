 create procedure PJTRANWK_dalloc @parm1 varchar (10) as
delete from PJTRANWK
    where alloc_batch = @parm1


