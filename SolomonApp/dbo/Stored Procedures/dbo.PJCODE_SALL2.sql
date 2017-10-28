 create procedure PJCODE_SALL2  @parm1 varchar (4) , @parm2 varchar (30)   as
select * from PJCODE
where    code_type    LIKE @parm1
and    code_value   LIKE @parm2
order by code_type,
code_value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCODE_SALL2] TO [MSDSL]
    AS [dbo];

