 Create Proc PJPOOLS_spk9 @parm1 varchar (6), @parm2 varchar (10), @parm3 varchar (24), @parm4 varchar (10), @parm5 varchar(6) as
select *  from  PJPOOLS
where
 period = @parm1 and
 gl_acct = @parm2 and
 gl_subacct = @parm3 and
 cpnyid = @parm4 and
 grpid = @parm5



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPOOLS_spk9] TO [MSDSL]
    AS [dbo];

