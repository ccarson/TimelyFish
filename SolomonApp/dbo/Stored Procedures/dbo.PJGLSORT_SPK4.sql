 create procedure PJGLSORT_SPK4 as
Select * from PJGLSORT
order by  cpnyid, source_pjt_entity, gl_acct, gl_subacct, project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJGLSORT_SPK4] TO [MSDSL]
    AS [dbo];

