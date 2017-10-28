 create procedure GLSETUP_SPK0 as
select * from GLSETUP
where    setupid = 'GL'
order by setupid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLSETUP_SPK0] TO [MSDSL]
    AS [dbo];

