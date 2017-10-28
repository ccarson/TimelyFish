 create procedure PJPTDROL_uZeroAct @parm1 varchar (16)  as
Update PJPTDROL set
act_amount = 0,
ProjCury_act_amount = 0,
act_units = 0
WHERE
project like @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_uZeroAct] TO [MSDSL]
    AS [dbo];

