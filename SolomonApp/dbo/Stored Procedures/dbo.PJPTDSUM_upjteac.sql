 create procedure PJPTDSUM_upjteac @parm1 varchar (16)   as
Update PJPTDSUM
SET eac_amount = 0,
ProjCury_eac_amount = 0,
eac_units = 0
WHERE
project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_upjteac] TO [MSDSL]
    AS [dbo];

