 create procedure PJTRANEX_spk0 @parm1 varchar (6) , @parm2 varchar (2) , @parm3 varchar (10) , @parm4 int   as
select * from PJTRANEX
where FISCALNO        = @parm1 and
SYSTEM_CD       = @parm2 and
BATCH_ID        = @parm3 and
DETAIL_NUM      = @parm4


