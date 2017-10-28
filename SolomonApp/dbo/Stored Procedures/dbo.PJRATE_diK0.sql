 create procedure PJRATE_diK0  @parm1 varchar (4) , @parm2 varchar (2) , @parm3 varchar (1) , @parm4 varchar (32) , @parm5 varchar (32) , @parm6 smalldatetime   as
       delete from PJRATE
       where rate_table_id =  @parm1
       and rate_type_cd    =  @parm2
       and rate_level      =  @parm3
       and rate_key_value1 =  @parm4
       and rate_key_value2 =  @parm5
       and effect_date     <= @parm6



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRATE_diK0] TO [MSDSL]
    AS [dbo];

