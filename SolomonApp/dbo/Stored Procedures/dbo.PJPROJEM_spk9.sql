 create procedure PJPROJEM_spk9 as
select * from pjprojem
where pjprojem.project = 'Z'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEM_spk9] TO [MSDSL]
    AS [dbo];

