 create procedure PJCODE_SBMM  @parm1 varchar (4) , @parm2 varchar (30)   as
select * from PJCODE
where    code_type    =    @parm1
and    code_value  = @parm2
and    code_value <> 'ARBI'
order by code_type,
code_value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCODE_SBMM] TO [MSDSL]
    AS [dbo];

