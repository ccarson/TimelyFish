
create procedure PJCODE_SPK0_w  @parm1 varchar (4) , @parm2 varchar (30)   as
select code_value, data1, data2 from PJCODE
where    code_type    =    @parm1
and    code_value  = @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCODE_SPK0_w] TO [MSDSL]
    AS [dbo];

