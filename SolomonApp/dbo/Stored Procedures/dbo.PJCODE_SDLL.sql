 create procedure PJCODE_SDLL  @parm1 varchar (4) , @parm2 varchar (30)   as
select code_value_desc from PJCODE
where    code_type    =    @parm1
and    code_value  = @parm2
order by code_type,
code_value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCODE_SDLL] TO [MSDSL]
    AS [dbo];

