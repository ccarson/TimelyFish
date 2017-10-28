 create procedure PJALLOC_SPK1  @parm1 varchar (4) ,@parm2beg smallint ,@parm2end smallint   as
select * from PJALLOC
where    alloc_method_cd = @parm1 and
step_number between @parm2beg and @parm2end
order by alloc_method_cd , step_number



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLOC_SPK1] TO [MSDSL]
    AS [dbo];

