 create procedure  PJTRAN_ustat @parm1 varchar (10) , @parm2 varchar (8) , @parm3 varchar (6) , @parm4 varchar (6) , @parm5 varchar (2) , @parm6 varchar (10) , @parm7 int   as
update PJTRAN
set tr_status = @parm1,
lupd_datetime = getdate(),
lupd_user = @parm2,
lupd_prog = @parm3
where PJTRAN.fiscalno =  @parm4 and
PJTRAN.system_cd = @parm5 and
PJTRAN.batch_id = @parm6 and
PJTRAN.detail_num =  @parm7


