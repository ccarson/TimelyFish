 create procedure PRSETUP_SPK0 as
select * from PRSETUP
where    setupid = 'PR'
order by setupid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRSETUP_SPK0] TO [MSDSL]
    AS [dbo];

