﻿ create procedure PJRATE_SPK0  @parm1 varchar (4) , @parm2 varchar (2) , @parm3 varchar (1) , @parm4 varchar (32) , @parm5 varchar (32) , @parm6 varchar (32) , @parm7 smalldatetime   as
       select * from PJRATE
       where rate_table_id   =  @parm1
       and   rate_type_cd    =  @parm2
       and   rate_level      =  @parm3
       and   rate_key_value1 =  @parm4
       and   rate_key_value2 =  @parm5
       and   rate_key_value3 =  @parm6
       and   effect_date     <= @parm7
       order by
              rate_table_id,
              rate_type_cd,
              rate_level,
              rate_key_value1,
              rate_key_value2,
              rate_key_value3,
              effect_date desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRATE_SPK0] TO [MSDSL]
    AS [dbo];

