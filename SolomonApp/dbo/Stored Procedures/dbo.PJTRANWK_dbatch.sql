 create procedure PJTRANWK_dbatch @parm1 varchar (6), @parm2 varchar (2), @parm3 varchar (10), @parm4 varchar (16)  as
delete from PJTRANWK
    where alloc_batch = ' ' and
    fiscalno = @parm1 and
    system_cd = @parm2 and
    batch_id = @parm3 and
    project = @parm4


