 create procedure PJGLSORT_INIT as
select * from PJGLSORT
where
glsort_key     = 999999999



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJGLSORT_INIT] TO [MSDSL]
    AS [dbo];

