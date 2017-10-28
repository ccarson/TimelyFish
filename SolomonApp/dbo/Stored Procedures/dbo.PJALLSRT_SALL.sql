 create procedure PJALLSRT_SALL  @parm1 varchar (10), @parm2 varchar (16)  as
select * from PJALLSRT
where alloc_batch = @parm1 and
      src_project = @parm2
order by alloc_batch, src_project, project, pjt_entity, acct, cpnyid, employee, gl_subacct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLSRT_SALL] TO [MSDSL]
    AS [dbo];

