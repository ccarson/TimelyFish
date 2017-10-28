 create procedure PJGLSORT_SPK2 as
Select * from PJGLSORT
order by  cpnyid, gl_acct, gl_subacct, project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJGLSORT_SPK2] TO [MSDSL]
    AS [dbo];

