 create procedure PJCODE_SDATA1  @parm1 varchar (4) , @parm2 varchar (30) , @parm3 varchar (30) as
select * from PJCODE
where    code_type    =    @parm1
and    data1 like @parm2
and   code_value like @parm3
order by code_value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCODE_SDATA1] TO [MSDSL]
    AS [dbo];

