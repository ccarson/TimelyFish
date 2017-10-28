 create procedure PJRATE_spartky1  @parm1 varchar (4) , @parm2 varchar (2) , @parm3 varchar (1), @parm4 varchar (32)  as
       select * from PJRATE
       where rate_table_id   =  @parm1
       and   rate_type_cd    =  @parm2
       and   rate_level      =  @parm3
	 and   rate_key_value1 =  @parm4
       order by
              rate_table_id,
              rate_type_cd,
              rate_level,
              rate_key_value1,
              rate_key_value2,
              effect_date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRATE_spartky1] TO [MSDSL]
    AS [dbo];

