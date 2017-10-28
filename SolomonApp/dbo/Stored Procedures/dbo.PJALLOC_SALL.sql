 create procedure PJALLOC_SALL  @parm1 varchar (4)   as
select * from PJALLOC
where    alloc_method_cd LIKE @parm1
order by alloc_method_cd ,
step_number



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLOC_SALL] TO [MSDSL]
    AS [dbo];

