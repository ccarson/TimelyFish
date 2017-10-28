 create procedure ARSETUP_SPK0NL as
select * from ARSETUP (NOLOCK)
where    setupid = 'AR'
order by setupid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARSETUP_SPK0NL] TO [MSDSL]
    AS [dbo];

