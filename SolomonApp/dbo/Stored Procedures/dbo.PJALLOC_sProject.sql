 create procedure PJALLOC_sProject  @parm1 varchar (16)   as
select * from PJALLOC
where
post_project = @parm1 or
offset_project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLOC_sProject] TO [MSDSL]
    AS [dbo];

