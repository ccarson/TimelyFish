 create procedure PJTRAN_upk @parm1 varchar (6) , @parm2 varchar (2) , @parm3 varchar (10) , @parm4 int    as
update PJTRAN
set alloc_flag = 'A'
where fiscalno       = @parm1  and
          system_cd  = @parm2  and
          batch_id      = @parm3  and
          detail_num = @parm4


