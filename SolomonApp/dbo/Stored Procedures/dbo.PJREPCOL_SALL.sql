 create procedure PJREPCOL_SALL @parm1 varchar (10) , @parm2beg smallint ,@parm2end smallint ,  @parm3 varchar (16) , @parm4 varchar (10)   as
select * from PJREPCOL
where report_code  LIKE  @parm1
and column_nbr  between  @parm2beg and @parm2end
and acct         like     @parm3
and gl_acct      like     @parm4
order by report_code,
column_nbr,
acct,
gl_acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJREPCOL_SALL] TO [MSDSL]
    AS [dbo];

