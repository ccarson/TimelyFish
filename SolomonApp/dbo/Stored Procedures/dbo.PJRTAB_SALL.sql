 create procedure PJRTAB_SALL  @parm1 varchar (4) , @parm2 varchar (2)   as
       select * from PJRTAB
       where    rate_table_id  LIKE @parm1
       and      rate_type_cd   LIKE @parm2
       order by
              rate_table_id, rate_type_cd



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRTAB_SALL] TO [MSDSL]
    AS [dbo];

