 create procedure PJCODE_SPK0  @parm1 varchar (4) , @parm2 varchar (30)   as
select * from PJCODE
where    code_type    =    @parm1
and    code_value  = @parm2
order by code_type,
code_value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCODE_SPK0] TO [MSDSL]
    AS [dbo];

