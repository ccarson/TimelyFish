 create procedure PJCODE_SPK2  @parm1 varchar (4)   as
select * from PJCODE
where    code_type    =    @parm1
order by code_type,
code_value



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCODE_SPK2] TO [MSDSL]
    AS [dbo];

