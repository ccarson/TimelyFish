 create procedure INVPROJALLOC_CNT  as
select count(*) from InvProjAlloc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INVPROJALLOC_CNT] TO [MSDSL]
    AS [dbo];

