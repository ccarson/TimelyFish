 create procedure PJPTDROL_upjtfac @parm1 varchar (16)   as
Update PJPTDROL
SET fac_amount = 0,
ProjCury_fac_amount = 0,
fac_units = 0
WHERE
project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_upjtfac] TO [MSDSL]
    AS [dbo];

