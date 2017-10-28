 create procedure PCSETUP_SPK0 as
select * from PCSETUP
order by setupid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PCSETUP_SPK0] TO [MSDSL]
    AS [dbo];

