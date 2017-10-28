 create procedure PJRATE_sRKeys  @parm1  varchar (32) as
Select * from PJRATE
where
rate_key_value1 =  @parm1 or
rate_key_value2 =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRATE_sRKeys] TO [MSDSL]
    AS [dbo];

