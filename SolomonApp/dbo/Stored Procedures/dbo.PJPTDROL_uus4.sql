 create procedure  PJPTDROL_uus4
as
update PJPTDROL
set com_amount = 0,
    com_units  = 0,
    ProjCury_com_amount = 0
where com_amount <> 0 or com_units <> 0 or ProjCury_com_amount = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_uus4] TO [MSDSL]
    AS [dbo];

