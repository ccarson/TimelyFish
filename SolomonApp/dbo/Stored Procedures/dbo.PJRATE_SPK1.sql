 create procedure PJRATE_SPK1  @parm1 varchar (4) , @parm2 varchar (2) , @parm3 varchar (1)   as
       select  rate_table_id, rate_type_cd, count(*)
       from    PJRATE
       where   rate_table_id   =  @parm1
       and     rate_type_cd    =  @parm2
       and     rate_level      =  @parm3
       Group by rate_table_id, rate_type_cd



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRATE_SPK1] TO [MSDSL]
    AS [dbo];

