 create procedure PJLABDLY_init
as
select * from PJLABDLY
where    docnbr     =  'Z'
	 and	ldl_siteid = 'Z'
	 and	linenbr = 9



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDLY_init] TO [MSDSL]
    AS [dbo];

