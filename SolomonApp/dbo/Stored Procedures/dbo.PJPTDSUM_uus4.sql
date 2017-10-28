 create procedure  PJPTDSUM_uus4
as
update PJPTDSUM
set com_amount = 0,
    com_units  = 0,
    ProjCury_com_amount = 0
where com_amount <> 0 or com_units <> 0 or ProjCury_com_amount = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_uus4] TO [MSDSL]
    AS [dbo];

