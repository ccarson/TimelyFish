 create procedure ARSETUP_SPK0 as
select * from ARSETUP
where    setupid = 'AR'
order by setupid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARSETUP_SPK0] TO [MSDSL]
    AS [dbo];

