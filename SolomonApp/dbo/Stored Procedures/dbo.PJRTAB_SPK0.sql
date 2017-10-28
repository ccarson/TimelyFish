 create procedure PJRTAB_SPK0  @parm1 varchar (4) , @parm2 varchar (2)   as
       select * from PJRTAB
       where    rate_table_id    =    @parm1
       and      rate_type_cd     =    @parm2
       order by rate_table_id, rate_type_cd



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRTAB_SPK0] TO [MSDSL]
    AS [dbo];

