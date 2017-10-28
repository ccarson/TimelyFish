 create procedure PJBSREV_SPJTSCHD  @parm1 varchar (16) , @parm2 varchar (6),  @parm3beg smallint , @parm3end smallint  as
select * from PJBSREV
where    project = @parm1 and
schednbr = @parm2
and linenbr  between  @parm3beg and @parm3end
order by project, schednbr, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBSREV_SPJTSCHD] TO [MSDSL]
    AS [dbo];

