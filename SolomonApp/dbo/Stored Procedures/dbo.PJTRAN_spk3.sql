 create procedure PJTRAN_spk3 @parm1 varchar (6) , @parm2 varchar (2) , @parm3 varchar (10) , @parm4 int    as
select * from PJTRAN
where fiscalno	     = @parm1  and
	  system_cd  = @parm2  and
	  batch_id      = @parm3  and
	  detail_num = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_spk3] TO [MSDSL]
    AS [dbo];

