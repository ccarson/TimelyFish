
CREATE PROCEDURE [dbo].[PJALLOC_post_acct] @parm1 VARCHAR (4) AS
select PJALLOC.*, PJACCT.* from PJALLOC with (nolock)
left join PJACCT with (nolock)
on PJACCT.acct = PJALLOC.post_acct
where PJALLOC.alloc_method_cd = @parm1
order by PJALLOC.alloc_method_cd, PJALLOC.step_number


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLOC_post_acct] TO [MSDSL]
    AS [dbo];

