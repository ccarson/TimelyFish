Create procedure [dbo].[PJRATE_SPK2]  @parm1 varchar (4) , @parm2 varchar (2) , @parm3 varchar (1) , @parm4 varchar (32) , @parm5 varchar (32) , @parm6 varchar (32) , @parm7 smalldatetime   as
       select * from PJRATE, PJCODE
       where PJRATE.rate_table_id   =  @parm1
       and   PJRATE.rate_type_cd    =  @parm2
       and   PJRATE.rate_level      =  @parm3
       and   PJRATE.rate_key_value1 =  @parm4
       and   PJRATE.rate_key_value2 =  @parm5
       and   PJRATE.rate_key_value3 =  @parm6
       and   PJRATE.effect_date     <= @parm7
       and   PJCODE.code_type      =    'RATE'
       and   PJCODE.code_value     =    PJRATE.rate_type_cd
       order by
              PJRATE.rate_table_id,
              PJRATE.rate_type_cd,
              PJRATE.rate_level,
             PJRATE. rate_key_value1,
           PJRATE.rate_key_value2,
             PJRATE.rate_key_value3,
              PJRATE.effect_date desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRATE_SPK2] TO [MSDSL]
    AS [dbo];

