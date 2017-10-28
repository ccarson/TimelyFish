 create procedure  PJRTAB_sCuryid  @parm1 varchar (4)   as
select distinct(pjcode.data1) from pjrtab, pjcode
 where pjrtab.rate_table_id = @parm1 and
       pjcode.code_type = 'RATE' and
       pjrtab.rate_type_cd = pjcode.code_value and
       pjcode.data1 <> ' '



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRTAB_sCuryid] TO [MSDSL]
    AS [dbo];

