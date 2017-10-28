 create procedure PJRTAB_SALLOC  @parm1 varchar (16)   as
       select distinct
              p.rate_table_id,
              a.rate_type_cd,
              l1_rate_key1_cd, l1_rate_key2_cd,
              l2_rate_key1_cd, l2_rate_key2_cd,
              l3_rate_key1_cd, l3_rate_key2_cd,
              l4_rate_key1_cd, l4_rate_key2_cd,
              l5_rate_key1_cd, l5_rate_key2_cd,
              l6_rate_key1_cd, l6_rate_key2_cd,
              l7_rate_key1_cd, l7_rate_key2_cd,
              l8_rate_key1_cd, l8_rate_key2_cd,
              l9_rate_key1_cd, l9_rate_key2_cd
from 	pjproj p, pjalloc a, pjrtab t
where
              p.project         =  @parm1
and           p.alloc_method_cd <> ' '
and           p.rate_table_id   <> ' '
and           p.alloc_method_cd =  a.alloc_method_cd
and           p.rate_table_id   =  t.rate_table_id
and           a.rate_type_cd    =  t.rate_type_cd



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRTAB_SALLOC] TO [MSDSL]
    AS [dbo];

