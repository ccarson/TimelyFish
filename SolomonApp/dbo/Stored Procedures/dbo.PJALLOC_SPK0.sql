 create procedure PJALLOC_SPK0  @parm1 varchar (4)   as
select * from PJALLOC
where    alloc_method_cd = @parm1
order by alloc_method_cd ,
step_number



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLOC_SPK0] TO [MSDSL]
    AS [dbo];

