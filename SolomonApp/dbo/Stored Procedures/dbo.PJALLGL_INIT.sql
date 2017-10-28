 create procedure PJALLGL_INIT as
select * from PJALLGL
where
alloc_batch    = ' ' and
glsort_key     = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLGL_INIT] TO [MSDSL]
    AS [dbo];

